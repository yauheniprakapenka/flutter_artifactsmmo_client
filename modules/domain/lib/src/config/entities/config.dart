class Config {
  final String token;
  final String baseUrl;

  const Config({
    required this.token,
    required this.baseUrl,
  });

  @override
  String toString() => 'Config(token: $token, baseUrl: $baseUrl)';
}
