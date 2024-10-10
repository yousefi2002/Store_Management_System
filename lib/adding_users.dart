import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddingUsers extends StatefulWidget {
  const AddingUsers({super.key});

  @override
  State<AddingUsers> createState() => _AddingUsersState();
}

class _AddingUsersState extends State<AddingUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextField(),
        TextField(),
        ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  Icons.save,
                ),
                Text('Save'),
              ],
            ))
      ],
    ));
  }
}
