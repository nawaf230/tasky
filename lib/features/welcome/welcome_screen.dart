import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/datasource/local_data/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/features/Navigation/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(height: AppSizes.h16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSvgPicture.withoutColor(
                        path: "assets/images/logo.svg",
                        height: AppSizes.h42,
                        width: AppSizes.w42,
                      ),
                      SizedBox(width: AppSizes.h16),
                      Text(
                        "Tasky",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.h118),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Tasky ",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      CustomSvgPicture.withoutColor(
                        path: "assets/images/waving_hand.svg",
                        height: AppSizes.h28,
                        width: AppSizes.w28,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.h8),
                  Text(
                    "Your productivity journey starts here.",

                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: AppSizes.sp16),
                  ),
                  SizedBox(height: AppSizes.h24),
                  CustomSvgPicture.withoutColor(
                    path: "assets/images/pana.svg",
                    width: AppSizes.w216,
                    height: AppSizes.h200,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppSizes.h28),

                        CustomTextFormField(
                          controller: _nameController,
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Please Enter Your Full Name";
                            }
                            return null;
                          },
                          title: "Full Name",
                          hintText: "e.g. Sarah Khalid",
                          maxLines: 1,
                        ),
                        SizedBox(height: AppSizes.h24),

                        ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState?.validate() ?? false) {
                              await PreferencesManager().setString(
                                StorageKey.username,
                                _nameController.text,
                              );

                              if (!context.mounted) return;

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Enter Your Full Name")),
                              );
                            }
                          },

                          child: Text("Let’s Get Started"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
