import 'package:di/di.dart';
import 'package:flutter/material.dart';
import 'package:home_feature/home_feature.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDi();
  runApp(const MaterialApp(home: HomeScreen()));
}
