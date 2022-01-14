// ignore_for_file: unnecessary_this

class QuestItem {
  late int id;
  late String todoQuest;
  late int like;
  late String school;
  late int category;
  late bool isChecked = false;

  QuestItem(
    this.id,
    this.todoQuest, 
    this.like, 
    this.school, 
    this.category,
    );

  // factory QuestItem.fromJson(Map<String, dynamic> json) {
  //   return QuestItem(
  //     title: json['todo_quest']
  //   );
  // }
}