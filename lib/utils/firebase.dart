import 'package:firebase_auth/firebase_auth.dart';

isUserSignedIn(){
  if (FirebaseAuth.instance.currentUser() == null){
    return false;
  }
  else{
    return true;
  }
}