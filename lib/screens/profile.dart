import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                size: 100,
                color: Colors.lightGreenAccent,
              ),
              const SizedBox(height: 20),
              const Text(
                "Sebastian Kaca",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text("Statystyki ogólne"),
              const SizedBox(height: 30),
              const Text("Statystyki aktualnego sezonu"),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}