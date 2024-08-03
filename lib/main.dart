import 'package:di/di.dart';
import 'package:flutter/material.dart';
import 'package:world_feature/home_feature.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDi();
  runApp(const MaterialApp(home: WorldScreen()));
}
