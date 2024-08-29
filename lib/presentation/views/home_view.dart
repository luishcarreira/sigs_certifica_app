import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals.dart';
import 'package:sigs_certifica_app/data/services/notifications/firebase/firebase_notification_service.dart';
import 'package:sigs_certifica_app/data/services/notifications/local/dtos/custom_notification_dto.dart';
import 'package:sigs_certifica_app/data/services/notifications/local/local_notification_service.dart';
import 'package:sigs_certifica_app/locator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final localNoticationService = getIt<LocalNotificationService>();
  final flutterLocalNotificationsPlugin =
      getIt<FlutterLocalNotificationsPlugin>();

  final _notificationsEnabled = signal<bool>(false);

  @override
  void initState() {
    super.initState();
    _isAndroidPermissionGranted();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    _initilizeFirebaseMessaging();
  }

  _initilizeFirebaseMessaging() async {
    await getIt<FirebaseNotificationService>().initialize();
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      _notificationsEnabled.value = granted;
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();

      _notificationsEnabled.value = grantedNotificationPermission ?? false;
    }
  }

  void _configureDidReceiveLocalNotificationSubject() {
    localNoticationService.didReceiveLocalNotificationStream.value.stream
        .listen((CustomNotificationDTO receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                // Navigator.of(context, rootNavigator: true).pop();
                // await Navigator.of(context).push(
                //   MaterialPageRoute<void>(
                //     builder: (BuildContext context) =>
                //         SecondPage(receivedNotification.payload),
                //   ),
                // );
                context.go('/notifications',
                    extra: receivedNotification.payload);
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    localNoticationService.selectNotificationStream.value.stream
        .listen((String? payload) async {
      // await Navigator.of(context).push(MaterialPageRoute<void>(
      //   builder: (BuildContext context) => SecondPage(payload),
      // ));
      context.go('/notifications', extra: payload);
    });
  }

  @override
  void dispose() {
    localNoticationService.didReceiveLocalNotificationStream.value.close();
    localNoticationService.selectNotificationStream.value.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/notifications', extra: "teste");
            },
            icon: const Icon(Icons.notifications_active),
          ),
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(""),
              ElevatedButton.icon(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  localNoticationService.showSimpleNotification(
                      title: "Simple Notification",
                      body: "This is a simple notification",
                      payload: "This is simple data");
                },
                label: const Text("Simple Notification"),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.timer_outlined),
                onPressed: () {
                  localNoticationService.showScheduleNotification(
                      title: "Schedule Notification",
                      body: "This is a Schedule Notification",
                      payload: "This is schedule data");
                },
                label: Text("Schedule Notifications"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
