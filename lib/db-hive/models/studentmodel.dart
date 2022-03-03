class studentModel {

  final int? id;

  final String name;

  final String age;

  studentModel({required this.name, required this.age, this.id});

  static studentModel fromMap(Map<String, Object?> map){

    final id =map['id'] as int;
    final name =map['name'] as String;
    final age =map['age'] as String;

    return studentModel(id:id, name:name, age:age);
  }

}



//Code to build hte adatpeter file
// flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs