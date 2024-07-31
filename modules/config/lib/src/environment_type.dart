enum EnvironmentType {
  prod('prod'),
  unknown('unknown');

  final String name;

  const EnvironmentType(this.name);

  factory EnvironmentType.fromName(String name) {
    switch (name) {
      case 'prod':
        return prod;
      default:
        return unknown;
    }
  }
}
