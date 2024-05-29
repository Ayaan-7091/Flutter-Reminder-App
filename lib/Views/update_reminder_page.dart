import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remind_it/widgets/custom_input_field.dart';
import '../Model/Reminder.dart';
import 'home_page..dart';

class UpdateReminderPage extends StatefulWidget {
  final Reminder reminder;

  const UpdateReminderPage({super.key, required this.reminder});

  @override
  State<UpdateReminderPage> createState() => _UpdateReminderPageState();
}

class _UpdateReminderPageState extends State<UpdateReminderPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final _priority = ['High', 'Medium', 'Low'];
  late String _selectedPriority;
  late TimeOfDay _selectedTime;
  bool _timeClicked = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.reminder.title);
    descriptionController = TextEditingController(text: widget.reminder.description);
    _selectedPriority = widget.reminder.priority;
    _selectedTime = widget.reminder.time;
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeClicked = true;
      });
    }
    return picked;
  }

  void _updateReminder() {
    final updatedReminder = Reminder(
      title: titleController.text,
      description: descriptionController.text,
      priority: _selectedPriority,
      time: _selectedTime,
    );
    Navigator.pop(context, updatedReminder);
  }

  void _deleteReminder() {
    Navigator.pop(context, null);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Reminder",
          style: TextStyle(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomInputField(
                type: TextInputType.text,
                fontStyle: const TextStyle(color: Colors.black38),
                controller: titleController,
                icon: const Icon(Icons.title),
              ),
              const SizedBox(height: 10),
              CustomInputField(
                type: TextInputType.text,
                fontStyle: const TextStyle(color: Colors.black12),
                hintText: "Reminder Description",
                maxLines: 5,
                controller: descriptionController,
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0x52F0F0F0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text("Select Priority"),
                      DropdownButton<String>(
                        value: _selectedPriority,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedPriority = newValue!;
                          });
                        },
                        items: _priority.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0x52F0F0F0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text("Select Time"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextButton(
                          onPressed: () {
                            _selectTime(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                _timeClicked
                                    ? "${_selectedTime.format(context)}"
                                    : "Set Time",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () {
                  _updateReminder();
                },
                height: 48.0,
                elevation: 0,
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                    child: Text(
                      "Update",
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () {
                  _deleteReminder();
                },
                height: 48.0,
                elevation: 0,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
