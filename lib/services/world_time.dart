import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // Location Name for UI
  String time; // te time in that location
  String flag; // url to an flag asset icon
  String url; // location url for api endpoint
  bool isDaytime; // whether day time or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // Make the request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['datetime'];
      String offsetH = data['utc_offset'].substring(1, 3);
      String offsetM = data['utc_offset'].substring(4, 6);

      // creating a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(hours: int.parse(offsetH), minutes: int.parse(offsetM)));

      // set the time
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught Error: $e');
      time = "Could not get time data..";
    }
  }
}
