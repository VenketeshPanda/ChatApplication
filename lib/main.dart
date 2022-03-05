import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ichat_app/allConstants/app_constants.dart';
import 'package:ichat_app/allProviders/auth_provider.dart';
import 'package:ichat_app/allProviders/chat_provider.dart';
import 'package:ichat_app/allProviders/home_provider.dart';
import 'package:ichat_app/allProviders/settings_provider.dart';
import 'package:ichat_app/allScreens/home_page.dart';
import 'package:ichat_app/allScreens/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isWhite = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn(),
              prefs: this.prefs,
              firebaseFirestore: this.firebaseFirestore,
            ),
        ),
        Provider<SettingProvider>(
          create: (_) => SettingProvider(
              prefs: this.prefs,
              firebaseFirestore: this.firebaseFirestore,
              firebaseStorage: this.firebaseStorage,
          ),
        ),
      Provider<HomeProvider>(
        create: (_) => HomeProvider(
            firebaseFirestore: this.firebaseFirestore
        ),
      ),
        Provider<ChatProvider>(
            create: (_) => ChatProvider(
                firebaseFirestore: this.firebaseFirestore,
                prefs: this.prefs,
                firebaseStorage: this.firebaseStorage
            ),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appTitle,
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}