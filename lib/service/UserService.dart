import 'package:color_blind_test/model/user.dart';
import 'package:color_blind_test/repo/SQLiteDbProvider.dart';

class UserService {
  SQLiteDbProvider _provider;

  UserService() {
    _provider = SQLiteDbProvider();
  }

  saveUser(User user) async {
    return await _provider.insertData('Users', user.toMap());
  }

  getAllData() async {
    return await _provider.getAllData();
  }
}
