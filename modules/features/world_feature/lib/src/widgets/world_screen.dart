import 'package:core_ui/core_ui.dart';
import 'package:di/di.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/world_bloc.dart';
import '../utils/world_map_calculator.dart';
import '../utils/world_map_constants.dart';
import 'buttons/small_button.dart';
import 'character/character_experience_widget.dart';
import 'character/characters_control/characters_control.dart';
import 'tile/random_tiled_background.dart';
import 'world_map.dart';

class WorldScreen extends StatelessWidget {
  const WorldScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorldBloc>(
      create: (BuildContext context) {
        return WorldBloc(
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
    // Герерируется фон один раз и затем переиспользуется.
    _randomTiledBackground = RandomTiledBackground(
      tileAssetPaths: GameAssets.allMapPaths(),
      tileWidth: WorldMapConstants.mapTileSize,
      tileHeight: WorldMapConstants.mapTileSize,
      stackChildren: const [
        Positioned.fill(child: AppProgressIndicator()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<WorldBloc, WorldState>(
        listener: (BuildContext context, WorldState state) {
          if (state.error != null) {
            showToast(context, state.error!);
          }
        },
        child: BlocBuilder<WorldBloc, WorldState>(
          builder: (BuildContext context, WorldState state) {
            if (state.isLoading) {
              return Stack(children: [_randomTiledBackground]);
            }

            final Character? selectedCharacter = state.selectedCharacter;

            return Stack(
              children: [
                WorldMap(
                  worldMapCalculator: WorldMapCalculator(state.mapDetails?.tiles ?? []),
                ),
                const Positioned(
                  bottom: Dimensions.edgeInset,
                  left: Dimensions.edgeInset,
                  child: CharactersControl(),
                ),
                selectedCharacter == null
                    ? const SizedBox()
                    : Positioned(
                        left: Dimensions.edgeInset,
                        bottom: 132,
                        child: CharacterExperienceWidget(
                          experience: selectedCharacter.asCharacterExperience,
                        ),
                      ),
                selectedCharacter == null
                    ? const SizedBox()
                    : Positioned(
                        left: 436,
                        bottom: 132,
                        child: SmallButton(
                          assetPath: AppIcons.focus,
                          onPressed: () {
                            context.read<WorldBloc>().add(const FocusToSelectedCharacterEvent());
                          },
                        ),
                      ),
                // const Positioned(
                //   top: Dimensions.edgeInset,
                //   left: Dimensions.edgeInset,
                //   child: CharacterPositionWidget(),
                // ),
                Positioned(
                  right: Dimensions.edgeInset,
                  bottom: Dimensions.edgeInset,
                  child: SmallButton(
                    assetPath: AppIcons.grid,
                    onPressed: () {
                      context.read<WorldBloc>().add(const ShowGridEvent());
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
