import 'package:flutter/material.dart';
import 'package:prioritize/services/auth_service.dart';
import 'package:prioritize/utils/Theme.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final authService = AuthService();

  void signOut() async {
    try {
      await authService.signOut();
      Navigator.of(context).pushReplacementNamed('/splash');
    } catch (e) {
      // Handle error if needed
      print('Error signing out: $e');
    }
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: ThemeColor.background,
            title: const Text('Confirm logout'),
            content: const Text(
              'Do you really want to log out of your account?',
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(foregroundColor: Colors.black),
              ),
              TextButton(
                child: const Text('Logout'),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                  signOut(); // Chama o método de logout
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/104581895?v=4', // Substitua pela URL da imagem do usuário
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Cauã Mendes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                'cauamende1703@gmail.com',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              _buildSectionTitle('Preferences'),
              const SizedBox(height: 12),
              Card(
                color: ThemeColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Column(
                  children: [
                    ListTile(
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      leading: const Icon(Icons.store),
                      title: const Text("My stores"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ListTile(
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      leading: const Icon(Icons.support),
                      title: const Text("Support"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const Spacer(),
              _buildLogoutItem(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }

  Widget _buildLogoutItem() {
    return GestureDetector(
      onTap: () {
        _confirmLogout();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          children: [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 16),
            Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
