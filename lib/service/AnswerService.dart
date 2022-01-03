import 'package:color_blind_test/model/answer.dart';
import 'package:color_blind_test/repo/SQLiteDbProvider.dart';

class AnswerService {
  SQLiteDbProvider _provider;

  AnswerService() {
    _provider = SQLiteDbProvider();
  }

  saveResult(Answer answer) async {
    return await _provider.insertData('Answers', answer.toMap());
  }
}
