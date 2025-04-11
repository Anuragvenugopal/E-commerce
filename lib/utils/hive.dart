




import 'package:hive/hive.dart';

import 'constants.dart';

AppHive appHive = AppHive();

class AppHive {
  // void main (){}

  // void openBox()async{
  //   await Hive.openBox(Constants.BOX_NAME);
  //
  // }
  static const String _USER_ID = "user_id";

  static const String _ISLOGGEDIN = "isLoggedIn";
  static const String _VIDEOSOUNDSTATUS = "video_sound_status";
  static const String _IS_SIGNED_IN_USER = "isSignedInUser";
  static const String _NAME = "name";
  static const String _TOKEN = "token";


  void hivePut({String? key, String? value}) async {
    await Hive.box(Constants.BOX_NAME).put(key, value);
  }

  void hivePutInt({String? key, int? value}) async {
    await Hive.box(Constants.BOX_NAME).put(key, value);
  }

  void hivePutBool({String? key, bool? value}) async {
    await Hive.box(Constants.BOX_NAME).put(key, value);
  }

  bool? hiveGetBool({String? key}) {
    return Hive.box(Constants.BOX_NAME).get(key) ?? false;
  }

  String hiveGet({String? key}) {
    return Hive.box(Constants.BOX_NAME).get(key) ?? "";
  }

  int hiveGetInt({String? key}) {
    // openBox();
    return Hive.box(Constants.BOX_NAME).get(key) ?? 0;
  }

  putUserId({String? userId}) async {
    hivePut(key: _USER_ID, value: userId);
  }

  String getUserId() {
    return hiveGet(key: _USER_ID);
  }
  bool? getIsUserLoggedIn() {
    return Hive.box(Constants.BOX_NAME).get(_ISLOGGEDIN);
  }
  Future<void> putIsUserLoggedIn({required bool isLoggedIn}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _ISLOGGEDIN,
      isLoggedIn,
    );
  }

  putVideoAudioStatus({bool? isVideoPlaying}) {
    hivePutBool(
      key: _VIDEOSOUNDSTATUS,
      value: isVideoPlaying,
    );
  }

  bool? getVideoAudioStatus() {
    return hiveGetBool(key: _VIDEOSOUNDSTATUS);
  }



  putName({String? name}) {
    hivePut(key: _NAME, value: name);
  }

  String getName() {
    return hiveGet(key: _NAME);
  }



  putToken({String? token}) {
    hivePut(key: _TOKEN, value: token);
  }

  String getToken() {
    return hiveGet(key: _TOKEN);
  }



  putIsSignedInUser({bool? isSignedInUser}) {
    hivePutBool(key: _IS_SIGNED_IN_USER, value: isSignedInUser);
  }

  bool? getIsSignedInUser() {
    return hiveGetBool(key: _IS_SIGNED_IN_USER);
  }



  clearHive() async {
    await Hive.box(Constants.BOX_NAME).clear();
  }

  AppHive();
}