import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier{
  String token;
  String userId;

  Future<void> authe(String email, String password, String urlSegment)async{
     final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDZy3Qmh7Vu2FmLzkpzgRBNdN_dgOcVsNE';
      try{
        final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        print(responseData['error']) ;
      }
      token = responseData['idToken'];
      userId = responseData['localId'];
      }catch(error){
        throw(error);
      }
      notifyListeners();
  }

  void logout(){
    token=null;
    userId=null;
    notifyListeners();
  }
}