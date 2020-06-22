import 'dart:async';

import 'package:home_ass/utils/res/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_ass/utils/time.dart';

class ChatScreen extends StatefulWidget {
  final String topic;
  final String currentUserID;

  ChatScreen({Key key, this.currentUserID, this.topic}) : super(key: key);

  @override
  State createState() => new ChatScreenState(currentUserID: currentUserID, topic: topic);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key,
    @required this.topic,
    @required this.currentUserID
  });

  String topic, chatID, currentUserID;
  String supportId = "CyF6ii4gq8Vrbv6GOtFhnB5ajtq2";
  var listMessage;
  bool isLoading;

  final TextEditingController textEditingController = new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    chatID = '';
    setChatID();
  }

  onSendMessage(String content) {
    if (content.trim() != '') {
      textEditingController.clear();
      var documentReference = Firestore.instance
          .collection('messages')
          .document(chatID)
          .collection(chatID)
          .document(getTimeNow(1, DateTime.now()));

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': currentUserID,
            'idTo': supportId,
            'timestamp': getTimeNow(1, DateTime.now()),
            'content': content,
            'topic': topic,
          },
        );
      });
      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }
  setChatID() async {
    if (currentUserID.hashCode <= supportId.hashCode) {
      chatID = '$currentUserID-$supportId-$topic';
    } else {
      chatID = '$supportId-$currentUserID-$topic';
    }
    setState(() {});
  }
  Future<bool> onBackPress() {
    Navigator.pop(context);

    return Future.value(false);
  }
  Widget buildTextInput() {
    return Row(
      children: <Widget>[
        Flexible(
          child: Container(
            margin: EdgeInsets.only(left: 8, right: 4, top: 1, bottom: 8),
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            child: TextField(
              cursorColor: Colors.white,
              controller: textEditingController,
              maxLines: 3,
              minLines: 1,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration.collapsed(
                hintText: 'Nachricht',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 8,bottom: 8),
          decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          child: IconButton(
            icon: Icon(Icons.send),
            onPressed: () => onSendMessage(textEditingController.text),
            color: Colors.white,
          ),
        )
      ],
    );
  }

  // General layout
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: StreamBuilder(
        stream: Firestore.instance.collection('requests').where('id', isEqualTo: supportId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themeColor),
              ),
            );
          } else {
            var document = snapshot.data.documents[0];
            return Material(
              color: secondaryColor,
              child: SafeArea(
                child: Scaffold(
                  bottomNavigationBar: Container(margin: EdgeInsets.only(bottom: 8),child: buildTextInput(),),
                  appBar: CustomAppBar(ds: document,topic: topic,),
                  body: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          buildListMessage(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildItem(int index, DocumentSnapshot ds, idFrom, timestamp) {
    if (idFrom == supportId){
      return Row(
        children: <Widget>[
          Flexible(
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(bottom: 6, right: 40),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      splitTimestamp(timestamp),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 9,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      ds['content'],
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      );
    }else{
      return Row(
        children: <Widget>[
          Flexible(
            child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.only(bottom: 6, left: 40),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Text(
                          ds['content'],
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          splitTimestamp(timestamp),
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 9,
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    }
  }

  Widget buildListMessage() {
    return Flexible(
      child: chatID == ''
          ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
          : StreamBuilder(
        stream: Firestore.instance
            .collection('messages')
            .document(chatID)
            .collection(chatID)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
          } else {
            listMessage = snapshot.data.documents;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => buildItem(index, snapshot.data.documents[index], snapshot.data.documents[index]['idFrom'], snapshot.data.documents[index]['timestamp']),
              itemCount: snapshot.data.documents.length,
              reverse: true,
              controller: listScrollController,
            );
          }
        },
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final DocumentSnapshot ds;
  final String topic;

  const CustomAppBar({
    Key key,
    @required this.ds, this.topic
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Container(
              child: Text(
                "Support - " + topic,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.none
                  )
              ),
            )
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.more_vert),
              color: Colors.white,
              onPressed: (){},
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}