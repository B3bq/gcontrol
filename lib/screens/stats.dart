import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget{
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPage();
}

class _StatsPage extends State<StatsPage> {
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
              const Text('Statystyki ogólne',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}