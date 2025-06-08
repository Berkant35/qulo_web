part of 'i_pref.dart';

enum AuthPrefKey { accessToken }

base class AuthPref extends IPref {
  Future<bool> saveAccessToken(String accessToken) async {
    await _set(AuthPrefKey.accessToken.name, accessToken);
    final String? token = await getAccessToken();
    return token.isEquals(accessToken);
  }

  Future<String?> getAccessToken() async {
    return await _get(AuthPrefKey.accessToken.name) as String?;
  }
}
