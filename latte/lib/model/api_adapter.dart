import 'dart:convert';
import 'model_quest_item.dart';

List<QuestItem> parseQuestItems(String responseBody) {
  final parsed = json.decode(responseBody)['Quests'].cast<Map<String, dynamic>>();
  return parsed.map<QuestItem>((json) => QuestItem.fromJson(json)).toList();
}

List<QuestItem> parseHotQuestItems(String responseBody) {
  final parsed = json.decode(responseBody)['HottestQuests'].cast<Map<String, dynamic>>();
  return parsed.map<QuestItem>((json) => QuestItem.fromJson(json)).toList();
}

List<QuestItem> parseDoneQuestItems(String responseBody) {
  final parsed = json.decode(responseBody)['HottestQuests'].cast<Map<String, dynamic>>();
  return parsed.map<QuestItem>((json) => QuestItem.fromJson(json)).toList();
}