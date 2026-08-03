import 'package:flutter/material.dart';
import 'package:gcontrol/widgets/calendar_widget.dart';

class PlayerProfile {
  final String firstName;
  final String lastName;
  final int number;
  final int age;
  final String position;
  final String teamName;
  final PlayerStats overallStats;
  final PlayerStats seasonStats;

  const PlayerProfile({
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.age,
    required this.position,
    required this.teamName,
    required this.overallStats,
    required this.seasonStats,
  });
}

class PlayerStats {
  final int matches;
  final int goals;
  final int assists;
  final double kilometers;

  const PlayerStats({
    required this.matches,
    required this.goals,
    required this.assists,
    required this.kilometers,
  });
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final PlayerProfile profile = const PlayerProfile(
    firstName: 'Sebastian',
    lastName: 'Kaca',
    number: 8,
    age: 22,
    position: 'Prawy obrońca',
    teamName: 'GControl FC',
    overallStats: PlayerStats(
      matches: 152,
      goals: 34,
      assists: 47,
      kilometers: 1842.3,
    ),
    seasonStats: PlayerStats(
      matches: 28,
      goals: 8,
      assists: 12,
      kilometers: 312.7,
    ),
  );

  void _openCalendarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520.0),
            child: CalendarScheduleWidget(
              events: [
                CalendarEvent(
                  date: DateTime(2026, 8, 5),
                  type: CalendarEventType.training,
                  title: 'Trening indywidualny',
                  subtitle: 'Faza techniczna i kończenie akcji.',
                ),
                CalendarEvent(
                  date: DateTime(2026, 8, 8),
                  type: CalendarEventType.match,
                  title: 'Mecz towarzyski',
                  subtitle: 'GControl FC vs. FC Kędzierzyn',
                ),
                CalendarEvent(
                  date: DateTime(2026, 8, 12),
                  type: CalendarEventType.training,
                  title: 'Trening taktyczny',
                  subtitle: 'Praca nad pressingu i przejściami.',
                ),
                CalendarEvent(
                  date: DateTime(2026, 8, 15),
                  type: CalendarEventType.match,
                  title: 'Mecz ligowy',
                  subtitle: 'GControl FC vs. Team Białystok',
                ),
                CalendarEvent(
                  date: DateTime(2026, 8, 19),
                  type: CalendarEventType.training,
                  title: 'Trening wytrzymałościowy',
                  subtitle: 'Praca cardio i utrzymanie tempa.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildStatsTable(PlayerStats stats) {
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
                child: Text('Mecze', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Bramki', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Asysty', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Km', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(stats.matches.toString(), style: const TextStyle(color: Colors.white70)),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(stats.goals.toString(), style: const TextStyle(color: Colors.white70)),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(stats.assists.toString(), style: const TextStyle(color: Colors.white70)),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(stats.kilometers.toStringAsFixed(1), style: const TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '${profile.firstName} ${profile.lastName}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 12.0),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 14.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  '#${profile.number}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.cake, color: Colors.white70, size: 18),
                                  const SizedBox(width: 6),
                                  Text('${profile.age} lat', style: const TextStyle(color: Colors.white70)),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.sports_soccer, color: Colors.white70, size: 18),
                                ],
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Text(
                                  profile.position,
                                  style: const TextStyle(color: Colors.white70),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.blueGrey.shade700,
                            child: Text(
                              profile.teamName.substring(0, 2).toUpperCase(),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => _openCalendarDialog(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.calendar_month_outlined, color: Colors.white70),
                  label: const Text(
                    'Kalendarz',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Statystyki ogólne',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              buildStatsTable(profile.overallStats),
              const SizedBox(height: 24),
              const Text(
                'Statystyki sezonu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              buildStatsTable(profile.seasonStats),
            ],
          ),
        ),
      ),
    );
  }
}
