import 'package:flutter/material.dart';

const String domain = 'https://skill-test.retinasoft.com.bd';
const String baseUrl = '$domain/api/v1';

const bool useInterceptor = true;

const String branchKey = "branchKey";
const String signUpRes = "signUpRes";
const String logInRes = "logInRes";
const String dataSettingsKey = "dataSettingsKey";
const String accessToken = "accessToken";

const Color primaryColor = Color(0xff095083);
const Color primaryAccentColor = Color(0xFF80D6FF); // Adjusted for accent
const Color lightBackgroundColor = Color(0xFFFFFFFF);
const Color darkBackgroundColor = Color(0xFF121212);
const Color lightTextColor = Color(0xFF000000);
const Color darkTextColor = Color(0xFFFFFFFF);

Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}

const textData =
    "PCS’ing to Mobile? We have a beautiful 4/2.5 ba home in W Mobile’s Alderbrook Subdv. available for rent. On nearly 1 acre, the home offers 2300 sf, 2 car atta garage, new washer/dryer & refrigerator, new roof, new carpet in bedrooms (hardwood floors elsewhere), remodeled kitchen and bathrooms w stone tops, fresh paint inside and out plus gas fireplace. High in demand Schools; Hutchens/Dawes, Causey & Baker! Only minutes to ATC Mobile and shopping. Rental rate is \$2250. Available May 1 or later depending on your needs. Landscaping is a work in progress so don’t let it be a deterent:). Call or text 619.339.6607 viewing and/or questions. Time Open House 15 May 2024 12:00 pm To 29 May 2024 12:00 pm Rental rate is \$2250. Available May 1 or later depending on your needs. Landscaping is a work in progress so don’t let it be a deterent:).";

const homeImage = "https://i.ibb.co/XVBDh7M/background.jpg";

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
