class Const {
  static String preferedUrl = "https://eid.bumn.go.id/api";

  // static final apiKeyHeader =
  //     "\$2y\$10\$7RGoihzeUY9NBnpZvKJYM.cPXiLfLwqvCka.2pbv6FM2yzpED5LH2";

  static final apiKeyHeader =
      "\$2y\$10\$qhQoh2xJbwMuZiZCBmCf5uMgkE4AItNqd8YDZ5T5JoZ0gswprzAHG";

  static final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": apiKeyHeader,
  };
}
