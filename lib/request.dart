import 'package:http/http.dart' as http;
import 'dart:convert';

class Requst {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  postRequest(String url, Map data) async {
    try {
      print(data);
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
