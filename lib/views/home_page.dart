import 'package:blood_donation_recommendation/views/login_page.dart';
import 'package:blood_donation_recommendation/views/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              return const SearchPage();
            }
            else {
              return const LogInPage();
            }
          default: 
            return const CircularProgressIndicator();
        }
      },
    );
  }
}