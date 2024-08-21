import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class RegisterPage extends StatefulWidget {
   String dep;
   RegisterPage({required this.dep});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  String _selectedValue = 'L1';
  final code = TextEditingController();
  final fullname = TextEditingController();
  final dep = TextEditingController();
  final level = TextEditingController();
  String _errorMessage = '';
  Future<void> _RegisterUser() async {
    Map<String, dynamic>? _user;
    final response = await http.post(Uri.parse('http://10.0.2.2//php_files/register.php'),body: {
      'code': code.text,
      'fullname': fullname.text,
      'dep': widget.dep,
      'level': _selectedValue,
    });
    if (response.statusCode == 200) {
      // Login successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تم اضافة الطالب بنجاح")),
      );
      // Perform any additional actions, such as navigating to a home screen
    } else {
      // Login failed


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطا في اضافة الطالب ")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("اضافة طالب"),
          centerTitle: true,
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
                  keyboardType: TextInputType.number,
                  controller: code,
                  decoration: InputDecoration(
                    hintText: 'رقم القيد',
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
                  controller: fullname,
                  decoration: InputDecoration(
                    hintText: 'الاسم الكامل',

                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                ),
              ),
              SizedBox(height: 32.0),

              DropdownButtonFormField<String>(
                alignment: Alignment.centerRight,
                value: _selectedValue,
                onChanged: (newValue) {
                  setState(() {
                    _selectedValue = newValue!;
                  });
                },
                items: ['L1', 'L2', 'L3','L4']
                    .map((value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,textAlign:TextAlign.right,),
                ))
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'المستوى',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 40,),
              ElevatedButton(
                onPressed: _RegisterUser,
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                child: Text(
                  "تسجيل الطالب",
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
