import 'package:color_blind_test/model/result.dart';
import 'package:color_blind_test/repo/SQLiteDbProvider.dart';

class ResultService {
  SQLiteDbProvider _provider;

  ResultService() {
    _provider = SQLiteDbProvider();
  }

  saveResult(Result result) async {
    return await _provider.insertData('Result', result.toMap());
  }
}
