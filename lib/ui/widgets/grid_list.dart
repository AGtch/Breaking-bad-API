import 'package:flutter/material.dart';
import '../../constant/colors.dart';
import '../../constant/string.dart';
import '../../data/model/character_model.dart';

Widget getGridListToDisplayCharactersInGridView(Character character , BuildContext context) {
  return InkWell(
    onTap: () =>
        Navigator.pushNamed(context, detailsScreen, arguments: character),
    child: Hero(
      tag: character.characterId,
      transitionOnUserGestures: true,
      
      child: GridTile(
          footer: footerOfGird(character),
          child: displayImageOfCharacterInGrid(character)),
    ),
  );
}

Widget footerOfGird(Character character) {  
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 8,
    ),
    alignment: Alignment.bottomCenter,
    child: Text(
      character.name.toString(),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 2,
      textAlign: TextAlign.center,
    ),
  );
}

Widget displayImageOfCharacterInGrid(Character character ) {
  return Container(
color: ColorsApp.primaryColor,    
    child: (character.image!.isEmpty || character.image == null)
        ? Image.asset('assets/images/error.png')
        : FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            image: character.image.toString(),
            fit: BoxFit.cover,
          ),
  );
}
