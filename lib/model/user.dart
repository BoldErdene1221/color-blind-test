class User {
  int id;
  String fullName;
  int age;
  DateTime testedDate;

  User(String name, int age, DateTime date) {
    this.fullName = name;
    this.age = age;
    this.testedDate = date;
  }

  User.id(this.id);

  User.fromUser(int id, String name, int age, DateTime date) {
    this.id = id;
    this.fullName = name;
    this.age = age;
    this.testedDate = date;
  }

  User.fromMapObject(Map<String, dynamic> map) {
    this.id = map['user_id'];
    this.fullName = map['full_name'];
    this.age = map['age'];
    this.testedDate = DateTime.parse(map['tested_date']);
  }

  Map<String, Object> toMap() {
    var map = <String, Object>{
      'full_name': fullName,
      'age': this.age.toString(),
      'tested_date': testedDate.toString()
    };
    return map;
  }
}
