import 'package:flutter/material.dart';

class Reminder {
  String title;
  String description;
  String priority;
  TimeOfDay time;

  Reminder({
    required this.title,
    required this.description,
    required this.priority,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'time': '${time.hour}:${time.minute}',
    };
  }

  factory Reminder.fromJson(Map<String, dynamic> json) {
    final timeParts = json['time'].split(':');
    final time = TimeOfDay(hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));

    return Reminder(
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      time: time,
    );
  }
}
