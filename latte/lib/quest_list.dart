import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'quest_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestList extends StatefulWidget {
  _QuestListState createState() => _QuestListState();
}

class _QuestListState extends State<QuestList> {
  final _schoolList = ['전체', '서울대', '고려대'];
  var _selectedValue = '전체';
  List<QuestItem> list = [];
  List<QuestItem> newList = [];
  List<QuestItem> hotList = [];

  @override
  void initState() {
    super.initState();
    list.add(QuestItem(1, '버들골에서 짜장면 먹기', 3, '서울대', 1));
    list.add(QuestItem(2, '버들골에서 짜장면 만들기', 2, '서울대', 1));
    list.add(QuestItem(3, '버들골에서 짜장면 부수기', 1, '서울대', 1));
    list.add(QuestItem(4, '버들골에서 짜장면 엎기', 6, '서울대', 1));
    list.add(QuestItem(5, '버들골에서 짜장면 안 먹기', 9, '서울대', 1));
    list.add(QuestItem(6, '버들골에서 짜장면은 안 멋져', 7, '서울대', 1));
    list.add(QuestItem(7, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
    list.add(QuestItem(8, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
    list.add(QuestItem(9, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
    list.add(QuestItem(10, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
    list.add(QuestItem(11, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
    list.add(QuestItem(12, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
    list.add(QuestItem(13, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
  }

  @override
  Widget build(BuildContext context) {
    final width = ScreenUtil().setWidth(360);
    final height = ScreenUtil().setHeight(690);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){ _showDialog(context); },
        backgroundColor: Color(0xFF91A7FF),
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
                      onPressed: () {}
                    )
                  ),
                  Container(
                    margin:EdgeInsets.all(width*0.015),
                    width: width*0.13,
                    height: height*0.06,
                    decoration : const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color : Colors.white,
                        ),
                      ),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ),
                      child: Text('인기'), 
                      onPressed: () {}
                    )
                  ),
                ]
              ),              
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, position) {
                return Card(
                  child: Row(children: <Widget>[
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child:
                      Checkbox(
                        value: list[position].isChecked,
                        checkColor: Color(0xFFFFFFFF),
                        activeColor: Color(0xFF91A7FF), 
                        onChanged: (value) {
                          setState(() {
                            list[position].isChecked = value!;
                            if (list[position].isChecked == true) {
                              list[position].like++;
                            } else {
                              list[position].like--;
                            }
                          });
                        }
                      ),
                    ),
                    Flexible(
                      flex: 10,
                      fit: FlexFit.tight,
                      child:
                        Text(list[position].todoQuest),
                    ),
                    const Flexible(
                      fit: FlexFit.tight,
                      child:
                        Icon(Icons.check_circle_outline_rounded, size: 12, color: Color(0xFF91A7FF))
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child:
                        Text(
                          list[position].like.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF91A7FF))
                        )
                    ),
                  ],)
                );
              }
            ),
          ),
        ])
      ),
    );
  }
}

void _showDialog(context) { 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("새 퀘스트 작성하기"),
          content: 
              TextField(
              	decoration: InputDecoration(
              		border: OutlineInputBorder(),
              		labelText: '퀘스트 내용',
              	),
              ),
          actions: <Widget>[
              TextButton(
                child: Text('만들기'),
                onPressed: () {
                  
                },
            ),
          ],
        );
      },
    );
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