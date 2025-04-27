import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  String get formattedDate {
    DateTime now = DateTime.now();
    return DateFormat('E, d MMM', 'en_US').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar do usuário
        CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/104581895?v=4', // Substitua pela URL da imagem do usuário
          ),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cauã Mendes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              formattedDate,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
