import 'package:flutter/widgets.dart';
import 'package:shakti/common/db_entities/client_db_entity.dart';
import 'package:shakti/common/db_entities/org_db_entity.dart';
import 'package:shakti/common/db_entities/role_db_entity.dart';
import 'package:shakti/widgets/login_screen/classes/loging_screen_settings.dart';

class SessionSettings extends ChangeNotifier {
  LoginScreenSettings loginScreenSettings = LoginScreenSettings();
  ClientDBEntity client = ClientDBEntity();
  RoleDBEntity role = RoleDBEntity();
  OrgDBEntity org = OrgDBEntity();

  void getClientByFirebaseUserId(String uid){
    client.getClientByFirebaseUserId(uid);
    notifyListeners();
  }

  void changeLoginState() {
    loginScreenSettings.changeLoginState();
    notifyListeners();
  }

  void addOrUpdateThisInDB() {
    client.addOrUpdateThisInDB();
    notifyListeners();
  }
}