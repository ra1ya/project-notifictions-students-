import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rayan_project/showmessage.dart';


import 'adminlogin.dart';

class Studentlogin extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Studentlogin> {
  final code = TextEditingController();

  String ?errorText;
  String _errorMessage = '';
  Future<void> _loginUser() async {
    Map<String, dynamic>? _user;

    final response = await http.post(Uri.parse('http://10.0.2.2//php_files/studentlogin.php'),body: {
      'code': code.text,
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      // Login successful
      final userData = jsonDecode(response.body);
      print(userData);
      if (userData["result"] == "not here") {
        setState(() {
          print(userData['dep']);
          errorText = " رقم القيد غير موجود";
        });
      }
      else{
        print(userData['dep']);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            ChatPage(dep: userData!['dep'], level: userData!['level'])));
        print(userData!['dep']);
    }
      // Perform any additional actions, such as navigating to a home screen
    } else {
      // Login failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("الطالب غير موجود في هذا القسم")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            title: Text("تسجيل دخول كطالب ..."),
            centerTitle: true,
            actions: [
              PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'admin') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'admin',
                    child: Text('حساب مسؤول'),
                  ),
                ],
              ),
            ],

          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: code,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'رقم القيد',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Visibility(
                visible: errorText!=null,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(errorText??"",style: TextStyle(color: Colors.red),),
                  )
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _loginUser,
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                child: Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

