import 'package:flutter/material.dart';

// list of colors that we use in our app
const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF035AA6);
const kSecondaryColor = Color(0xFFFFA41B);
const kTextColor = Color(0xFF000839);
const kTextLightColor = Color(0xFF747474);
const kBlueColor = Color(0xFF40BAD5);

final korange = const Color(0xFFFF9933);
final korangelite = const Color(0xFFFFBE83);
final kwhite = const Color(0xFFFFFFFF);
final kdarkBlue= const Color(0xFF333366);
final kblack = const Color(0xFF000000);
final kgreyDark =  Colors.grey.shade700;
final kgreyFill =  Colors.grey.shade100;

const kDefaultPadding = 20.0;

// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);

// Texts
const String POPPINS = "Poppins";
const String OPEN_SANS = "OpenSans";
const String SKIP = "Skip";
const String NEXT = "Next";
const String SLIDER_HEADING_1 = "Fast Travel!";
const String SLIDER_HEADING_2 = "Easy to Use!";
const String SLIDER_HEADING_3 = "Safest Option";
const String SLIDER_DESC = "Live the best and easiest traveling experience with us,the fastest and most reliable option you can ever find.";

String dateAsTitle(DateTime date) {
  String month = 'Jan';
  switch(date.month) {
    case 1:
      month = 'Jan';
      break;
    case 2:
      month = 'Feb';
      break;
    case 3:
      month = 'Mar';
      break;
    case 4:
      month = 'Apr';
      break;
    case 5:
      month = 'May';
      break;
    case 6:
      month = 'Jun';
      break;
    case 7:
      month = 'Jul';
      break;
    case 8:
      month = 'Aug';
      break;
    case 9:
      month = 'Sep';
      break;
    case 10:
      month = 'Oct';
      break;
    case 11:
      month = 'Nov';
      break;
    case 12:
      month = 'Dec';
      break;
    default:
      month = 'Jan';
  }
  return month + ' ' + date.day.toString() + ', ' + date.year.toString();
}

String dateAsFileName(DateTime date) {
  String month = 'Jan';
  switch(date.month) {
    case 1:
      month = 'Jan';
      break;
    case 2:
      month = 'Feb';
      break;
    case 3:
      month = 'Mar';
      break;
    case 4:
      month = 'Apr';
      break;
    case 5:
      month = 'May';
      break;
    case 6:
      month = 'Jun';
      break;
    case 7:
      month = 'Jul';
      break;
    case 8:
      month = 'Aug';
      break;
    case 9:
      month = 'Sep';
      break;
    case 10:
      month = 'Oct';
      break;
    case 11:
      month = 'Nov';
      break;
    case 12:
      month = 'Dec';
      break;
    default:
      month = 'Jan';
  }
  return month + '_' + date.day.toString() + '_' + date.year.toString();
}

