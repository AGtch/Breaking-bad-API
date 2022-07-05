import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../data/model/character_model.dart';
import '../../data/model/character_quote.dart';
import '../../data/repository/character_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
  List<Character> characters = [];


  CharactersCubit(this.characterRepository) : super(CharactersInitial());
  
  List<Character> getAllCharacter() {
    characterRepository.fetchCharacters().then((characters) {
      emit(CharactersLoaded(characters: characters));
      this.characters = characters;
    });
    
    return characters;
  }
  
  void getQuotes(String characterName) {
    characterRepository.fetchQuotes(characterName).then((quotes) {
      emit(CharactersQuotesLoaded(quotes: quotes));
    });
  }
}
