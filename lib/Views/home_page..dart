import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Reminder.dart';
import '../Services/notification_service.dart';
import '../widgets/reminder_tile.dart';
import 'add_reminder_page.dart';
import 'update_reminder_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Reminder> _reminders = [];
  int _mode = 0;

  @override
  void initState() {
    super.initState();
    _loadReminders();

  }

  Future<void> _saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final remindersJson = _reminders.map((reminder) => json.encode(reminder.toJson())).toList();
    await prefs.setStringList('reminders', remindersJson);
  }

  Future<void> _loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final remindersJson = prefs.getStringList('reminders') ?? [];
    setState(() {
      _reminders.clear();
      _reminders.addAll(remindersJson.map((reminder) => Reminder.fromJson(json.decode(reminder))).toList());
    });
  }

  void _addReminder(Reminder reminder) {
    setState(() {
      _reminders.add(reminder);
    });
    _saveReminders();
    scheduleNotification(reminder, _reminders.indexOf(reminder));
  }

  void _updateReminder(int index, Reminder updatedReminder) {
    setState(() {
      _reminders[index] = updatedReminder;
    });
    _saveReminders();
    scheduleNotification(updatedReminder, index);
  }

  void _deleteReminder(int index){
    setState(() {
      _reminders.removeAt(index);
    });
    _saveReminders();
    cancelNotification(index);

  }


  List<Reminder> _getSortedReminders() {
    if (_mode == 1) {
      // Sort reminders by priority when mode is 1
      _reminders.sort((a, b) => _priorityToInt(a.priority).compareTo(_priorityToInt(b.priority)));
    }
    return _reminders;
  }

  int _priorityToInt(String priority) {
    switch (priority) {
      case 'High':
        return 0;
      case 'Medium':
        return 1;
      case 'Low':
        return 2;
      default:
        return 999; // Handle other cases if necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RemindIt',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        leading: const Icon(Icons.alarm),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _reminders.isEmpty
                ? const Center(
              child: Text(
                'No Reminders',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
            )
                : Container(
              decoration: BoxDecoration(
                color: const Color(0x99F0F0F0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Priority Mode ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                    Switch(
                      value: _mode == 1,
                      onChanged: (value) {
                        setState(() {
                          _mode = value ? 1 : 0;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _getSortedReminders().length,
                itemBuilder: (context, index) {
                  final reminder = _getSortedReminders()[index];
                  return GestureDetector(
                    onTap: () async {
                      final updatedReminder = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateReminderPage(reminder: reminder),
                        ),
                      );
                      if (updatedReminder != null && updatedReminder is Reminder) {
                        _updateReminder(index, updatedReminder);
                      }
                      if(updatedReminder == null){
                        _deleteReminder(index);
                      }

                    },
                    child: ReminderTile(
                      title: reminder.title,
                      description: reminder.description,
                      priority: reminder.priority,
                      time: reminder.time,
                      mode: _mode,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddReminderPage()),
          );
          if (result != null && result is Reminder) {
            _addReminder(result);
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
