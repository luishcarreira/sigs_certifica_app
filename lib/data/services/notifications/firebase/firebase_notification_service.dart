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
    await _getDeviceFirebaseToken();
    _setupMessageHandlers();
  }

  Future<void> _getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('Firebase Token: $token');
  }

  void _setupMessageHandlers() {
    // Handler para notificações recebidas enquanto o app está aberto
    FirebaseMessaging.onMessage.listen((message) {
      _handleForegroundMessage(message);
    });

    // Handler para notificações que abriram o app
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Verificar se o app foi aberto a partir de uma notificação
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleMessageOpenedApp(message);
      }
    });
  }

  void _handleForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      localNotificationService.showSimpleNotification(
        title: notification.title ?? 'No Title',
        body: notification.body ?? 'No Body',
        payload: message.data['route'] ?? '',
      );
    }
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    final route = message.data['route'] ?? '';
    if (route.isNotEmpty) {
      routes.go('/notifications', extra: route);
    }
  }
}
