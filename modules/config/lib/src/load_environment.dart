import 'package:domain/domain.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'environment_type.dart';

Future<Config> loadEnvironment() async {
  final EnvironmentType envType = _getEnvironmentType();
  await _loadEnvFile(envType);
  return _createConfig();
}

EnvironmentType _getEnvironmentType() {
  const String environment = String.fromEnvironment(_EnvironmentKeys.environmentArgument);
  return EnvironmentType.fromName(environment);
}

Future<void> _loadEnvFile(EnvironmentType envType) async {
  switch (envType) {
    case EnvironmentType.prod:
      await dotenv.load(fileName: _EnvironmentKeys.productionEnvFile);
    case EnvironmentType.unknown:
      throw Exception('Unknown environment: ${envType.name}');
  }
}

Config _createConfig() {
  final String token = _getEnvVariable(_EnvironmentKeys.authToken);
  final String baseUrl = _getEnvVariable(_EnvironmentKeys.apiBaseUrl);
  return Config(token: token, baseUrl: baseUrl);
}

String _getEnvVariable(String key) {
  final String? value = dotenv.env[key];
  if (value == null) {
    throw Exception('Missing $key');
  }
  return value;
}

class _EnvironmentKeys {
  static const String authToken = 'AUTH_TOKEN';
  static const String apiBaseUrl = 'API_BASE_URL';
  static const String environmentArgument = 'env';
  static const String productionEnvFile = '.env_prod';
}
