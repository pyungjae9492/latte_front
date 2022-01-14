import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        height: 70,
        child: const TabBar(
          labelColor: Color(0xFF91A7FF),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.person_outlined,
                size: 30,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.checklist_rounded,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}