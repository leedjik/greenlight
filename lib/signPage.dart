import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import 'data/user.dart';

class SignPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignPage();
}

class _SignPage extends State<SignPage> {

  String _databaseURL = '###';

  TextEditingController? _idTextController;
  TextEditingController? _pwTextController;
  TextEditingController? _pwCheckTextController;

  @override
  void initState() {
    super.initState();
    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();
    _pwCheckTextController = TextEditingController();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _idTextController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: '4자 이상 입력해주세요',
                    labelText: '아이디',
                    border: OutlineInputBorder()),),),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _pwTextController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      hintText: '대소문자 6자 이상 입력해주세요',
                      labelText: '패스워드',
                      border: OutlineInputBorder()),),),
              SizedBox(height: 20,),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _pwCheckTextController,
                  obscureText: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: '패스워드 확인',
                      border: OutlineInputBorder()),),),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  if(_idTextController!.value.text.length >= 4 &&
                    _pwTextController!.value.text.length >= 6) {
                    if(_pwTextController!.value.text == _pwCheckTextController!.value.text) {
                      var bytes = utf8.encode(_pwTextController!.value.text);
                      var digest = sha1.convert(bytes);
                      reference!
                          .child(_idTextController!.value.text)
                          .push()
                          .set(User(_idTextController!.value.text,
                              digest.toString(), DateTime.now().toIso8601String())
                              .toJson())
                          .then((_) {
                            Navigator.of(context).pop();
                      });
                    } else {
                      makeDialog('패스워드가 다릅니다');
                    }
                  } else {
                    makeDialog('길이가 짧습니다');
                  }
                },
                child: Text(
                  '회원가입',
                  style: TextStyle(color: Colors.white),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),)],
            mainAxisAlignment: MainAxisAlignment.center,),
        ),),);
  }

  void makeDialog(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(text),
          );
        });
  }
}