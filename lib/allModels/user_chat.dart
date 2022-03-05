import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ichat_app/allConstants/constants.dart';

class UserChat{
  String id;
  String photoUrl;
  String nickname;
  String aboutMe;
  String phoneNumber;


  UserChat({
    required this.id,
    required this.photoUrl,
    required this.nickname,
    required this.aboutMe,
    required this.phoneNumber,
});

  Map<String, String> toJson(){
    return{
      FirestoreConstants.nickname: nickname,
      FirestoreConstants.aboutMe: aboutMe,
      FirestoreConstants.photoUrl: photoUrl,
      FirestoreConstants.phoneNumber: phoneNumber,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc){
    String aboutMe = "";
    String photoUrl = "";
    String nickName = "";
    String phoneNumber = "";

    try{
      aboutMe = doc.get(FirestoreConstants.aboutMe);
    }
    catch(e){}

    try{
      photoUrl = doc.get(FirestoreConstants.photoUrl);
    }
    catch(e){}

    try{
      phoneNumber = doc.get(FirestoreConstants.phoneNumber);
    }
    catch(e){}

    try{
      nickName = doc.get(FirestoreConstants.nickname);
    }
    catch(e){}


    return UserChat(
        id: doc.id,
        photoUrl: photoUrl,
        nickname: nickName,
        aboutMe: aboutMe,
        phoneNumber: phoneNumber,
    );
  }
}