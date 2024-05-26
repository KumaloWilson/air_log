// To parse this JSON data, do
//
//     final token = tokenFromMap(jsonString);

import 'dart:convert';

Token tokenFromMap(String str) => Token.fromMap(json.decode(str));

String tokenToMap(Token data) => json.encode(data.toMap());

class Token {
  String accessToken;
  int expiresIn;
  int refreshExpiresIn;
  String refreshToken;
  String tokenType;
  String idToken;
  int notBeforePolicy;
  String sessionState;
  String scope;

  Token({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshExpiresIn,
    required this.refreshToken,
    required this.tokenType,
    required this.idToken,
    required this.notBeforePolicy,
    required this.sessionState,
    required this.scope,
  });

  factory Token.fromMap(Map<String, dynamic> json) => Token(
    accessToken: json["access_token"],
    expiresIn: json["expires_in"],
    refreshExpiresIn: json["refresh_expires_in"],
    refreshToken: json["refresh_token"],
    tokenType: json["token_type"],
    idToken: json["id_token"],
    notBeforePolicy: json["not-before-policy"],
    sessionState: json["session_state"],
    scope: json["scope"],
  );

  Map<String, dynamic> toMap() => {
    "access_token": accessToken,
    "expires_in": expiresIn,
    "refresh_expires_in": refreshExpiresIn,
    "refresh_token": refreshToken,
    "token_type": tokenType,
    "id_token": idToken,
    "not-before-policy": notBeforePolicy,
    "session_state": sessionState,
    "scope": scope,
  };
}
