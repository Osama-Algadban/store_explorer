
class ApiConstants {
  static Map<String, dynamic> baseHeader = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Secret-Key": "",
    "Api-Key":"",
  };

  static Map<String, dynamic> tokenHeader(String token) => {
    ...baseHeader,
    "Accept": "application/json",
    "Authorization" : "Bearer $token",
  };
}
