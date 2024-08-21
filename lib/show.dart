import 'dart:async';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart' hide TextDirection;

class Chat extends StatefulWidget {
  String dep;
  String level;
  Chat({required this.level,required this.dep});
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController message = TextEditingController();
  List _messages = [];
  String ?formattedDate;
  DateTime _currentDate = DateTime.now();
  Future<void> _sendMessage(String mess) async {
    final da = formattedDate;
    final _url = 'http://10.0.2.2//php_files/message.php';
    final res = await http.post(Uri.parse(_url),body: {
      'level':widget.level,
      'message':mess,
      'dep':widget.dep,
      'time':da.toString()
    });
    if (res.statusCode == 200) {
      setState(() {
        //_messages.add(mess.replaceAll('"', '').trim());
        _messages.add(mess);

        // Adding the message to the local list
        message.clear();
      });
      var red = jsonDecode(res.body);
      print(red);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications();
    // fetchNotification();
  }

  void fetchNotifications() async {

    final response = await http.post(Uri.parse('http://10.0.2.2/php_files/showmessage.php'),body:
    {
      'dep':widget.dep,
      'level':widget.level
    });
    if (response.statusCode == 200) {
      setState(() {
        _messages = response.body.split(','); // Splitting messages by comma

      });
    }
  }
 
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy MMMM d');
    formattedDate = dateFormat.format(_currentDate);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) => Column(

                children: [

                  if (index < _messages.length)
                    Row(

                      mainAxisAlignment: MainAxisAlignment.start,


                      children: [
                        BubbleSpecialOne(
                         
                          text: _messages[index]['mess'],
                          isSender: false,
                          color: Colors.green,
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  

                ],
              ),
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: message,
                    decoration: InputDecoration(labelText: 'Message'),
                    keyboardType: TextInputType.text,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String mess = message.text;
                    _sendMessage(mess);
                    message.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


