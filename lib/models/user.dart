class UserModel {
  static const ID = "id";
  static const AVATAR = "avatar";
  static const EMAIL = "email";
  static const FIRSTNAME = "first_name";
  static const SECONDNAME = "second_name";

  int _id;
  String _avatae;
  String _firstName;
  int _totalPageCount;
  String _secondName;
  String _email;

  String get email => _email;
  String get secondName => _secondName;
  int get id => _id;
  int get totalPageCount => _totalPageCount;
  String get avatar => _avatae;
  String get firstName => _firstName;

  UserModel.fromMap(Map pp, int tPC) {
    _firstName = pp[FIRSTNAME];
    _secondName = pp[SECONDNAME];
    _avatae = pp[AVATAR];
    _totalPageCount = tPC;
    _id = pp[ID];
    _email = pp[EMAIL];
  }
}
