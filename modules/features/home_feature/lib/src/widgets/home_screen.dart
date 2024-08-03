import 'package:core_ui/core_ui.dart';
import 'package:di/di.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';
import 'character_position_widget.dart';
import 'character_selection_widget/character_selection_widget.dart';
import 'random_tiled_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) {
        return HomeBloc(
          myCharacterRepository: getIt<MyCharacterRepository>(),
          mapsRepository: getIt<MapsRepository>(),
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
              tileAssetPaths: [...MapTiles.all],
              stackChildren: [
                Positioned(
                  bottom: Dimensions.edgeInset,
                  left: Dimensions.edgeInset,
                  child: CharacterPositionWidget(),
                ),
                Positioned(
                  top: Dimensions.edgeInset,
                  left: Dimensions.edgeInset,
                  child: CharacterSelectionWidget(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
