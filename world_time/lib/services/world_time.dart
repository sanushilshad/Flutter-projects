import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  String? url;
  String? flag;
  String? time;
  bool? isDaytime;
  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
        Response response =
            await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
        Map data = jsonDecode(response.body);
        // print(data);
        String dateTime = data['datetime'];
        String offset = data['utc_offset'].substring(1, 3);
        DateTime now = DateTime.parse(dateTime);
        now = now.add(Duration(hours: int.parse(offset)));
        isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
        time = DateFormat.jm().format(now);
    } catch (e) {
      print("Exception Occured");
      time = "Could not load the data";
    }
    // Future.delayed(Duration(seconds: 3), () {
    //   print('a');
    // });
  }
}
