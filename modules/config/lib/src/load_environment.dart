import 'package:domain/domain.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'environment_type.dart';

Future<Config> loadEnvironment() async {
  const String environment = String.fromEnvironment('env');
  print('Environment: $environment');

  final EnvironmentType envType = EnvironmentType.fromName(environment);
  print('Environment type: $envType');
  switch (envType) {
    case EnvironmentType.prod:
      await dotenv.load(fileName: '.env_prod');
    case EnvironmentType.unknown:
      throw Exception('Unknown environment: $environment');
  }

  final Config config = Config(
    token: dotenv.env['TOKEN'] ?? '',
    baseUrl: dotenv.env['BASE_URL'] ?? '',
  );
  print('Config: $config');
  return config;
}
