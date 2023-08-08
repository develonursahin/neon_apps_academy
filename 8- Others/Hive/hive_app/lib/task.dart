import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isCompleted;

  Task(this.title, this.description, this.isCompleted);
}
