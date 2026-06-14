import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  late Future<List<dynamic>> _coursesFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    final authProvider = context.read<AuthProvider>();
    _coursesFuture = _apiService.getCourses(authProvider.token ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _coursesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final courses = snapshot.data!;
            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(course['title'] ?? 'N/A'),
                    subtitle: Text(course['description'] ?? 'N/A'),
                    trailing: Text('₹${course['price']}'),
                    onTap: () {
                      // Navigate to course details
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No courses available'));
        },
      ),
    );
  }
}
