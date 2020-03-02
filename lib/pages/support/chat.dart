import 'dart:async';
import 'dart:io';

import 'package:home_ass/utils/res/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_ass/utils/time.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat extends StatelessWidget {
  final String currentUserID;

  Chat({Key key, @required this.currentUserID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ChatScreen(
        currentUserID: currentUserID,
        peerId: "cvoFk0PKcoSri1iJ16aTdL0Ahrw2",
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String peerId;
  final String currentUserID;

  ChatScreen({Key key, @required this.peerId, this.currentUserID}) : super(key: key);

  @override
  State createState() => new ChatScreenState(peerId: peerId, currentUserID: currentUserID);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key,
    @required this.peerId,
    @required this.currentUserID
  });

  String peerId;
  String currentUserID;

  var listMessage;
  String chatID;
  SharedPreferences prefs;

  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;

  final TextEditingController textEditingController = new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);

    chatID = '';

    isLoading = false;
    isShowSticker = false;
    imageUrl = '';

    setChatID();
  }

  onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
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
            'idTo': peerId,
            'timestamp': getTimeNow(1, DateTime.now()),
            'content': content,
            'type': type
          },
        );
      });
      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  // set chat id
  setChatID() async {
    prefs = await SharedPreferences.getInstance();

    if (currentUserID.hashCode <= peerId.hashCode) {
      chatID = '$currentUserID-$peerId';
    } else {
      chatID = '$peerId-$currentUserID';
    }

    //Firestore.instance.collection('users').document(currentUserID).updateData({'chattingWith': peerId});

    setState(() {});
  }

  // set chatting with var
  Future<bool> onBackPress() {
    //Firestore.instance.collection('users').document(currentUserID).updateData({'chattingWith': null});
    Navigator.pop(context);

    return Future.value(false);
  }

  // Loading screen
  Widget buildLoading() {
    return Positioned(
      child: isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
        ),
        color: Colors.white.withOpacity(0.8),
      )
          : Container(),
    );
  }

  // TextField for messages
  Widget buildTextInput() {
    return Row(
      children: <Widget>[
        Flexible(
          child: Container(
            margin: EdgeInsets.only(left: 8, right: 4, top: 1, bottom: 4),
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: primaryColor,
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
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          child: IconButton(
            icon: Icon(Icons.send),
            onPressed: () => onSendMessage(textEditingController.text, 0),
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
        stream: Firestore.instance.collection('users').where('id', isEqualTo: peerId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themeColor),
              ),
            );
          } else {
            var document = snapshot.data.documents[0];
            return Scaffold(
              primary: true,
              appBar: CustomAppBar(ds: document,),
              body: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      // List of messages
                      buildListMessage(),
                      // Input content
                      buildTextInput(),
                    ],
                  ),

                  // Loading
                  buildLoading()
                ],
              ),
            );
          }
        },
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildItem(int index, DocumentSnapshot ds, idFrom, timestamp) {
    if (idFrom == peerId){
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

  const CustomAppBar({
    Key key,
    @required this.ds
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepOrange,
        child: Container(
          margin: EdgeInsets.only(bottom: 8),
          child: Row(
            children: <Widget>[
              Container(
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {Navigator.pop(context);},
                ),
              ),
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                      ds['nickname'],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
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
        )
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(64);
}