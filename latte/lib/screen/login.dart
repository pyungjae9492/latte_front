import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:latte/screen/quest_list.dart';
import 'package:latte/screen/signup.dart';
import 'tab_view_wrapper.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
 
class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
 
  late String _id;
  late String _password;
  late String userToken;

  static final storage =
      new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업
      
  @override
  void initState() {
    super.initState();
    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userToken = (await storage.read(key: "token"))!;
    print(userToken);
    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (userToken != null) {
      getUserProfile();
      Get.to(TabViewWrapper());
    }
  }
 
  void validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      print('Form is valid ID: $_id, password: $_password');
    } else {
      print('Form is invalid ID: $_id, password: $_password');
    }
  }

  login() async {
    final response = await http.post( 
      Uri.parse('https://site1.public.nqo.me/rest-auth/login/'),
      headers: {"Accept": "application/json"},
      body: {
        'username': _id,
        'password': _password
      },
    );
    if (response.statusCode == 200) {
      await storage.write(key: 'token', value: jsonDecode(response.body)['key']);
    } else {
      throw Exception('Login Failed');
    }
  }

  getUserProfile() async {
    // final response = await http.get(
    //   Uri.parse('https://site1.public.nqo.me/rest-auth/login/'),
    //   headers: {"Accept": "application/json", },
    // );
    // if (response.statusCode == 200) {
      
    // } else {

    // }
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
                decoration: InputDecoration(labelText: 'ID'),
                validator: (value) => 
                value!.isEmpty ? 'ID can\'t be empty' : null,
                onSaved: (value) => _id = value!,
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
                onPressed: () {
                  validateAndSave();
                  login();

                }
              ),
              RaisedButton(
                child: new Text(
                  '회원 가입',
                  style: new TextStyle(fontSize: 20.0),
                ),
                onPressed: () => {
                  Get.to(SignUpPage())
                },
              ),
              TextButton(
                onPressed: () => {
                  Get.to(TabViewWrapper())
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