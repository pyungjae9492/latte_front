import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'tab_view_wrapper.dart';
import 'package:get/get.dart';
import 'quest_list.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
 
class _SignUpState extends State<SignUpPage> {
  final formKey = new GlobalKey<FormState>();
 
  late String _username;
  late String _password;
 
  void validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      print('Form is valid Email: $_username, password: $_password');
    } else {
      print('Form is invalid Email: $_username, password: $_password');
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                value!.isEmpty ? 'Email can\'t be empty' : null,
                onSaved: (value) => _username = value!,
              ),
              TextFormField(
                obscureText: true,
                decoration: new InputDecoration(labelText: 'Password'),
                validator: (value) =>
                value!.isEmpty ? 'Password can\'t be empty' : null,
                onSaved: (value) => _password = value!,
              ),
              RaisedButton(
                child: new Text(
                  '로그인',
                  style: new TextStyle(fontSize: 20.0),
                ),
                onPressed: validateAndSave,
              ),
              RaisedButton(
                child: new Text(
                  '회원 가입',
                  style: new TextStyle(fontSize: 20.0),
                ),
                onPressed: validateAndSave,
              ),
              TextButton(
                onPressed: () => {
                  Get.to(QuestList())
                }, 
                child: Text('로그인하지 않고 시작')
              )
            ],
          ),
        ),
      ),
    );
  }
}