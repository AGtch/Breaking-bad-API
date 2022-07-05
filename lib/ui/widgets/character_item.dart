import 'package:flutter/material.dart';
import '../../constant/colors.dart';
import '../../data/model/character_model.dart';

import 'grid_list.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: ColorsApp.primaryColor,
        borderRadius: BorderRadius.circular(26),
      ),
      child: getGridListToDisplayCharactersInGridView(character , context),
    );
  }
}
