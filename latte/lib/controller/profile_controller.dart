import 'package:get/get.dart';
import 'package:latte/model/model_quest_item.dart';
import 'package:http/http.dart' as http;
import '../model/api_adapter.dart';
import '../model/model_user.dart';
import 'dart:convert';

class ProfileController extends GetxController{
  User currentUser = User(id: 1, nickname: '평재', school: '서울대학교');

  updateProfile() async {

  }

  getProfile() async {
    
  }
}


