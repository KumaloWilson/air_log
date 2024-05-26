import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseSecurityConfig {
  static String baseUrl = 'https://air-log-security.onrender.com';
  static String projectID = dotenv.env['FIREBASE_PROJECT_ID'].toString();
  static String projectPrivateKeyID = dotenv.env['FIREBASE_PROJECT_PRIVATE_KEY_ID'].toString();
  static String projectPrivateKeyKey = dotenv.env['FIREBASE_PROJECT_PRIVATE_KEY'].toString();
  static String clientID = dotenv.env['FIREBASE_CLIENT_ID'].toString();
  static String clientEmail = dotenv.env['FIREBASE_CLIENT_EMAIL'].toString();
  static String clientCertURL = dotenv.env['FIREBASE_CLIENT_X509_CERT_URL'].toString();
}
