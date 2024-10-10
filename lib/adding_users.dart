import 'package:flutter/material.dart';

class AddingUsers extends StatefulWidget {
  const AddingUsers({super.key});

  @override
  State<AddingUsers> createState() => _AddingUsersState();
}

class _AddingUsersState extends State<AddingUsers> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        title: Text('Add User'),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            left: 30,
            top: 115,
            right: 30,
            bottom: 115,
            child: Container(
              width: 400,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.orange[300],
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 450,
              decoration: BoxDecoration(
                color: Colors.teal[300],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_add_alt_1),
                          label: Text('Full Name'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        label: Text('Phone Number'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('Save'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
