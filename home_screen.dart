import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do App"),
        centerTitle: true,
      ),

      body: provider.tasks.isEmpty
          ? const Center(
              child: Text(
                "No Tasks Available",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: provider.tasks.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  task: provider.tasks[index],
                  index: index,
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Add Task"),

              content: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Enter Task",
                ),
              ),

              actions: [

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: () {

                    if (controller.text.isNotEmpty) {

                      provider.addTask(controller.text);

                      controller.clear();

                      Navigator.pop(context);

                    }

                  },
                  child: const Text("Add"),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
