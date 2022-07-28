part of myfatoorah_pay;

class _WebViewPage extends StatefulWidget {
  final Uri uri;
  final PreferredSizeWidget Function(BuildContext context)? getAppBar;
  final AfterPaymentBehaviour afterPaymentBehaviour;
  final Widget? errorChild;
  final Widget? successChild;

  const _WebViewPage({
    Key? key,
    required this.uri,
    required this.afterPaymentBehaviour,
    this.errorChild,
    this.successChild,
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

  bool show = false;
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

  void setError(
      Uri? uri, String message, InAppWebViewController controller) async {
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

  void setStop(
      Uri? uri, InAppWebViewController controller, bool loadStop) async {
    response = await _getResponse(uri, controller);

    Future.delayed(const Duration(seconds: 9), () {
      if (response.status != PaymentStatus.None && loadStop) {
        popResult();
      }
    });

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


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: popResult,
      child: Scaffold( appBar: AppBar(leading : Container() ,centerTitle: true, title: Text(message??''),),body: _stack(context)),
    );
  }

  Widget _stack(BuildContext context) {
    if (widget.successChild == null && widget.errorChild == null) {
      return _build(context);
    }
    Widget? child;
    if (response.isSuccess && widget.successChild != null) {
      child = Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: widget.successChild,
      );
    } else if (response.isError && widget.errorChild != null) {
      child = Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: widget.errorChild,
      );
    }
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
            duration: Duration(milliseconds: 300),
            child: child ?? SizedBox(),
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
            duration: Duration(milliseconds: 300),
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
              onAjaxProgress: (InAppWebViewController controller, request) async {
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

  Future<PaymentResponse> _getResponse(
      Uri? uri, InAppWebViewController controller) async {
    PaymentResponse? paymentResponse;
    if (uri == null) {
      paymentResponse = PaymentResponse(
        PaymentStatus.None,
        paymentId: null,
        url: null,
      );
    } else {
      if (uri
          .toString()
          .contains('https://demo.myfatoorah.com/En/KWT/PayInvoice/Result')) {
        await controller
            .evaluateJavascript(
                source:
                    "document.getElementsByClassName('white-text')[0]['outerText'];")
            .then((value) {
          if (value.toString().contains('PAID')) {
            var isSuccess = true;
            var isError = false;
            PaymentStatus status = isSuccess && !isError
                ? PaymentStatus.Success
                : PaymentStatus.Error;
            setState((){
              message = 'Redirect on 5 secound';
            });
            paymentResponse = PaymentResponse(
              status,
              paymentId: uri.queryParameters["paymentId"],
              url: uri.toString(),
            );
          } else {
            var isSuccess = false;
            var isError = true;
            setState((){
              message = 'Redirect on 5 secound';
            });
            PaymentStatus status = isSuccess && !isError
                ? PaymentStatus.Success
                : PaymentStatus.Error;
            paymentResponse = PaymentResponse(
              status,
              paymentId: uri.queryParameters["paymentId"],
              url: uri.toString(),
            );
          }
        });
      }
    }
    return paymentResponse ??
        PaymentResponse(
          PaymentStatus.None,
          paymentId: null,
          url: uri.toString(),
        );
  }
}
