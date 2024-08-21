import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ChatPage extends StatefulWidget {
  String dep;
  String level;
  ChatPage({required this.dep,required this.level});
  @override
  _ChatPageState createState() => _ChatPageState();
}
class _ChatPageState extends State<ChatPage> {
  List messages =[];
  List current_message=[];
  @override
  void initState() {
    super.initState();
    fetchMessages();
  }
  Future<void> fetchMessages() async {
    print(widget.dep);
    print(widget.level);
    final response = await http.post(Uri.parse('http://10.0.2.2//php_files/showmessage.php'),body:
    {
     'dep':widget.dep,
      'level':widget.level
    });
    if (response.statusCode == 200) {
      setState(() {
        messages = jsonDecode(response.body);

      });
    } else {

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

            title: Row(
              children: [
                Padding(padding: EdgeInsets.only(right: 155),
                  child: Text(widget.level),
                ),
                SizedBox(width: 3,),
                Padding(padding: EdgeInsets.only(right: 50),
                  child: Text(widget.dep),
                ),
              ],
            ) ,

          ),
        ),
        body:Padding(
         padding: EdgeInsets.only(top: 30),
             child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {

            return ListTile(
              subtitle: Text(messages[index]["times"],style: TextStyle(color: Colors.blue),),
              title: Container(
                  width: 250,
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                    width: 200,

                    child: Text(
                      messages[index]["mess"],
                      style: TextStyle(
                        color:  Colors.white ,
                        fontSize: 16.0,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),

            );
          },
        ),
      ),),
    );
  }
}

