import '../model/character_quote.dart';

import '../model/character_model.dart';
import '../server/character_api.dart';
class CharacterRepository {
  final CharacterAPI characterAPI;

  CharacterRepository(this.characterAPI);

  Future<List<Character>> fetchCharacters() async {
    final characters = await characterAPI.fetchCharacters();

    return characters!
        .map((character) => Character.fromJson(character))
        .toList();
  }
  Future<List<CharacterQuote>> fetchQuotes(String characterName) async {
    final quotes = await characterAPI.fetchQuotes(characterName);
    return quotes!.map((characterQuotes) => CharacterQuote.fromJson(characterQuotes)).toList();
  }
}
