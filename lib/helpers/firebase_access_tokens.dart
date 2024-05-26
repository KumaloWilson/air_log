import 'package:googleapis_auth/auth_io.dart';
import 'package:logger/logger.dart';
import '../utils/configs/security_url_configs.dart';



class FirebaseAccessTokens {
  static String firebaseMessagingScope = 'https://www.googleapis.com/auth/firebase.messaging';

  static Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(
        {
          "type": "service_account",
          "project_id": FirebaseSecurityConfig.projectID.toString(),
          "private_key_id": FirebaseSecurityConfig.projectPrivateKeyID.toString(),
          "private_key": FirebaseSecurityConfig.projectPrivateKeyKey.toString(),
          "client_email": FirebaseSecurityConfig.clientEmail.toString(),
          "client_id": FirebaseSecurityConfig.clientID.toString(),
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": FirebaseSecurityConfig.clientCertURL.toString(),
          "universe_domain": "googleapis.com"
        }
        ,
      ),
      [
        firebaseMessagingScope
      ]
    );

    final accessToken = client.credentials.accessToken.data;
    _logger.i('GENERATED TOKEN = $accessToken');
    client.close();
    return accessToken;
  }

  static final Logger _logger = Logger();
}