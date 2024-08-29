import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:signals/signals.dart';
import 'package:sigs_certifica_app/data/services/notifications/local/dtos/custom_notification_dto.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  LocalNotificationService({required this.flutterLocalNotificationsPlugin}) {
    _setupAndroidDetails();
  }

  _setupAndroidDetails() {
    androidDetails = const AndroidNotificationDetails(
      'lembretes_notifications_details',
      'Lembretes',
      channelDescription: 'Este canal é para lembretes!',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );
  }

  final didReceiveLocalNotificationStream = signal(
    StreamController<CustomNotificationDTO>.broadcast(),
    debugLabel: "didReceiveLocalNotificationStream",
  );

  final selectNotificationStream = signal(
    StreamController<String?>.broadcast(),
    debugLabel: "selectNotificationStream",
  );

  // Função de nível superior para lidar com notificações em segundo plano
  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    print('Notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      print(
          'Notification action tapped with input: ${notificationResponse.input}');
    }
  }

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.value.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            selectNotificationStream.value.add(notificationResponse.payload);
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  // Método para exibir notificações simples
  Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin
        .show(1, title, body, notificationDetails, payload: payload);
  }

  // Método para exibir notificações periódicas
  Future<void> showPeriodicNotifications({
    required String title,
    required String body,
    required String payload,
  }) async {
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.periodicallyShow(
        2, title, body, RepeatInterval.everyMinute, notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload);
  }

  // Método para exibir notificações agendadas
  Future<void> showScheduleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
        3,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        NotificationDetails(android: androidDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);
  }

  // Cancelar notificação específica
  Future<void> cancel(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // Cancelar todas as notificações
  Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
