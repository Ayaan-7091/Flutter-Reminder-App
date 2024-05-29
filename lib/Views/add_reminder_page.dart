import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:remind_it/widgets/custom_input_field.dart';

import '../Model/Reminder.dart';
import 'home_page..dart';

class AddReminderPage extends StatefulWidget {
  const AddReminderPage({super.key});

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {

  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final _priority = ['High', 'Medium', 'Low'];
  var _selected = 'High'; // Default selection value

  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay?> _selectedTime() async{
    final TimeOfDay ? picked = await showTimePicker(context: context, initialTime: _time);
    if(picked != null && picked != _time){
      setState(() {
        _time = picked;
        _clicked = true;
      });
    }
    return picked!;
  }

  void _saveReminder() {
    final newReminder = Reminder(
      title: titleController.text,
      description: descriptionController.text,
      priority: _selected,
      time: _time,
    );
    Navigator.pop(context, newReminder);
  }


  @override
  void dispose() {
    // Dispose controllers
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Add Reminder",
          style: TextStyle(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
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
                hintText: "Reminder Title",
                icon: const Icon(Icons.add_circle),
                controller: titleController,
              ),
              const SizedBox(height: 10,),
              CustomInputField(
                type: TextInputType.text,
                fontStyle: const TextStyle(color: Colors.black12),
                hintText: "Reminder Description",
                maxLines: 5,
                controller: descriptionController,
              ),
              const SizedBox(height: 10,),
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
                        value: _selected, // Set the current selected value
                        onChanged: (newValue) {
                          setState(() {
                            _selected = newValue!;
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
                      Padding(padding: const EdgeInsets.symmetric(vertical: 10),
                        child:TextButton(onPressed: (){
                          _selectedTime();
                        },
                          style: TextButton.styleFrom(backgroundColor: Colors.black,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Set the border radius here
                          ),),
                          child:Center(   child:Padding(padding: const EdgeInsets.all(4),
                          child:Text(
                            _clicked == false ? "Set":"${_time.hour.toString()} : ${_time.minute.toString()}",
                            style: const TextStyle(color: Colors.white,fontSize: 15),)
                          )
                          )
                        )
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
          MaterialButton(
            onPressed: (){
              _saveReminder();
            },
            height: 48.0,
            elevation: 0,
            color: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child:const Center( child:Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
              child: Text(
                "Confirm",
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          )
            ],
          ),
        ),
      ),
    );
  }
}
