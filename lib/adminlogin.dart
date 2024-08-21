import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'message.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';
  String ?errorText;
  Future<void> _loginUser() async {
    Map<String, dynamic>? _user;
    final response = await http.post(Uri.parse('http://10.0.2.2/php_files/login.php'),body: {
      'username': _usernameController.text,
      'password': _passwordController.text,
    });
    if (response.statusCode == 200) {
      // Login successful
      final userData = jsonDecode(response.body);

      print(userData);
      if (userData["result"] == "not here") {
        setState(() {
          print(userData['dep']);
          errorText = " اسم السمتخدم او كلمة المرور غير صحيحة";
        });
      }
      else {
        setState(() {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Message(dep: userData!['dep'],)));
        });
        print(_user!['dep']);
      }

      // Perform any additional actions, such as navigating to a home screen
    } else {
      // Login failed
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:TextDirection.rtl,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: PreferredSize(

             preferredSize: Size.fromHeight(50),
             child: AppBar(
               title: Text("تسجيل الدخول"),
               centerTitle: true,

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
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'اسم المستخدم',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
            ),
          ),

                SizedBox(height: 16.0),
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
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'كلمة المرور',

                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
                SizedBox(height: 32.0),
                Visibility(
                    visible: errorText!=null,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(errorText??"",style: TextStyle(color: Colors.red),),
                    )
                ),
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
      ),
    );
  }
}