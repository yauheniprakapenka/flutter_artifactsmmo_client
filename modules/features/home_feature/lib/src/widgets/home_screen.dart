import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:di/di.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) {
        return HomeBloc(
          myCharacterRepository: getIt<MyCharacterRepository>(),
        );
      },
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              color: Colors.amber[200],
              child: const Column(
                children: [
                  Row(
                    children: [
                      Text('Position'),
                    ],
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<HomeBloc>()
                    .add(const ChangePositionEvent('johnwick', Point<int>(2, 2)));
              },
              child: const Text('Change Position'),
            ),
          ],
        );
      }),
    );
  }
}
