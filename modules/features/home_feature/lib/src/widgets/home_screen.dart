import 'package:core_ui/core_ui.dart';
import 'package:di/di.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';
import 'position_widget.dart';
import 'random_tiled_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) {
        return HomeBloc(
          charactersRepository: getIt<CharactersRepository>(),
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
      body: BlocListener<HomeBloc, HomeState>(
        listener: (BuildContext context, HomeState state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error ?? ''),
                backgroundColor: Colors.blue,
              ),
            );
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, HomeState state) {
            if (state.isLoading) {
              return const AppProgressIndicator();
            }

            return const RandomTiledBackground(
              tileHeight: 224,
              tileWidth: 224,
              tileAssetPaths: [
                'assets/images/forest_1.png',
                'assets/images/forest_2.png',
                'assets/images/forest_3.png',
                'assets/images/forest_4.png',
              ],
              stackChildren: [
                Positioned(
                  top: Dimensions.edgeInset,
                  left: Dimensions.edgeInset,
                  child: PositionWidget(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


// https://api.artifactsmmo.com/images/characters/men1.png