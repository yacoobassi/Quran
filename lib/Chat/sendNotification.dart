import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class sendNot {
  static Future<void> sendPushNotification(
    String token,
    String title,
    String body,
    String senderId,
  ) async {
    try {
      await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              "key=AAAAqaAqqu4:APA91bF3kjgGn6QyE1zF6QH_eA6OK5-P_S8cpql0hiRA3BeAWVS3e7IpGFzXm3su5flB9219F-j3ehHc3vF_ZSd60mTP3GZ8WOLoaobwwrFpreyDcrp5AAwgt_8wkO_7IK6Cx944MvrR"
        },
        body: jsonEncode({
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': senderId,
            'body': body,
            'title': title
          },
          'notification': {
            'title': title,
            'body': body,
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            "content_available": true,
            "mutable_content": true,
            'badge': '2'
          },
          "to": token,
        }),
      );
    } catch (e) {
      print("Error sending notification: $e");
    }
  }
}
