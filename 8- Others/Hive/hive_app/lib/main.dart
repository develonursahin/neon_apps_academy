import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  if (!Hive.isBoxOpen('tasks')) {
    await Hive.openBox<Task>('tasks');
  }

  runApp(const TaskMasterApp());
}

class TaskMasterApp extends StatelessWidget {
  const TaskMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'TaskMaster',
      home: const TaskMasterScreen(),
    );
  }
}

class Task {
  String title;
  String description;
  bool isCompleted;

  Task(this.title, this.description, this.isCompleted);
}

class TaskAdapter extends TypeAdapter<Task> {
  @override
  int get typeId => 0;

  @override
  Task read(BinaryReader reader) {
    return Task(
      reader.readString(),
      reader.readString(),
      reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeBool(obj.isCompleted);
  }
}

class TaskMasterScreen extends StatefulWidget {
  const TaskMasterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TaskMasterScreenState createState() => _TaskMasterScreenState();
}

class _TaskMasterScreenState extends State<TaskMasterScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Task> _filteredTasks = [];
  bool _showCompletedTasks = true;

  @override
  void initState() {
    super.initState();
    _filterTasks();
  }

  void _addNewTask() {
    final taskBox = Hive.box<Task>('tasks');
    final newTask =
        Task(_titleController.text, _descriptionController.text, false);
    taskBox.add(newTask);
    _titleController.clear();
    _descriptionController.clear();
    _filterTasks();
  }

  void _searchTasks(String query) {
    _filterTasks();
  }

  void _toggleShowCompletedTasks() {
    setState(() {
      _showCompletedTasks = !_showCompletedTasks;
      _filterTasks();
    });
  }

  void _filterTasks() {
    final taskBox = Hive.box<Task>('tasks');
    _filteredTasks = taskBox.values
        .where((task) =>
            task.title
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) &&
            (_showCompletedTasks ? true : !task.isCompleted))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskMaster'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Görev Başlığı'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Görev Açıklaması'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addNewTask,
                child: const Text('Yeni Görev Ekle'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _searchController,
                onChanged: _searchTasks,
                decoration:
                    const InputDecoration(labelText: 'Search by Task Title'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleShowCompletedTasks,
                child: Text(_showCompletedTasks
                    ? 'Tamamlananları Gizle'
                    : 'Tamamlananları Göster'),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = _filteredTasks[index];
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        Hive.box<Task>('tasks').deleteAt(index);
                        setState(() {
                          _filteredTasks.removeAt(index);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      child: Card(
                        color: task.isCompleted ? Colors.green : Colors.red,
                        child: ListTile(
                          title: Text(
                            task.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            task.description,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) {
                              Hive.box<Task>('tasks').putAt(
                                index,
                                Task(task.title, task.description, value!),
                              );
                              // Update the UI when the checkbox is tapped
                              setState(() {
                                task.isCompleted = value;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
