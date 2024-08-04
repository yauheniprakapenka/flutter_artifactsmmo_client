import 'package:core_ui/core_ui.dart';
import 'package:di/di.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';
import 'character_position_widget.dart';
import 'character_selection_widget/character_selection_widget.dart';
import 'random_tiled_background.dart';
import 'world_map.dart';

class WorldScreen extends StatelessWidget {
  const WorldScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) {
        return HomeBloc(
          myCharacterRepository: getIt<MyCharacterRepository>(),
          mapsRepository: getIt<MapsRepository>(),
        );
      },
      child: const _WorldScreen(),
    );
  }
}

class _WorldScreen extends StatefulWidget {
  const _WorldScreen();

  @override
  State<_WorldScreen> createState() => _WorldScreenState();
}

class _WorldScreenState extends State<_WorldScreen> {
  late final RandomTiledBackground _randomTiledBackground;

  @override
  void initState() {
    super.initState();
    _randomTiledBackground = RandomTiledBackground(
      tileAssetPaths: AssetPath.getAllMapAssetPaths(),
      tileWidth: AssetSize.mapTileSize,
      tileHeight: AssetSize.mapTileSize,
      stackChildren: const [
        Positioned.fill(child: AppProgressIndicator()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
              return Stack(children: [_randomTiledBackground]);
            }

            final List<Tile> mapTiles = state.mapDetails?.tiles ?? [];
            final List<Tile> characterTiles = state.characters.map((Character character) {
              return character.asTile;
            }).toList();

            return Stack(
              children: [
                WorldMap(
                  mapTiles: mapTiles,
                  characterTiles: characterTiles,
                  selectedCharacter: state.selectedCharacter,
                ),
                const Positioned(
                  bottom: Dimensions.edgeInset,
                  left: Dimensions.edgeInset,
                  child: CharacterPositionWidget(),
                ),
                const Positioned(
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
