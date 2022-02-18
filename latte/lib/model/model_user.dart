// ignore_for_file: unnecessary_this

class User {
  late int id;
  late String nickname;
  late String school;

  User({
    required this.id,
    required this.nickname,
    required this.school
  });

  User.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      nickname = map['username'],
      school = map['doneCount'];

  User.fromJson(Map<String, dynamic> json)
    : id =  json['id'],
      nickname = json['username'],
      school = json['school'];
}