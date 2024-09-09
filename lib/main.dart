import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sigs_certifica_app/data/services/notifications/local/local_notification_service.dart';
import 'package:sigs_certifica_app/firebase_options.dart';
import 'package:sigs_certifica_app/locator.dart';
import 'package:sigs_certifica_app/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();
  await getIt.allReady();

  if (!kIsWeb) {
    final localNotificationService = getIt<LocalNotificationService>();
    await localNotificationService
        .initialize(); // Inicializa o serviço de notificação

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await getIt<FlutterLocalNotificationsPlugin>()
            .getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp == true) {
      String? selectedNotificationPayload =
          notificationAppLaunchDetails!.notificationResponse?.payload;

      localNotificationService.selectNotificationStream.value
          .add(selectedNotificationPayload);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade200),
        useMaterial3: true,
      ),
      routerDelegate: routes.routerDelegate,
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
    );
  }
}
