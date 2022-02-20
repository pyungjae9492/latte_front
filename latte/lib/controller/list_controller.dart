import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/model_quest_item.dart';
import '../model/api_adapter.dart';

class QuestListController extends GetxController{
  var newQuestList = [].obs;
  var hotQuestList = [].obs;
  var isListLoading = false.obs;
  var lists = [].obs;
  var currentIndex = 0.obs;

  fetchNewQuests() async {
    final response = await http.get( 
      Uri.parse('https://site1.public.nqo.me/quests'),
      headers: {"Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      newQuestList = parseQuestItems(utf8.decode(response.bodyBytes)).obs;
    } else {
      throw Exception('Failed to load new quests');
    }
  }

  fetchHotQuests() async {
    final response = await http.get( 
      Uri.parse('https://site1.public.nqo.me/app-hottest'),
      headers: {"Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      hotQuestList = parseHotQuestItems(utf8.decode(response.bodyBytes)).obs;
    } else {
      throw Exception('Failed to load hot quests');
    }
  }

  putFetchedQuestsInList() {
    lists = [newQuestList, hotQuestList].obs;
  }

  changeCurrentListIndex() {
  }

  _postNewQuestToServer() {
  }
 
  _addNewQuestToList() {
  }

  checkQuest(id) async {
    final response = await http.post( 
      Uri.parse('https://site1.public.nqo.me/$id/done'),
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      hotQuestList = parseHotQuestItems(utf8.decode(response.bodyBytes)).obs;
    } else {
      throw Exception('Failed to check quest');
    }
  }

  deleteCheckedQuest(index) => {
    newQuestList.removeAt(index)
  };
}