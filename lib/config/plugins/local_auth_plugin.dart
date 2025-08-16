import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();

  static canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  static availableBiometrics() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }
  }

  static Future<(bool, String)> authenticate({
    bool biometricOnly = false,
  }) async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: AuthenticationOptions(biometricOnly: biometricOnly),
      );
      return (didAuthenticate, didAuthenticate ? 'Sucess' : 'Failure');
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        return (false, 'No biometrics enrolled');
      }
      if (e.code == auth_error.lockedOut) {
        return (false, 'Too much login attempts');
      }

      if (e.code == auth_error.notAvailable) {
        return (false, 'No biometrics available');
      }

      if (e.code == auth_error.passcodeNotSet) {
        return (false, 'No PIN configurated');
      }
      if (e.code == auth_error.permanentlyLockedOut) {
        return (false, 'Unlock device to try again');
      }

      return (false, e.toString());
    }
  }
}
