import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReminderTile extends StatelessWidget {
  var title;

  var description;
  var time;
  var priority;
  var borderColor;
  var titleColor;
  int mode;

  ReminderTile(
      {super.key,
      required this.title,
      required this.description,
      required this.priority,
      required this.time,
      required this.mode});

  @override
  Widget build(BuildContext context) {
    if(mode == 1) {
      if (priority == "High") {
        borderColor = Colors.red;
      } else if (priority == "Medium") {
        borderColor = Colors.orangeAccent;
      } else {
        borderColor = Colors.green;
      }
    }else{
      borderColor = const Color(0x99F0F0F0);
      titleColor = Colors.black;
    }

    return IntrinsicWidth(
      child: Container(
        width: 800,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: borderColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black, // border color
            width: 3.0, // border width
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600,color: titleColor??Colors.white),
              ),

              Container(

                  width: 800,
                  margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),

                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            description,
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: Colors.black),
                          ),
                          Text(
                            "Time : ${time.format(context)}",
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: Colors.black),
                          ),
                          mode == 1 ?
                          Text(
                            "Priority : ${priority}",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: borderColor),
                          ):
                              const SizedBox(height: 1,)
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
