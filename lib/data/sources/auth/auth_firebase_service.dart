import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signin(SigninUserReq signinuserReq);

  Future<Either> signup(CreateUserReq createuserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserReq signinuserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinuserReq.email, password: signinuserReq.password);
      return const Right('Login was Succesfull');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid_email') {
        message =
            'The Email you Provided Doesn\'t Exist. Please Try Signing Up';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong Password Entered.Please Try Again!';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createuserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createuserReq.email, password: createuserReq.password);

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid)
      .set({
        'name': createuserReq.fullname,
        'email': data.user?.email,
      });

      return const Right('Sign Up was Succesfull');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message =
            'The Password Provided is too Weak. Please Try again with a Stronger Password';
      } else if (e.code == 'email-already-in-use') {
        message =
            'An account already Exists with this Email. Please Try Logging in';
      }
      return Left(message);
    }
  }
}
