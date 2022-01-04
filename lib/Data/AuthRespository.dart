// ignore_for_file: avoid_print, prefer_final_fields

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/Domain/Logic/Autenticate/AbstratAutenticate.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/Domain/Models/Hive/UserModel.dart';

@Named('Env.dev')
@Injectable(as: AbstractAutenticate)
@injectable
class AuthReposotory implements AbstractAutenticate {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.i;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Future googleSign() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final resp = await _auth.signInWithCredential(credential);
      await _firestore.collection('Users').doc().set({
        'email': resp.user!.email,
        'photo': resp.user!.photoURL,
        'name': resp.user!.displayName,
        'method': "Google"
      });
      if (resp.credential != null && resp.user != null) {
        final data = await getdataUser();
        if (data) {
          return {"success": true, "conection": true, "message": ""};
        } else {
          return {"success": false, "conection": true, "message": "Error"};
        }
      } else {
        return {"success": false, "conection": true, "message": "Error"};
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      switch (e.message) {
        case "The email address is already in use by another account.":
          return {
            "success": false,
            "conection": true,
            "message": "El correo ya exisistente"
          };
        case "User with this email has been disabled.":
          return {
            "success": false,
            "conection": true,
            "message": "Cuenta desactivada"
          };
        case "User with this email doesn't exist.":
          return {
            "success": false,
            "conection": true,
            "message": "Cuenta inexistente"
          };
        case "com.google.firebase.FirebaseException: An internal error has occurred. [ Read error:ssl=0x794b9e8888: I/O error during system call, Connection reset by peer ]":
          return {
            "success": false,
            "conection": true,
            "message": "Error conexion lenta"
          };
        default:
          return {
            "success": false,
            "conection": true,
            "message": "Error de conexion con servidor"
          };
      }
    }
  }

  @override
  Future singOut() async {
    final box = Hive.box<UserModel>('User');
    final boxkeylast = box.keys.isNotEmpty ? box.keys.last : 0;
    await box.delete(boxkeylast);
    await _googleSignIn.signOut();
    await _auth.signOut();
    await _facebookAuth.logOut();
  }

  @override
  Future facebookSign() async {
    try {
      final facebookLogin =
          await FacebookAuth.i.login(loginBehavior: LoginBehavior.webOnly);
      if (facebookLogin.accessToken != null) {
        final facebookAuthCredential =
            FacebookAuthProvider.credential(facebookLogin.accessToken!.token);
        final resp = await _auth.signInWithCredential(facebookAuthCredential);

        final data = await FacebookAuth.i.getUserData();
        await _firestore.collection('Users').doc().set({
          'email': data['email'],
          'photo': data['picture']['data']['url'],
          'name': data['name'],
          'method': "Facabook"
        });
        if (resp.credential != null && resp.user != null) {
          final data = await getdataUser();
          if (data) {
            return {"success": true, "conection": true, "message": ""};
          } else {
            return {"success": false, "conection": true, "message": "Error"};
          }
        } else {
          return {"success": false, "conection": true, "message": "Error"};
        }
      } else {
        return {"success": false, "conection": true, "message": "Error"};
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      switch (e.message) {
        case "The email address is already in use by another account.":
          return {
            "success": false,
            "conection": true,
            "message": "El correo ya exisistente"
          };
        case "User with this email has been disabled.":
          return {
            "success": false,
            "conection": true,
            "message": "Cuenta desactivada"
          };
        case "User with this email doesn't exist.":
          return {
            "success": false,
            "conection": true,
            "message": "Cuenta inexistente"
          };
        case "com.google.firebase.FirebaseException: An internal error has occurred. [ Read error:ssl=0x794b9e8888: I/O error during system call, Connection reset by peer ]":
          return {
            "success": false,
            "conection": true,
            "message": "Error conexion lenta"
          };
        default:
          return {
            "success": false,
            "conection": true,
            "message": "Error de conexion con servidor"
          };
      }
    }
  }

  @override
  Future emailAndPassSign({required String email, required String pass}) async {
    try {
      final resp =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      if (resp.user != null) {
        final data = await getdataUser();
        if (data) {
          return {"success": true, "conection": true, "message": ""};
        } else {
          return {"success": false, "conection": true, "message": "Error"};
        }
      } else {
        return {"success": false, "conection": true, "message": "Error"};
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      switch (e.message) {
        case "The email address is already in use by another account.":
          return {
            "success": false,
            "conection": true,
            "message": "El correo ya exisistente"
          };
        case "User with this email has been disabled.":
          return {
            "success": false,
            "conection": true,
            "message": "Cuenta desactivada"
          };
        case "User with this email doesn't exist.":
          return {
            "success": false,
            "conection": true,
            "message": "Cuenta inexistente"
          };
        case "com.google.firebase.FirebaseException: An internal error has occurred. [ Read error:ssl=0x794b9e8888: I/O error during system call, Connection reset by peer ]":
          return {
            "success": false,
            "conection": true,
            "message": "Error conexion lenta"
          };
        default:
          return {
            "success": false,
            "conection": true,
            "message": "Error de conexion con servidor"
          };
      }
    }
  }

  @override
  Future emailAndPassSignUp(
      {required String email, required String pass}) async {
    try {
      final resp = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      await _firestore.collection('Users').doc().set({
        'email': email,
        'photo': '',
        'name': '',
        'method': "Email and Password"
      });
      if (resp.user != null) {
        final data = await getdataUser();
        if (data) {
          return {"success": true, "conection": true, "message": ""};
        } else {
          return {"success": false, "conection": true, "message": "Error"};
        }
      } else {
        return {"success": false, "conection": true, "message": "Error"};
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      switch (e.message) {
        case "The email address is already in use by another account.":
          return {
            "success": false,
            "conection": true,
            "message": "El correo ya exisistente"
          };
        case "User with this email has been disabled.":
          return {
            "success": false,
            "conection": true,
            "message": "Cuenta desactivada"
          };
        case "User with this email doesn't exist.":
          return {
            "success": false,
            "conection": true,
            "message": "Cuenta inexistente"
          };
        case "com.google.firebase.FirebaseException: An internal error has occurred. [ Read error:ssl=0x794b9e8888: I/O error during system call, Connection reset by peer ]":
          return {
            "success": false,
            "conection": true,
            "message": "Error conexion lenta"
          };
        default:
          return {
            "success": false,
            "conection": true,
            "message": "Error de conexion con servidor"
          };
      }
    }
  }

  @override
  Future getdataUser() async {
    try {
      var body = {
        "data": {
          "nombreUsuario": "odraude1362@gmail.com",
          "clave": "Jorgito123"
        }
      };
      final resp = await http.post(
          Uri.parse(
              "https://apim3w.com/api/index.php/v1/soap/LoginUsuario.json"),
          headers: {
            "X-MC-SO": "WigilabsTest",
          },
          body: json.encode(body));

      if (resp.statusCode == 200) {
        final resbody = json.decode(resp.body);
        final usuario = resbody["response"]["usuario"];
        final box = Hive.box<UserModel>('User');
        await box.delete(0);
        UserModel userModel = UserModel(
            identification: usuario["DocumentNumber"],
            name: usuario["nombre"],
            email: usuario["UserProfileID"],
            lastname: usuario["apellido"]);

        await box.add(userModel);
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }
}
