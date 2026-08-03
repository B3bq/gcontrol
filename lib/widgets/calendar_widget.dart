import 'package:flutter/material.dart';

enum CalendarEventType {
  training,
  match,
}

class CalendarEvent {
  final DateTime date;
  final CalendarEventType type;
  final String title;
  final String subtitle;

  const CalendarEvent({
    required this.date,
    required this.type,
    required this.title,
    required this.subtitle,
  });
}

class CalendarScheduleWidget extends StatefulWidget {
  const CalendarScheduleWidget({
    super.key,
    this.events = const [],
  });

  final List<CalendarEvent> events;

  @override
  State<CalendarScheduleWidget> createState() => _CalendarScheduleWidgetState();
}

class _CalendarScheduleWidgetState extends State<CalendarScheduleWidget> {
  late DateTime _focusedMonth;
  late DateTime _selectedDate;
  late List<CalendarEvent> _events;

  final List<String> _weekDays = const ['Pn', 'Wt', 'Śr', 'Cz', 'Pt', 'Sb', 'Nd'];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedMonth = DateTime(now.year, now.month, 1);
    _selectedDate = now;
    _events = List<CalendarEvent>.from(widget.events);
  }

  bool _isSameDay(DateTime first, DateTime second) {
    return first.year == second.year && first.month == second.month && first.day == second.day;
  }

  List<CalendarEvent> _eventsForDate(DateTime date) {
    return _events.where((event) => _isSameDay(event.date, date)).toList();
  }

  void _changeMonth(int direction) {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + direction, 1);
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  Future<void> _addEventForSelectedDate(CalendarEventType type) async {
    final date = _selectedDate;
    final title = type == CalendarEventType.training ? 'Nowy trening' : 'Nowy mecz';
    final subtitle = type == CalendarEventType.training
        ? 'Dostosuj opis treningu później.'
        : 'Dostosuj opis meczu później.';

    setState(() {
      _events.add(
        CalendarEvent(
          date: date,
          type: type,
          title: title,
          subtitle: subtitle,
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.shade700,
        content: Text('${type == CalendarEventType.training ? 'Dodano trening' : 'Dodano mecz'} na ${date.day}.${date.month}.${date.year}.'),
      ),
    );
  }

  Color _eventColor(CalendarEventType type) {
    switch (type) {
      case CalendarEventType.training:
        return Colors.greenAccent;
      case CalendarEventType.match:
        return Colors.redAccent;
    }
  }

  String _eventLabel(CalendarEventType type) {
    switch (type) {
      case CalendarEventType.training:
        return 'Trening';
      case CalendarEventType.match:
        return 'Mecz';
    }
  }

  Widget _buildDayMarker(CalendarEvent event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: _eventColor(event.type).withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        _eventLabel(event.type),
        style: TextStyle(
          fontSize: 9,
          color: _eventColor(event.type),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ElevatedButton.icon(
        onPressed: () async {
          final choice = await showDialog<CalendarEventType>(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: const Color(0xFF1A1A1A),
              title: const Text(
                'Wybierz typ wydarzenia',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(CalendarEventType.training),
                  child: const Text('Trening', style: TextStyle(color: Colors.greenAccent)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(CalendarEventType.match),
                  child: const Text('Mecz', style: TextStyle(color: Colors.redAccent)),
                ),
              ],
            ),
          );

          if (choice != null) {
            await _addEventForSelectedDate(choice);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Dodaj'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final daysInMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;
    final startOffset = firstDayOfMonth.weekday - 1;
    final cells = <Widget>[];

    for (var index = 0; index < startOffset; index++) {
      cells.add(const SizedBox.shrink());
    }

    for (var day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_focusedMonth.year, _focusedMonth.month, day);
      final dailyEvents = _eventsForDate(date);
      final isSelected = _isSameDay(date, _selectedDate);

      cells.add(
        GestureDetector(
          onTap: () => _selectDate(date),
          child: Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blueAccent.withValues(alpha: 0.35) : Colors.white10,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: isSelected ? Colors.blueAccent : Colors.white12,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  day.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white70,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 6),
                if (dailyEvents.isNotEmpty)
                  ...dailyEvents.take(2).map(_buildDayMarker),
                if (dailyEvents.length > 2)
                  Text(
                    '+${dailyEvents.length - 2}',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    final selectedEvents = _eventsForDate(_selectedDate);

    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _changeMonth(-1),
                icon: const Icon(Icons.chevron_left, color: Colors.white70),
              ),
              Text(
                '${_monthLabel(_focusedMonth.month)} ${_focusedMonth.year}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () => _changeMonth(1),
                icon: const Icon(Icons.chevron_right, color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: _weekDays
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 0.9,
            ),
            itemCount: cells.length,
            itemBuilder: (context, index) => cells[index],
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wybrany dzień: ${_selectedDate.day.toString().padLeft(2, '0')}.${_selectedDate.month.toString().padLeft(2, '0')}.${_selectedDate.year}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                if (selectedEvents.isEmpty)
                  const Text(
                    'Brak zaplanowanego treningu lub meczu.',
                    style: TextStyle(color: Colors.white70),
                  )
                else
                  ...selectedEvents.map((event) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_eventLabel(event.type)} • ${event.title}',
                              style: TextStyle(
                                color: _eventColor(event.type),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              event.subtitle,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      )),
                if (selectedEvents.isEmpty)
                  _buildAddButton()
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final firstEvent = selectedEvents.first;
                        final actionText = firstEvent.type == CalendarEventType.training
                            ? 'Rozpoczęto trening'
                            : 'Rozpoczęto mecz';

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green.shade700,
                            content: Text(actionText),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      icon: Icon(
                        selectedEvents.first.type == CalendarEventType.training
                            ? Icons.fitness_center
                            : Icons.sports_soccer,
                      ),
                      label: Text(
                        selectedEvents.first.type == CalendarEventType.training
                            ? 'Rozpocznij trening'
                            : 'Rozpocznij mecz',
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _monthLabel(int monthNumber) {
    const labels = [
      'Styczeń',
      'Luty',
      'Marzec',
      'Kwiecień',
      'Maj',
      'Czerwiec',
      'Lipiec',
      'Sierpień',
      'Wrzesień',
      'Październik',
      'Listopad',
      'Grudzień',
    ];

    return labels[monthNumber - 1];
  }
}
