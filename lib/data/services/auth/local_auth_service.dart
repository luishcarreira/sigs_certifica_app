import 'package:local_auth/local_auth.dart';
import 'package:sigs_certifica_app/data/helpers/shared_preferences_helper.dart';

class LocalAuthService {
  final LocalAuthentication auth;
  final SharedPreferencesHelper prefsHelper;

  LocalAuthService({required this.auth, required this.prefsHelper});

  static const _biometricPrefKey = 'biometricEnabled';

  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    return canAuthenticateWithBiometrics || await auth.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    return await auth.authenticate(
      localizedReason: 'Por favor, autentique-se para acessar o app.',
    );
  }

  Future<void> enableBiometric(bool isEnabled) async {
    await prefsHelper.save<bool>(_biometricPrefKey, isEnabled);
  }

  Future<bool> isBiometricEnabled() async {
    return await prefsHelper.get<bool>(_biometricPrefKey) ?? false;
  }
}
