import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sigs_certifica_app/data/services/notifications/local/local_notification_service.dart';
import 'package:sigs_certifica_app/routes.dart';

class FirebaseNotificationService {
  final LocalNotificationService localNotificationService;

  FirebaseNotificationService({required this.localNotificationService});

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    getDeviceFirebaseToken();
    _onMessage();
    _onMessageOpenedApp();
  }

  getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken(
        //vapidKey: "BC7XG47azAsRSU0l-5pT6GwHJQbzbkT0-CrIFPuxPLbmgahceEZV-U7vrawws-760KpDVRckw1MF-nylhq5Vwt",
        );
    debugPrint('=======================================');
    debugPrint('TOKEN: $token');
    debugPrint('=======================================');
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        localNotificationService.showSimpleNotification(
          title: notification.title!,
          body: notification.body!,
          payload: message.data['route'] ?? '',
        );
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message) {
    final String route = message.data['route'] ?? '';
    if (route.isNotEmpty) {
      routes.go('/notifications', extra: route);
    }
  }
}
