import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_ass/pages/settings/support.dart';
import 'package:home_ass/pages/support/chat.dart';
import 'package:home_ass/utils/res/transitions.dart';

isUserSignedIn(){
  if (FirebaseAuth.instance.currentUser() == null){
    return false;
  }
  else{
    return true;
  }
}

signInAnonymously(int index, BuildContext context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser = (await _auth.signInAnonymously()).user;

  try {
    if (firebaseUser != null) {
      // Check if is in db
      final QuerySnapshot result =
      await Firestore.instance.collection('requests').where(
          'id', isEqualTo: firebaseUser.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        Firestore.instance.collection('requests')
            .document(firebaseUser.uid)
            .setData({
          'id': firebaseUser.uid,
          'createdAt': DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
        });
      }
    }
  } catch (e) {
    print(e);
  }

  if(isUserSignedIn() == true){
    var usrID = firebaseUser.uid;
    print("usrID: " + usrID);
    Navigator.of(context).push(SlideRouteFromRight(page: ChatScreen(currentUserID: usrID, topic: topicList[index])));
  }
}