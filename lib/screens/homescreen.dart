import 'package:decisionapp/screens/add_decision.dart';
import 'package:decisionapp/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;
  PageController pageController = PageController();

  void onTapped(int value) {
    setState(() {
      selectedIndex = value;
    });
    pageController.jumpToPage(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 105, 179, 240),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text('Decisioner'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        controller: pageController,
        children: [DashBoard(), AddDecision()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Decision')
        ],
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey.shade700,
        onTap: onTapped,
      ),
    );
  }
}
