import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constant/string.dart';
import 'data/repository/character_repository.dart';
import 'data/server/character_api.dart';
import 'logic/cubit/characters_cubit.dart';
import 'ui/screens/characters_screen.dart';
import 'ui/screens/details_screen.dart';

import 'data/model/character_model.dart';

class AppRouter {
  late CharactersCubit charactersCubit;
  late CharacterRepository characterRepository;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterAPI());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
          builder: (builder) => BlocProvider(
            create: (BuildContext context) {
              return charactersCubit;
            },
            child: const CharactersScreen(),
          ),
        );

      case detailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (builder) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(characterRepository),
            child: DetailsScreen(
              character: character,
            ),
          ),
        );
    }
    return null;
  }
}
