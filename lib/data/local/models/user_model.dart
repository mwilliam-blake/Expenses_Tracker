import '../db/db_helper.dart';

class UserModel {
  int? id; //auto increment
  String uname;
  String passwd;
  String email;
  String mobile;
  String created_at;

  UserModel({
    this.id,
    required this.uname,
    required this.passwd,
    required this.email,
    required this.mobile,
    required this.created_at});

  /// methods
  ///1 fromMap to Model
  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
        id: map[DBHelper.TBL_USER_UID],
        uname: map[DBHelper.TBL_USER_UNAME],
        passwd: map[DBHelper.TBL_USER_PASSWRD],
        email: map[DBHelper.TBL_USER_UEMAIL],
        mobile: map[DBHelper.TBL_USER_MOB],
        created_at: map[DBHelper.TBL_USER_CREATED_AT]);
  }


  ///2 from Model toMap
  Map<String, dynamic> toMap(){
    return {
      DBHelper.TBL_USER_UNAME : uname,
      DBHelper.TBL_USER_PASSWRD : passwd,
      DBHelper.TBL_USER_UEMAIL : email,
      DBHelper.TBL_USER_MOB : mobile,
      DBHelper.TBL_USER_CREATED_AT : created_at,
    };
  }

}