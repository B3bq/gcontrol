import 'package:flutter/material.dart';
import 'package:gcontrol/screens/login.dart';

class LastGame{
  final int minutes;
  final double kilometers;
  final double speed;
  final int ga;

  const LastGame({
    required this.minutes,
    required this.kilometers,
    required this.speed,
    required this.ga,
  });
}

class StartPage extends StatefulWidget{
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPage();
}

class _StartPage extends State<StartPage> {
  final LastGame lastGame = const LastGame(
    minutes: 90,
    kilometers: 10.5,
    speed: 7.2,
    ga: 3,
  );

  Widget buildTable(LastGame lastGame) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(16.0),
        ),
        clipBehavior: Clip.hardEdge,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: const BoxDecoration(color: Colors.white12),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Minuty', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Km', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Max speed', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('GA', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(lastGame.minutes.toString(), style: const TextStyle(color: Colors.white70)),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(lastGame.kilometers.toStringAsFixed(1), style: const TextStyle(color: Colors.white70)),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(lastGame.speed.toStringAsFixed(1), style: const TextStyle(color: Colors.white70)),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(lastGame.ga.toString(), style: const TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Następny mecz',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 32),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/en/thumb/4/4c/FC_Barcelona_%28crest%29.svg/1200px-FC_Barcelona_%28crest%29.svg.png'),
                              ),
                              const SizedBox(height: 8),
                              const Text('FC Barcelona',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text('VS',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/en/thumb/4/4c/FC_Barcelona_%28crest%29.svg/1200px-FC_Barcelona_%28crest%29.svg.png'),
                                ),
                                const SizedBox(height: 8),
                                const Text('FC Barcelona',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                              ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ),
              const SizedBox(height: 24),
              const Text('Ostatni mecz',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              buildTable(lastGame),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                child: const Text(
                  "Zobacz szczegóły >>",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}