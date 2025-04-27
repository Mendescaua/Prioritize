import 'package:flutter/material.dart';
import 'package:prioritize/utils/Theme.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  PersistentBottomSheetController? _bottomSheetController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (scaffoldContext) {
          return TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: focusedDay,
            calendarFormat: CalendarFormat.week,
            headerVisible: false,
            onDaySelected: (selected, focused) {
              setState(() {
                selectedDay = selected;
                focusedDay = focused;
              });

              // Fecha anterior
              _bottomSheetController?.close();

              // Agora funciona!
              _bottomSheetController = Scaffold.of(
                scaffoldContext,
              ).showBottomSheet(
                (context) => _buildBottomSheetContent(selected),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
              );
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

  // Bottom sheet personalizado
  Widget _buildBottomSheetContent(DateTime day) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
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
          Text(
            'Dia ${day.day}/${day.month}/${day.year}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Conteúdo do dia aqui. Pode adicionar tarefas, eventos, etc.',
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Fecha a bottom sheet
            },
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
