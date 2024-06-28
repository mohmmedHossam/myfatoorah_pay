part of myfatoorah_pay;

enum MFCountry {
  Kuwait,
  SaudiArabia,
  Bahrain,
  UAE,
  Qatar,
  Oman,
  Jordan,
  Egypt,
}

Map<MFCountry, String> _currencies = {
  MFCountry.Kuwait: "KWD",
  MFCountry.SaudiArabia: "SAR",
  MFCountry.Bahrain: "BHD",
  MFCountry.UAE: "AED",
  MFCountry.Qatar: "QAR",
  MFCountry.Oman: "OMR",
  MFCountry.Jordan: "JOD",
  MFCountry.Egypt: "EGY",
};

Map<MFCountry, String> mobiles = {
  MFCountry.Kuwait: "+965",
  MFCountry.SaudiArabia: "+966",
  MFCountry.Bahrain: "+973",
  MFCountry.UAE: "+971",
  MFCountry.Qatar: "+974",
  MFCountry.Oman: "+968",
  MFCountry.Jordan: "+962",
  MFCountry.Egypt: "+20",
};
