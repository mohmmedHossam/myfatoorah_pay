part of myfatoorah_pay;

class _WebViewPage extends StatefulWidget {
  final Uri uri;
  final PreferredSizeWidget Function(BuildContext context)? getAppBar;
  final AfterPaymentBehaviour afterPaymentBehaviour;
  final MyfatoorahRequest myFatoorahRequest;


  const _WebViewPage({
    Key? key,
    required this.uri,
    required this.afterPaymentBehaviour,
    required this.myFatoorahRequest,
    this.getAppBar,
  }) : super(key: key);

  @override
  __WebViewPageState createState() => __WebViewPageState();
}

class __WebViewPageState extends State<_WebViewPage>
    with TickerProviderStateMixin {
  late InAppWebViewController controller;
  double? progress = 0;
  PaymentResponse response = PaymentResponse(PaymentStatus.None);

  Future<bool> popResult() async {
    if (response.status == PaymentStatus.None && await controller.canGoBack()) {
      controller.goBack();
    } else {
      Navigator.of(context).pop(response);
    }
    return false;
  }

  int timerCount = 3;

  //bool success = false, failed = false;

  String? message;

  void setStart(Uri? uri, InAppWebViewController controller) async {
    response = await _getResponse(uri, controller);
    assert((() {
      return true;
    })());
    if (!response.isNothing &&
        widget.afterPaymentBehaviour ==
            AfterPaymentBehaviour.BeforeCallbackExecution) {
      Navigator.of(context).pop(response);
    } else {
      setState(() {
        progress = 0;
      });
    }
  }

  void setError(Uri? uri, String message,
      InAppWebViewController controller) async {
    response = await _getResponse(uri, controller);
    assert((() {
      return true;
    })());
    if (!response.isNothing &&
        widget.afterPaymentBehaviour ==
            AfterPaymentBehaviour.BeforeCallbackExecution) {
      Navigator.of(context).pop(response);
    } else {
      setState(() {
        progress = 0;
      });
    }
  }

  void setStop(Uri? uri, InAppWebViewController controller,
      bool loadStop) async {
    response = await _getResponse(uri, controller);
    if (response.status != PaymentStatus.None && loadStop) {
      startTimer(response, loadStop);
    }
    assert((() {
      return true;
    })());
    if (!response.isNothing &&
        widget.afterPaymentBehaviour ==
            AfterPaymentBehaviour.AfterCallbackExecution) {
      Navigator.of(context).pop(response);
    } else {
      setState(() {
        progress = null;
      });
    }
  }

  void setProgress(int v) {
    setState(() {
      progress = v / 100;
    });
  }

  void onBack() {}

  late Timer _timer;
  int _start = 3;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer(response, loadStop) {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
            timer.cancel();
            popResult();
        } else {
          setState(() {
            _start--;
            message = 'Redirect on $_start secound';
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: popResult,
      child: Scaffold(appBar: AppBar(centerTitle: true,
        title: Text(message ?? ''),
        backgroundColor: Colors.blueAccent,), body: _stack(context)),
    );
  }

  Widget _stack(BuildContext context) {
    Widget? child;

    return Stack(
      fit: StackFit.expand,
      children: [
        _build(context),
        Positioned.fill(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: AnimatedOpacity(
            opacity: child == null ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            child: child ?? const SizedBox(),
          ),
        ),
      ],
    );
  }

  Widget _build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              height: progress == null ? 0 : 5,
              child: LinearProgressIndicator(value: progress ?? 0),
            ),
          ),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: widget.uri),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  javaScriptCanOpenWindowsAutomatically: true,
                ),
                ios: IOSInAppWebViewOptions(
                  applePayAPIEnabled: true,
                ),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                this.controller = controller;
              },
              onLoadStart: (InAppWebViewController controller, Uri? uri) {
                setStart(uri, controller);
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {},
              onLoadError: (InAppWebViewController controller, Uri? uri,
                  int status, String error) {
                setError(uri, error, controller);
              },
              onLoadHttpError: (InAppWebViewController controller, Uri? uri,
                  int status, String error) {
                setError(uri, error, controller);
              },
              onLoadStop: (InAppWebViewController controller, Uri? uri) {
                setStop(uri, controller, true);
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setProgress(progress);
              },
              onAjaxProgress:
                  (InAppWebViewController controller, request) async {
                var e = request.event;
                if (e != null) {
                  var p = (e.loaded! ~/ e.total!) * 100;
                  setProgress(p);
                }
                return request.action!;
              },
              onAjaxReadyStateChange:
                  (InAppWebViewController controller, request) async {
                if (request.readyState == AjaxRequestReadyState.OPENED) {
                  setStart(request.url, controller);
                } else {
                  setStop(request.url, controller, false);
                }
                return request.action;
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<PaymentResponse> _getResponse(Uri? uri,
      InAppWebViewController controller) async {
    if (uri == null) {
      return PaymentResponse(
        PaymentStatus.None,
        paymentId: null,
        url: null,
      );
    } else {

      if (uri
          .toString()
          .contains('https://demo.myfatoorah.com/En/KWT/PayInvoice/Result')) {

         /* await controller
              .evaluateJavascript(
              source:
              "document.getElementsByClassName('white-text')[0]['outerText'];"
          )
              .then((value) async {
            setState(() {
              message = 'Redirect on $_start secound';
            });
            if (value.toString().contains('PAID')) {
              return PaymentResponse(
                PaymentStatus.Success,
                paymentId: uri.queryParameters["paymentId"],
                url: uri.toString(),
              );
            } else {
              return PaymentResponse(
                PaymentStatus.Error,
                paymentId: uri.queryParameters["paymentId"],
                url: uri.toString(),
              );
            }
          });*/

        var res = await  http.post(Uri.parse("${widget.myFatoorahRequest.url}/v2/GetPaymentStatus"),
            body: {
              "Key": uri.queryParameters["paymentId"],
              "KeyType": "PaymentId",
            },
            headers: {
              "Authorization": "Bearer ${widget.myFatoorahRequest.token}"
            });

        if(res.statusCode == 200){
          GetPaymentsStatus getPaymentsStatus =  getPaymentsStatusFromJson(res.body);
          if(getPaymentsStatus.data.invoiceStatus == "Paid"){
            return PaymentResponse(
              PaymentStatus.Success,
              paymentId: uri.queryParameters["paymentId"],
              url: uri.toString(),
            );
          }else if (getPaymentsStatus.data.invoiceTransactions[0].transactionStatus == "Succss"){
            return PaymentResponse(
              PaymentStatus.Success,
              paymentId: uri.queryParameters["paymentId"],
              url: uri.toString(),
            );
          }else {
            setState(() {
              // failed = true;
              message = 'Redirect on $_start secound';
            });
            return PaymentResponse(
              PaymentStatus.Error,
              paymentId: uri.queryParameters["paymentId"],
              url: uri.toString(),
            );
          }
        }

        setState(() {
          // failed = true;
          message = 'Redirect on $_start secound';
        });
        return PaymentResponse(
          PaymentStatus.Error,
          paymentId: uri.queryParameters["paymentId"],
          url: uri.toString(),
        );

      }
    }

    return PaymentResponse(
      PaymentStatus.None,
      paymentId: null,
      url: uri.toString(),
    );
  }
}
