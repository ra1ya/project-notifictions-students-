import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' hide TextDirection;
import 'package:rayan_project/register.dart';
import 'package:rayan_project/showmessageadmin.dart';

class Message extends StatefulWidget {
  String dep;
  Message({required this.dep});
  @override
  _MyWidgetState createState() => _MyWidgetState();
}
class _MyWidgetState extends State<Message> {
  String _selectedValue = 'L1';
  String ?formattedDate;
  DateTime _currentDate = DateTime.now();
  TextEditingController _textFieldController = TextEditingController();
  final _url = 'http://10.0.2.2//php_files/message.php';
  void nexe(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowAdmin(dep: widget.dep, level: _selectedValue)));
  }
  void _submitData() async {
    final da = formattedDate;
    final response = await http.post(Uri.parse(_url),body: {
      'level':_selectedValue,
      'message':_textFieldController.text,
       'dep':widget.dep,
      'time':da.toString()
    });
    if (response.statusCode == 200) {
       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text("تم ارسال الرسالة بنجاح")),
       );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطا في ارسال الرسالة")),
      );
    }
  }
  void submit(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowAdmin(dep: widget.dep, level: _selectedValue)));
  }
 
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy MMMM d');
     formattedDate = dateFormat.format(_currentDate);
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: widget.dep =="IT"?Text("قسم تقنية المعلومات"):widget.dep =="acc"?Text("محاسبة"):widget.dep =="mang"?Text("ادارة اعمال"):widget.dep =="info"?Text("نظم معلومات"):widget.dep =="english"?Text("اللغة الانجليزية"):widget.dep =="quran"?Text("القران وعلومة"):widget.dep =="shar"?Text("الشريعة"):widget.dep =="feg"?Text("الفقه"):Text(""),
            centerTitle: true,
            actions: [
              PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'reg') {
                    print(widget.dep);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage(dep: widget.dep,)),
                    );
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'reg',
                    child: Text('اضافة طالب'),
                  ),
                ],
              ),
            ],
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButtonFormField<String>(
                      alignment: Alignment.centerRight,
                      value: _selectedValue,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedValue = newValue!;
                        });
                      },
                      items: ['L1', 'L2', 'L3','L4','all']
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
                    SizedBox(height: 16.0),
                    TextField(
                      maxLines: 10,
                      minLines: 3,
                      controller: _textFieldController,
                      decoration: InputDecoration(
                        labelText: 'الرسالة',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: _submitData,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                      ),
                      child: Text(
                        "ارسال",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: submit,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                      ),
                      child: Text(
                        "عرض الرسائل",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

      ),
    );
  }
}
