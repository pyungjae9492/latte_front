import 'package:flutter/material.dart';
import 'quest_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late List<QuestItem> clear_list = [];

  @override
  void initState() {
    super.initState();
    clear_list.add(QuestItem(1, '버들골에서 짜장면 먹기', 3, '서울대', 1));
    clear_list.add(QuestItem(2, '버들골에서 짜장면 만들기', 2, '서울대', 1));
    clear_list.add(QuestItem(3, '버들골에서 짜장면 부수기', 1, '서울대', 1));
    clear_list.add(QuestItem(4, '버들골에서 짜장면 엎기', 6, '서울대', 1));
    clear_list.add(QuestItem(5, '버들골에서 짜장면 안 먹기', 9, '서울대', 1));
    clear_list.add(QuestItem(6, '버들골에서 짜장면은 안 멋져', 7, '서울대', 1));
    clear_list.add(QuestItem(7, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
    clear_list.add(QuestItem(8, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
    clear_list.add(QuestItem(9, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
    clear_list.add(QuestItem(10, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
    clear_list.add(QuestItem(11, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
    clear_list.add(QuestItem(12, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
    clear_list.add(QuestItem(13, '안암에서 짜장면은 안 멋져', 7, '고려대', 1));
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
                        child: 
                        Container(
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
                            child: Text('완료 퀘스트'), 
                            onPressed: () {}
                          )
                        ),
                      ),
                      Expanded(
                        child:
                          Container(
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
                              child: Text('등록 퀘스트'), 
                              onPressed: () {}
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
                      itemCount: clear_list.length,
                      itemBuilder: (context, position) {
                        return Card(
                          child: Row(children: <Widget>[
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 2,
                              child:
                              Checkbox(
                                value: clear_list[position].isChecked,
                                checkColor: Color(0xFFFFFFFF),
                                activeColor: Color(0xFF91A7FF), 
                                onChanged: (value) {
                                  setState(() {
                                    clear_list[position].isChecked = value!;
                                    if (clear_list[position].isChecked == true) {
                                      clear_list[position].like++;
                                    } else {
                                      clear_list[position].like--;
                                    }
                                  });
                                }
                              ),
                            ),
                            Flexible(
                              flex: 10,
                              fit: FlexFit.tight,
                              child:
                                Text(clear_list[position].todoQuest),
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
                                  clear_list[position].like.toString(),
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