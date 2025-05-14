import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    try {
      final response = await _client
          .from('tasks')
          .select()
          .order('created_at', ascending: false);

      print('Fetched tasks: $response');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  // Future<void> addTask(String title) async {
  //   try {
  //     final result =
  //         await _client.from('tasks').insert({'title': title, 'done': false});
  //     print('Task added: $result');
  //   } catch (e) {
  //     print('Error adding task: $e');
  //   }
  // }

  Future<void> addTask(String title) async {
  try {
    final result =
        await _client.from('tasks').insert({'title': title, 'done': false});
    print('Task added: $result');
  } catch (e) {
    print('Error adding task: $e');
  }
}


  Future<void> toggleTask(String id, bool done) async {
    try {
      final result = await _client
          .from('tasks')
          .update({'done': done})
          .eq('id', id);
      print('Updated task $id to done=$done: $result');
    } catch (e) {
      print('Error toggling task: $e');
    }
  }

  Future<void> deleteTask(String id) async {
  await _client.from('tasks').delete().eq('id', id);
}

}
