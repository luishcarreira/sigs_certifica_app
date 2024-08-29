import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigs_certifica_app/data/services/api/api_service.dart';
import 'package:sigs_certifica_app/data/services/auth/api_auth_service.dart';
import 'package:sigs_certifica_app/data/services/auth/local_auth_service.dart';
import 'package:sigs_certifica_app/data/services/notifications/firebase/firebase_notification_service.dart';
import 'package:sigs_certifica_app/data/services/notifications/local/local_notification_service.dart';
import 'package:sigs_certifica_app/presentation/viewmodel/auth/login_view_model.dart';

final getIt = GetIt.instance;

void setupLocator() async {
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<FlutterLocalNotificationsPlugin>(
      () => FlutterLocalNotificationsPlugin());
  getIt.registerSingleton<LocalAuthentication>(LocalAuthentication());

  getIt.registerLazySingleton<ApiService>(
    () => ApiService(client: getIt<http.Client>()),
  );
  getIt.registerLazySingletonAsync<SharedPreferences>(() async {
    final sh = await SharedPreferences.getInstance();
    return sh;
  });

  getIt.registerLazySingleton<ApiAuthService>(
    () => ApiAuthService(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<LocalAuthService>(
    LocalAuthService(auth: getIt<LocalAuthentication>()),
  );

  getIt.registerLazySingleton<LocalNotificationService>(
    () => LocalNotificationService(
        flutterLocalNotificationsPlugin:
            getIt<FlutterLocalNotificationsPlugin>()),
  );

  getIt.registerLazySingleton<FirebaseNotificationService>(
    () => FirebaseNotificationService(
        localNotificationService: getIt<LocalNotificationService>()),
  );

  // Registra a ViewModel
  getIt.registerFactory<LoginViewModel>(
      () => LoginViewModel(getIt<ApiAuthService>()));
}
