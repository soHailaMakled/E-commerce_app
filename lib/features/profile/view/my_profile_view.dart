import 'package:flutter/material.dart';
import 'package:ntigradproject/core/resources_manager/appbar_main.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_icons.dart';
import 'package:ntigradproject/core/utils/app_images.dart';
import 'package:ntigradproject/core/utils/app_strings.dart';
import 'package:ntigradproject/features/auth/view/widget/form_field_main.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appbartitle: const Text(AppStrings.profile),
        leadingicon: Icon(Icons.arrow_back_ios),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          SizedBox(
            width: 120,
            child: Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(MyAppImage.profile),
                    ),
                  ),

                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 66),
          MyTextFormField(
            validator: (String? text) {
              String error;
              if (text != null) {
                if (text.isNotEmpty) {
                  final RegExp nameRegex = RegExp(r'^[a-zA-Z ]+$');
                  if (nameRegex.hasMatch(text)) {
                    return null;
                  } else {
                    error = 'name must be in English';
                  }
                } else {
                  error = '  enter Name';
                }
              } else {
                error = '  you must assighn Name';
              }
              return error;
            },
            bottommargin: 10,
            labeltext: AppStrings.fullname,
            icon: MyAppIcons.user,
          ),
          MyTextFormField(
            validator: (String? text) {
              String error;
              if (text != null) {
                if (text.isNotEmpty) {
                  final RegExp phoneRegex = RegExp(
                    r'^(010|011|012|015)[0-9]{8}$',
                  );
                  if (phoneRegex.hasMatch(text)) {
                    return null;
                  } else {
                    error = 'Invalid phone number.';
                  }
                } else {
                  error = ' enter phone number ';
                }
              } else {
                error = '  you must assighn phone number ';
              }
              return error;
            },

            bottommargin: 10,
            labeltext: AppStrings.phone,
            icon: MyAppIcons.call,
          ),
          SizedBox(height: 70),
          Container(
            width: double.infinity,
            height: 55,
            margin: EdgeInsets.symmetric(horizontal: 29),
            decoration: BoxDecoration(
              color: MyAppColors.red,
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.save,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: MyAppColors.background,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}