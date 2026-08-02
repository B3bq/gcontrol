import 'package:flutter/material.dart';
import 'package:gcontrol/widgets/field_heatmap.dart';

class LastGameDetails extends StatelessWidget {
  const LastGameDetails({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final details = [
      {'label': 'Minuty', 'value': '90'},
      {'label': 'Dystans', 'value': '10.5 km'},
      {'label': 'Max prędkość', 'value': '7.2 km/h'},
      {'label': 'GA', 'value': '3'},
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Statystyki meczu', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: details.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['label']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        item['value']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Mapa aktywności na boisku',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const FieldHeatmap(),
        ],
      ),
    );
  }
}