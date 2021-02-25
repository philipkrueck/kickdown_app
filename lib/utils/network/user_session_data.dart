class UserSessionData {
  static const AccessTokenHeader = "access-token";
  static const ClientHeader = "client";
  static const ExpiryHeader = "expiry";
  static const UidHeader = "uid";
  static const TokenTypeHeader = "token-type";

  String uid;
  String accessToken;
  String clientId;
  String expirationDate;

  UserSessionData(
      {this.uid, this.accessToken, this.clientId, this.expirationDate});

  factory UserSessionData.from(Map<String, String> headerFields) {
    return UserSessionData(
      uid: headerFields[UidHeader],
      accessToken: headerFields[AccessTokenHeader],
      clientId: headerFields[ClientHeader],
      expirationDate: headerFields[ExpiryHeader],
    );
  }

  void udpateWithHeaderFields(Map<String, String> headerFields) {
    if (headerFields[UidHeader] != null && headerFields[UidHeader].isNotEmpty) {
      uid = headerFields[UidHeader];
    }

    if (headerFields[AccessTokenHeader] != null &&
        headerFields[AccessTokenHeader].isNotEmpty) {
      accessToken = headerFields[AccessTokenHeader];
    }

    if (headerFields[ClientHeader] != null &&
        headerFields[ClientHeader].isNotEmpty) {
      clientId = headerFields[ClientHeader];
    }

    if (headerFields[ExpiryHeader] != null &&
        headerFields[ExpiryHeader].isNotEmpty) {
      expirationDate = headerFields[ExpiryHeader];
    }
  }

  bool get isValid {
    return uid != null &&
        uid.isNotEmpty &&
        accessToken != null &&
        accessToken.isNotEmpty &&
        clientId != null &&
        clientId.isNotEmpty &&
        expirationDate != null &&
        expirationDate.isNotEmpty;
  }

  Map<String, String> get httpHeaderValues {
    if (uid == null ||
        accessToken == null ||
        clientId == null ||
        expirationDate == null) {
      return {};
    }

    return {
      AccessTokenHeader: accessToken,
      TokenTypeHeader: "Bearer",
      ClientHeader: clientId,
      ExpiryHeader: expirationDate,
      UidHeader: uid,
    };
  }
}
