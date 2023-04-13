import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pps_web_admin/components/widget/drawer.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CustomDrawer(),
          SizedBox(
            width: 0.02.sw,
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .orderBy('createdAt')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        List<DocumentSnapshot> docs = snapshot.data!.docs;
                        List<Widget> messages = docs
                            .map((doc) => Message(
                          from: doc['from'],
                          text: doc['text'],
                          me: _user.uid == doc['from'],
                        ))
                            .toList();
                        return ListView(
                          children: <Widget>[
                            ...messages,
                          ],
                        );
                      }
                    },
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Enter message',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          await FirebaseFirestore.instance.collection('chats').add({
                            'text': _textController.text.trim(),
                            'createdAt': DateTime.now().toIso8601String(),
                            'from': _user.uid,
                          });
                          _textController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class Message extends StatelessWidget {
  Message({required this.from, required this.text, required this.me});

  final String from;
  final String text;
  final bool me;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment:
        me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          !me
              ? CircleAvatar(
            child: Text(from.substring(0, 1)),
          )
              : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment:
              me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                // Text(
                //   from,
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                Container(
                  margin:EdgeInsets.only(top: 5.0,left:me ?0: 5,right: me?5:0),
                  child: Text(text),
                ),
              ],
            ),
          ),
          me
              ? CircleAvatar(
            child: Text(from.substring(0, 1)),
          )
              : Container(),
        ],
      ),
    );
  }
}
