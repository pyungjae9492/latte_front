import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'dart:convert';

import '../model/model_quest_item.dart';
import '../model/api_adapter.dart';
import '../controller/list_controller.dart';
import '../variables.dart';


class QuestList extends StatefulWidget {
  @override
  QuestListState createState() => QuestListState();
}

class QuestListState extends State<QuestList> {
  final QuestListController listController = Get.put(QuestListController());
  final _schoolList = ['전체', '서울대', '고려대'];
  var _selectedValue = '전체';

  @override
  void initState() {
    super.initState();
    
    loadData().then((value){
      if (value) {
          listController.putFetchedQuestsInList();
          listController.isListLoading = true.obs;
          print(listController.isListLoading.value);
      }
    });
  }

  Future<bool> loadData() async {
    await listController.fetchNewQuests();
    await listController.fetchHotQuests();
    return true;
  }

  CheckQuest() async {
    final response = await http.get( 
      Uri.parse('https://site1.public.nqo.me/quests'),
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
      // newQuestList = parseQuestItems(utf8.decode(response.bodyBytes)).obs;
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('Failed to load new quests');
    }
  }

  PostQuest(quest_data) async {
    final response = await http.post( 
      Uri.parse('https://site1.public.nqo.me/quests'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: quest_data
    );
    if (response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
      // newQuestList = parseQuestItems(utf8.decode(response.bodyBytes)).obs;
      // isLoading = false.obs;
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('Failed to load new quests');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = ScreenUtil().setWidth(360);
    final height = ScreenUtil().setHeight(690);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                    child: Container(
                      child: AddTaskScreen()),
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                );
              });
        },
        backgroundColor: mainColor,
        child: Icon(Icons.add),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: Container(
        height: height,
        padding: EdgeInsets.fromLTRB(width*0.08, height*0.03, width*0.08, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(width*0.02, 0, 0, 0),
            child:
              DropdownButton(
                borderRadius: BorderRadius.circular(5),
                style: TextStyle(fontSize: 18, color: Colors.black),
                iconSize: 28,
                value: _selectedValue,
                items: _schoolList.map(
                  (value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value.toString();
                  });
                }
              ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, height*0.01, 0, height*0.01),
            child:
              Row(
                children: [
                  Container(
                    child: listController.currentIndex.value == 0 ?
                      Container(
                        margin: EdgeInsets.all(width*0.015),
                        width: width*0.13,
                        height: height*0.06,
                        decoration : const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color : Colors.black,
                            ),
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                          ),
                          child: Text('최신'), 
                          onPressed: () {
                            listController.currentIndex = 0.obs;
                          }
                        )
                      ) :
                      Container(
                        margin: EdgeInsets.all(width*0.015),
                        width: width*0.13,
                        height: height*0.06,
                        decoration : const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color : Color.fromARGB(0, 0, 0, 0),
                            ),
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                          ),
                          child: Text('최신'), 
                          onPressed: () {
                            listController.currentIndex = 0.obs;
                          }
                        )
                      )
                  ),
                  Container(
                    child: listController.currentIndex.value == 1 ?
                      Container(
                        margin: EdgeInsets.all(width*0.015),
                        width: width*0.13,
                        height: height*0.06,
                        decoration : const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color : Colors.black,
                            ),
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                          ),
                          child: Text('인기'), 
                          onPressed: () {
                            listController.currentIndex = 1.obs;
                          }
                        )
                      ) :
                      Container(
                        margin: EdgeInsets.all(width*0.015),
                        width: width*0.13,
                        height: height*0.06,
                        decoration : const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color : Color.fromARGB(0, 0, 0, 0),
                            ),
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                          ),
                          child: Text('인기'), 
                          onPressed: () {
                            listController.currentIndex = 1.obs;
                          }
                        )
                      )
                  )
                ]
              ),              
          ),
          Obx(() => Expanded(
            child: listController.isListLoading.value ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: listController.lists[listController.currentIndex.value].length,
                      itemBuilder: (context, position) {
                        return Card(
                          child: Row(
                            children: <Widget>[
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 2,
                              child:
                                Checkbox(
                                  value: listController.lists[listController.currentIndex.value][position].isChecked,
                                  checkColor: Color(0xFFFFFFFF),
                                  activeColor: mainColor, 
                                  onChanged: (value) {
                                    
                                    listController.lists[listController.currentIndex.value][position].isChecked = value!;
                                    if (listController.lists[listController.currentIndex.value][position].isChecked == true) {
                                      listController.lists[listController.currentIndex.value][position].doneCount++;
                                    } else {
                                      listController.lists[listController.currentIndex.value][position].doneCount--;
                                    }
                                  }
                                )
                            ),
                            Flexible(
                              flex: 10,
                              fit: FlexFit.tight,
                              child:
                                Text(listController.lists[listController.currentIndex.value][position].todoQuest),
                            ),
                            const Flexible(
                              fit: FlexFit.tight,
                              child:
                                Icon(Icons.check_circle_outline_rounded, size: 12, color: mainColor)
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child:
                                Text(
                                  listController.lists[listController.currentIndex.value][position].doneCount.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: mainColor)
                                )
                            ),
                          ],)
                        );
                      }
                    ) :
                    const Center(
                      child: Text('Loading...')
                    )
                    ,
          )),
        ])
      ),
    );
  }
}



class AddTaskScreen extends StatefulWidget {
  @override
  AddTaskScreenState createState() => AddTaskScreenState();
}
class AddTaskScreenState extends State<AddTaskScreen> {
  final inputTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = ScreenUtil().setWidth(360);
    final height = ScreenUtil().setHeight(690);
    
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height*0.05, horizontal: width*0.1),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, height*0.02),
              child: const Text("새 퀘스트 추가하기", 
                style: TextStyle(fontSize: 18)
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "제목",
              ),
              controller: inputTitleController,
            ),
            Container(
              padding: EdgeInsets.only(top: height*0.05),
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: (){

                  Navigator.pop(context);
                }, 
                child: Text("추가하기"),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      Colors.white), //syleForm에서  primarycolor랑 같다.
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.disabled)) {
                      // disabled : onpressed가 null일때 , pressed : 클릭됐을때
                      return Colors.grey;
                    } else {
                      return mainColor;
                    }
                  }),
                  textStyle: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return TextStyle(fontSize: 16);
                    } else {
                      return TextStyle(fontSize: 14);
                    }
                  })),
              )
            ),
        ],)
      ),
    );
  }
}

void newQuest(context) {
  Navigator.pop(context);
}

// Future<List<QuestItem>> fetchQuests() async {
//   print('hello');
//   final url = Uri.parse('http://127.0.0.1:8000/quests/');
//   final response =
//       await http.get(url);

//   if (response.statusCode == 200) {
//     // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
//     // List data = json.decode(response.body);
//     // QuestItem.fromJson();
//     print('yes');
//     List<QuestItem> list = [];
//     print(response.body);
//     return list;
//   } else {
//     // 만약 응답이 OK가 아니면, 에러를 던집니다.
//     throw Exception('Failed to load post');
//   }
// }