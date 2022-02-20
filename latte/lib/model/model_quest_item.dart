// ignore_for_file: unnecessary_this

class QuestItem {
  late int id;
  late String todoQuest;
  late int doneCount;
  late int authorId;
  late String authorName;
  late int school;
  late int category;
  late bool isChecked = false;

  QuestItem({
    required this.id,
    required this.todoQuest, 
    required this.doneCount,
    required this.authorId,
    required this.authorName,
    required this.school, 
    required this.category,
  });

  QuestItem.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      todoQuest = map['todo_quest'],
      doneCount = map['doneCount'],
      authorId = map['authorId'],
      authorName = map['authorName'],
      school = map['school'],
      category = map['category'];

  QuestItem.fromJson(Map<String, dynamic> json)
    : id =  json['id'],
      todoQuest = json['todo_quest'],
      doneCount = json['done_count'],
      authorId = json['author_id'],
      authorName = json['author_name'],
      school = json['school'],
      category = json['category'];
}