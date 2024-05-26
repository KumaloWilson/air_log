// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
//
// import 'keycloakTokeHelper.dart';
//
// Dio dio = Dio();
//
// void setupDioInterceptor() {
//   dio.interceptors.add(InterceptorsWrapper(
//     onRequest: (options, handler) async {
//       String? token = await KeycloakHelper.generateKeycloakToken();
// print('Chantelle');
//       options.headers['Authorization'] = 'Bearer $token';
//       dio.interceptors.add(LogInterceptor(responseBody: true));
//       http.get(Uri.parse('https://example.com')).then((response) {
//         if (response.statusCode == 200) {
//           print(response.body);
//         } else {
//           print('Request failed with status: ${response.statusCode}');
//         }
//       }).catchError((error) {
//         print('Error occurred: $error');
//       });
//
//       return handler.next(options);
//     },
//   ));
// }