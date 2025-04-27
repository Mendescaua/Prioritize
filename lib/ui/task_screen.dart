import 'package:flutter/material.dart';
import 'package:prioritize/ui/components/app_bar.dart';
import 'package:prioritize/utils/Theme.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;


  void taskDay() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(),
                  const SizedBox(height: 20),
                  _buildCalendar(),
                ],
              ),
            ),

            // Bottom Sheet fixa
            if (selectedDay != null)
              DraggableScrollableSheet(
                initialChildSize: 0.7,
                minChildSize: 0.1,
                maxChildSize: 0.7,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDay = null;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 5,
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Today Tasks',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(),
                        const SizedBox(height: 12),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: focusedDay,
      calendarFormat: CalendarFormat.week,
      headerVisible: false,
      onDaySelected: (selected, focused) {
        setState(() {
          // Toggle entre selecionar e desmarcar o dia
          if (selectedDay == selected) {
            selectedDay = null; // Fecha o modal
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
            ? Colors.grey[800]
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
