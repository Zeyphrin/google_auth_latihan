import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignInAccount? _currentUser;

  GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _googleSignIn.onCurrentUserChanged.listen((account) { 
      setState(() {
        _currentUser = account;
      });
    });
    
  }

  Future<void> _handleSignIn() async{
    try{
      await _googleSignIn.signIn();
      print("email saya" + _currentUser!.email.toString());
    } catch(error){
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sign In"),),
        body: _currentUser == null? Center(
          child: Container(
            child: ElevatedButton(onPressed: () => _handleSignIn()
            , child: Text('Login Google')),
          ),
        ): Container(
          child: Text("email saya "+ _currentUser!.email.toString()),
        ),
    );
  }
}