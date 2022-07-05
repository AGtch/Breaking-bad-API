import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constant/colors.dart';
import '../../logic/cubit/characters_cubit.dart';
import '../widgets/widgets_to_display_in_item.dart';

import '../../data/model/character_model.dart';

class DetailsScreen extends StatelessWidget {
  final Character character;
  const DetailsScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: ColorsApp.primaryColor,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                // color: ColorsApp.secondaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo("Jobs : ", character.jobs.join(' / ')),
                    buildDivider(325.0),
                    characterInfo("Nick Name : ", character.nickName),
                    buildDivider(280.0),
                    characterInfo("Birthday : ", character.birthday),
                    buildDivider(290.0),
                    characterInfo("Actor Name : ", character.actorName),
                    buildDivider(265.0),
                    characterInfo(
                      "Appearance : ",
                      character.appearanceOfSessions.join(' / '),
                    ),
                    buildDivider(265.0),
                    characterInfo(
                        "Dead Or Alive : ", character.statusOfDeadOrAlive),
                    buildDivider(250.0),
                    const SizedBox(
                      height: 26,
                    )
                  ],
                ),
              ),
              BlocBuilder<CharactersCubit, CharactersState>(
                builder: (context, state) {
                  return checkIfQuotesAreLoaded(state);
                },
              ),
              const SizedBox(
                height: 500,
              )
            ]),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      backgroundColor: ColorsApp.secondaryColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
        background: Hero(
          tag: character.characterId,
          child: Image.network(character.image!, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget buildDivider(double endIntent) {
    return Divider(
      height: 26,
      color: Colors.yellow,
      endIndent: endIntent,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded( state) {
    if (state is CharactersQuotesLoaded) {
      return displayRandomQuote(state);
    } else {
      return showLoadingIndicator();
    }
  }

  Widget displayRandomQuote(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
          int randomIndex = Random().nextInt(quotes.length - 1);

         return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.amber,
        
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ScaleAnimatedText(quotes[randomIndex].quote, duration: const Duration(seconds: 5) ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox(height: 60,);
    }
  }
}
