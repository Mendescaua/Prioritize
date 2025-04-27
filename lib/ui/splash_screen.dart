import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Image.asset(
                'assets/images/TodoSplash.png',
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prioritize',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'AbrilFatface',
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'The best app to manage your tasks, prioritize and organize your life.',
                      style: TextStyle(color: Color(0xA02C2C2C)),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2C2D33),
                        elevation: 6,
                        minimumSize: Size(
                          double.infinity,
                          60,
                        ), // Aumenta a altura do botão
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween, // Centraliza o conteúdo
                        children: [
                          Text(
                            'Get Started',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
