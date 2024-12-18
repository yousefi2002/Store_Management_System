import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:store_ms/database_helper.dart';
import 'model_classes/user.dart';

class AddingUsers extends StatefulWidget {
  final User user;
  AddingUsers(this.user, {super.key});

  @override
  State<AddingUsers> createState() => _AddingUsersState(this.user);
}

class _AddingUsersState extends State<AddingUsers> {
  _AddingUsersState(this.user);

  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController userNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  User user;
  String? _userName;
  String? _userLastName;
  String? _userPhoneNumber;

  void saveUser() async {
    if (userNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        phoneNumberController.text.isEmpty) {
      DelightToastBar(
        builder: (BuildContext context) {
          return ToastCard(
              color: Colors.red,
              title: Text(
                'لطفا تمام گزینه ها را پر کنید',
                style: TextStyle(color: Colors.white),
              ));
        },
        position: DelightSnackbarPosition.top,
        autoDismiss: true,
      ).show(
        context,
      );
      return;
    }
    user = User(_userName, _userLastName, _userPhoneNumber);
    int result;
    if (user.id != null) {
      result = await databaseHelper.updateUsers(user);
    } else {
      result = await databaseHelper.insertUser(user);
    }

    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.grey,
        content: Text('اطلاعات ثبت شد', style: TextStyle(color: Colors.black)),
      ));
      userNameController.clear();
      lastNameController.clear();
      phoneNumberController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('متاسفانه اطلاعات ثبت نشد',
            style: TextStyle(color: Colors.white)),
      ));
      return;
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        title: Text('اضافه کردن فروشنده ها'),
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
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: userNameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        label: Text('نام'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _userName = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: lastNameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.person_add_alt_1,
                          color: Colors.white,
                        ),
                        label: Text('تخلص'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _userLastName = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: Colors.white,
                        ),
                        label: Text('شماره تلفن'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _userPhoneNumber = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        saveUser();
                      },
                      label: Text(
                        'ثبت',
                        style: TextStyle(fontSize: 21),
                      ),
                      icon: Icon(Icons.save),
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
