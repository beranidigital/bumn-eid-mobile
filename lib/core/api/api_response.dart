class ApiResponse {
  int statusCode;
  Map<String, dynamic> body;

  ApiResponse(int statusCode, Map<String, dynamic> body) {
    this.statusCode = statusCode;
    this.body = body;
  }

  bool wasSuccessful() {
    return statusCode >= 200 && statusCode < 300;
  }
}

class ApiResponseList {
  int statusCode;
  List<Map<String, dynamic>> body;

  ApiResponseList(int statusCode, List<Map<String, dynamic>> body) {
    this.statusCode = statusCode;
    this.body = body;
  }

  bool wasSuccessful() {
    return statusCode >= 200 && statusCode < 300;
  }
}
