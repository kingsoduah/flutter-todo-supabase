import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://eqqtrrfpmvjizkyjdocm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVxcXRycmZwbXZqaXpreWpkb2NtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcxMjkzOTIsImV4cCI6MjA2MjcwNTM5Mn0.4k7mOtp5eJtd67Nnr1s5COVAzwuHIUSBtP9BBAKWbjY',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskListScreen(),
    );
  }
}
