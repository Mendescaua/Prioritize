import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prioritize/utils/Theme.dart';
import 'package:provider/provider.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  int selectedIndex = 0;
  final List<String> priorities = ['Low', 'Medium', 'High'];

  void newTask() async {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    String priority = priorities[selectedIndex];

    if (title.isNotEmpty) {
      await context.read().addTask(title, priority);
      Navigator.pop(context);
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Custom AppBar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: ThemeColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              const Text(
                'New Task',
                style: TextStyle(
                  color: ThemeColor.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CupertinoButton(
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: ThemeColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  newTask();
                },
              ),
            ],
          ), // Conteúdo do modal
          SizedBox(height: 20),
          const Text(
            'Title',
            style: TextStyle(color: ThemeColor.primary, fontSize: 14),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Enter task title',
              hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
              filled: true,
              fillColor: ThemeColor.txtFieldColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Description',
            style: TextStyle(color: ThemeColor.primary, fontSize: 14),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: descriptionController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Enter task description',
              hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
              filled: true,
              fillColor: ThemeColor.txtFieldColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Priority', style: TextStyle(color: ThemeColor.primary)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2C2D33),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(4),
            child: Row(
              children: List.generate(priorities.length, (index) {
                final isSelected = index == selectedIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? const Color(0xFFFFFFFF)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          priorities[index],
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
