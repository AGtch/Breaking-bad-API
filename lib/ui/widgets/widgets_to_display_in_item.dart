// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:breaking_bad_API/constant/colors.dart';
// import 'package:breaking_bad_API/data/model/character_model.dart';
// import 'package:breaking_bad_API/logic/cubit/characters_cubit.dart';
// import 'package:breaking_bad_API/ui/widgets/character_item.dart';

import 'package:flutter/material.dart';

import '../../constant/colors.dart';

Widget showLoadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      color: ColorsApp.secondaryColor,
    ),
  );
}



// Widget buildWidgetToShowAllCharacters(List<Character> allCharacter) {
//   return SingleChildScrollView(
//     child: Container(
//       color: ColorsApp.secondaryColor,
//       child: Column(
//         children: [
//           buildCharacterList(allCharacter),
//         ],
//       ),
//     ),
//   );
// }

// Widget buildCharacterList(List<Character> allCharacter) {

//   return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 1,
//         mainAxisSpacing: 1,
//         childAspectRatio: 2 / 3,
//       ),
//       shrinkWrap: true,
//       //Search For  physics
//       physics: const ScrollPhysics(),
//       itemCount: allCharacter.length,
//       itemBuilder: (context, index) {
    
//         return CharacterItem(
//           character: allCharacter[index],
//         );
//       });
// }

// Widget buildBlocWidget(List<Character>? allCharacter) {
//   return BlocBuilder<CharactersCubit, CharactersState>(
//     builder: (context, state) {
//       if (state is CharactersLoaded) {
//         allCharacter = (state).characters;
//         return buildWidgetToShowAllCharacters(allCharacter!);
//       } else {
//         return showLoadingIndicator();
//       }
//     },
//   );
// }

