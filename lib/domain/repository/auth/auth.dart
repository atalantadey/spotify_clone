import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';

abstract class AuthRepository {
  Future<Either> signup(CreateUserReq createuserReq);
  Future<Either> signin(SigninUserReq signinuserReq);
  Future<Either> getUser();
}
