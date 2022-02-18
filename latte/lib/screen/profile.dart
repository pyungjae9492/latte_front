import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/model_quest_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:latte/model/api_adapter.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late List<QuestItem> clearList = [];
  late List<QuestItem> madeList = [];
  late List<List<QuestItem>> lists = [];
  var currentIndex = 0;
  var isLoading = false;

  _fetchDoneQuests() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get( 
      Uri.parse('https://site1.public.nqo.me/my-done-quests'),
      headers: {"Accept": "application/json"},
      );
    if (response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
      setState(() {
        clearList = parseDoneQuestItems(utf8.decode(response.bodyBytes));
        isLoading = false;
      });
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('Failed to load new quests');
    }
  }

  @override
  void initState() {
    super.initState();

    lists.add(clearList);
    lists.add(madeList);
  }

  @override
  Widget build(BuildContext context) {
    final width = ScreenUtil().setWidth(360);
    final height = ScreenUtil().setHeight(690);
    return Scaffold(
      body: Container(
        height: height,
        padding: EdgeInsets.fromLTRB(width*0.08, height*0.03, width*0.08, 0),
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    Container(
                      child: Text('당신은?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                      alignment: Alignment.bottomLeft,
                    ),
                    Container(
                      child: Text('   교수님이 탐내는 인재'),
                      alignment: Alignment.bottomCenter,
                    )
                ],) 
              ),
              Spacer(
                flex:1
              ),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Container(
                  width: width,
                  child: Center(
                    child: RadarChart(
                      data: [[5, 3, 2, 1, 4]],
                      features: ['    학업  ', '   사랑  ', '   체력  ', '  경험  ', '  관계 '],
                      ticks: [1, 2, 3, 4, 5],
                      sides: 5,
                      axisColor: Color(0xFFDBE4FF),
                      graphColors: [Color(0xFF91A7FF)],
                      outlineColor: Color(0xFFBAC8FF),
                      featuresTextStyle: 
                        TextStyle(
                          fontSize: 13, 
                          color: Colors.grey[800]
                        ),
                    )
                  )
                )
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: currentIndex == 0 ?
                          Container(
                            margin: EdgeInsets.fromLTRB(width*0.02, 0, 0.02, 0),
                            height: height*0.06,
                            decoration : const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                              ),
                              child: Text('완료 퀘스트'), 
                              onPressed: () {
                                setState(() {
                                  currentIndex = 0;
                                });
                              }
                            )
                          ) :
                          Container(
                            margin: EdgeInsets.fromLTRB(width*0.02, 0, 0.02, 0),
                            height: height*0.06,
                            decoration : const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(0, 0, 0, 0),
                                ),
                              ),
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                              ),
                              child: Text('완료 퀘스트'), 
                              onPressed: () {
                                setState(() {
                                  currentIndex = 0;
                                });
                              }
                            )
                          ),
                      ),
                      Expanded(
                        child: currentIndex == 1 ?
                          Container(
                            margin: EdgeInsets.fromLTRB(width*0.02, 0, 0.02, 0),
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
                              child: Text('등록 퀘스트'), 
                              onPressed: () {
                                setState(() {
                                  currentIndex = 1;
                                });
                              }
                            )
                          ) :
                          Container(
                            margin: EdgeInsets.fromLTRB(width*0.02, 0, 0.02, 0),
                            height: height*0.06,
                            decoration : const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(0, 0, 0, 0),
                                ),
                              ),
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                              ),
                              child: Text('등록 퀘스트'), 
                              onPressed: () {
                                setState(() {
                                  currentIndex = 1;
                                });
                              }
                            )
                          ),
                      ),
                    ]
                  )
              ),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child:
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: lists[currentIndex].length,
                      itemBuilder: (context, position) {
                        return Card(
                          child: Row(
                            children: <Widget>[
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 2,
                              child:
                                Checkbox(
                                  value: lists[currentIndex][position].isChecked,
                                  checkColor: Color(0xFFFFFFFF),
                                  activeColor: Color(0xFF91A7FF), 
                                  onChanged: (value) {
                                    setState(() {
                                      lists[currentIndex][position].isChecked = value!;
                                      if (lists[currentIndex][position].isChecked == true) {
                                        lists[currentIndex][position].doneCount++;
                                      } else {
                                        lists[currentIndex][position].doneCount--;
                                      }
                                    });
                                  }
                                )
                            ),
                            Flexible(
                              flex: 10,
                              fit: FlexFit.tight,
                              child:
                                Text(lists[currentIndex][position].todoQuest),
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
                                  lists[currentIndex][position].doneCount.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF91A7FF))
                                )
                            ),
                          ],)
                        );
                      }
                    ),
              )
            ],
          )
      ),
    );
  }
}

