import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class TaskListScreen extends StatefulWidget {
  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final SupabaseService _service = SupabaseService();
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _tasks = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

//   Future<void> _loadTasks() async {
//     setState(() => _loading = true);
//     _tasks = await _service.fetchTasks();
//     setState(() => _loading = false);
//   }

Future<void> _loadTasks() async {
  setState(() => _loading = true);
  try {
    _tasks = await _service.fetchTasks();
    print('Tasks fetched: $_tasks');
  } catch (e) {
    print('Error loading tasks: $e');
  }
  setState(() => _loading = false);
}


//   Future<void> _addTask() async {
//     final title = _controller.text.trim();
//     if (title.isEmpty) return;
//     await _service.addTask(title);
//     _controller.clear();
//     _loadTasks();
//   }

Future<void> _addTask() async {
  final title = _controller.text.trim();
  if (title.isEmpty) return;

  print('Trying to add task: $title');
  await _service.addTask(title);
  _controller.clear();
  await _loadTasks(); // Added await here
}

  Future<void> _toggleTask(String id, bool done) async {
    await _service.toggleTask(id, done);
    _loadTasks();
  }

  Future<void> _deleteTask(String id) async {
  await _service.deleteTask(id);
  _loadTasks();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('📝 My Tasks')),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: 'Add a task',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _addTask,
                        child: Text('Add'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return ListTile(
                        title: Text(
                          task['title'],
                          style: TextStyle(
                            decoration: task['done']
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        leading: Checkbox(
                          value: task['done'],
                          onChanged: (newValue) =>
                              _toggleTask(task['id'], newValue!),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTask(task['id']),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
