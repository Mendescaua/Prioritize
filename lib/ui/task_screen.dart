import 'package:flutter/material.dart';
import 'package:prioritize/controllers/task_controller.dart';
import 'package:prioritize/ui/components/app_bar.dart';
import 'package:prioritize/utils/Theme.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  void initState() {
    super.initState();
    // Carregar as tarefas do banco de dados
    _taskDay();
  }

  void _taskDay() async {
    await context.read<TaskController>().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(),
              const SizedBox(height: 20),
              _buildCalendar(),
              const SizedBox(height: 20),
              Text(
                'Tasks',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.primary,
                ),
              ),
              Divider(color: ThemeColor.primary, thickness: 0.3),
              const SizedBox(height: 10),
              Consumer<TaskController>(
                builder: (context, taskController, child) {
                  final filteredTasks = taskController.getTasksByDate(
                    selectedDay,
                  );
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Checkbox(

                          activeColor: ThemeColor.txtFieldCompleted,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          value: filteredTasks[index].isCompleted,
                          onChanged: (bool? value) {
                            setState(() {
                              filteredTasks[index].isCompleted = value!;
                              taskController.updateTask(filteredTasks[index]);
                            });
                          },
                        ),
                        title: Text(filteredTasks[index].title),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2025, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: focusedDay,
      calendarFormat: CalendarFormat.week,
      headerVisible: false,
      onDaySelected: (selected, focused) {
        setState(() {
          // Toggle entre selecionar e desmarcar o dia
          if (selectedDay == selected) {
            selectedDay = null;
          } else {
            selectedDay = selected;
            focusedDay = focused;
          }
        });
      },
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      calendarStyle: const CalendarStyle(outsideDaysVisible: false),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          return _buildDayCell(day);
        },
        todayBuilder: (context, day, focusedDay) {
          return _buildDayCell(day, isToday: true);
        },
        selectedBuilder: (context, day, focusedDay) {
          return _buildDayCell(day, isSelected: true);
        },
      ),
    );
  }

  Widget _buildDayCell(
    DateTime day, {
    bool isToday = false,
    bool isSelected = false,
  }) {
    final bool isCurrentDay = isToday;
    final bool isPickedDay = isSelected;

    final backgroundColor =
        isPickedDay
            ? ThemeColor.primary
            : isCurrentDay
            ? Colors.grey[500]
            : Colors.transparent;

    final textColor =
        isPickedDay || isCurrentDay ? Colors.white : ThemeColor.primary;

    return Container(
      width: 48,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${day.day}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
