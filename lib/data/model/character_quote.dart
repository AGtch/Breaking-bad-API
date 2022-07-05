class CharacterQuote {
  late String quote;

  CharacterQuote({
    required this.quote,
  });
  // from json 
  CharacterQuote.fromJson(Map<String, dynamic> json) {
    quote = json["quote"];
  }
}
