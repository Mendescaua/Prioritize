import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prioritize/components/bottom_modal.dart';
import 'package:prioritize/ui/config_screen.dart';
import 'package:prioritize/ui/newtask_screen.dart';
import 'package:prioritize/ui/task_screen.dart';
import 'package:prioritize/utils/Theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    List screens = const [TaskScreen(), ConfigScreen()];

    final items = <IconData>[Iconsax.task_square, Iconsax.setting_2];

    return Scaffold(
      body: screens[currentTab],
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 12),
        child: Container(
          height: 70,
          width: 70,
          decoration: const BoxDecoration(
            color: ThemeColor.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Iconsax.add, size: 50, color: Colors.white),
            onPressed: () {
              showBottomSlideUpModal(context, child: NewTask());
            },
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // NAVIGATION BAR
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              items.length,
              (index) => GestureDetector(
                onTap: () => setState(() => currentTab = index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Icon(
                        items[index],
                        size: 32,
                        color:
                            currentTab == index
                                ? ThemeColor.primary
                                : Colors.grey,
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
