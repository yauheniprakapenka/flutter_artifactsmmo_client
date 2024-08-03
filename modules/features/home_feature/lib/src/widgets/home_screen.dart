import 'package:core_ui/core_ui.dart';
import 'package:di/di.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';
import 'character_info.dart';
import 'character_position_widget.dart';
import 'random_tiled_background.dart';

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

            return RandomTiledBackground(
              tileHeight: 224,
              tileWidth: 224,
              tileAssetPaths: const [...MapTiles.all],
              stackChildren: [
                const Positioned(
                  bottom: 24,
                  left: 24,
                  child: CharacterPositionWidget(),
                ),
                Positioned(
                  bottom: 280,
                  left: 24,
                  child: Builder(
                    builder: (BuildContext context) {
                      final Character? character = state.gameData?.character;
                      if (character == null) {
                        return const SizedBox();
                      }
                      return CharacterInfo(character);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
