class Character {
  Character({
    required this.characterId,
    required this.name,
    required this.birthday,
    required this.nickName,
    required this.image,
    required this.jobs,
    required this.appearanceOfSessions,
    required this.statusOfDeadOrAlive,
    required this.actorName,
  });

  Character.fromJson(Map<String, dynamic> json) {
    characterId = json["char_id"];
    name = json["name"];
    birthday = json["birthday"];
    nickName = json["nickname"];
    image = json["img"];
    jobs = json["occupation"];
    statusOfDeadOrAlive = json["status"];
    appearanceOfSessions = json["appearance"];
    actorName = json["portrayed"];
  }

  late String actorName;
  late List<dynamic> appearanceOfSessions;
  late String birthday;
  late int characterId;
  late String? image;
  late List<dynamic> jobs;
  late String name;
  late String nickName;
  late String statusOfDeadOrAlive;
}
