import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/datasource/local_data/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });

  late String userName;
  final String? motivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late String _userName;
  late String _motivationQuote;

  late TextEditingController _userNameController;
  late TextEditingController _motivationController;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController(text: widget.userName);
    _motivationController = TextEditingController(text: widget.motivationQuote);
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _motivationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: SafeArea(
        child: Form(
          key: _key,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSizes.h8),
                CustomTextFormField(
                  title: "User Name",
                  controller: _userNameController,
                  hintText: "User Name",
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter User Name";
                    }
                    _userName = value;
                    return null;
                  },
                  maxLines: 1,
                ),
                SizedBox(height: AppSizes.h20),
                CustomTextFormField(
                  title: "Motivation Quote",
                  controller: _motivationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Motivation Quote";
                    }
                    _motivationQuote = value;
                    return null;
                  },
                  maxLines: 5,
                  hintText: "One task at a time. One step closer.",
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      await PreferencesManager().setString(
                        StorageKey.username,
                        _userName,
                      );
                      await PreferencesManager().setString(
                        StorageKey.motivationQuote,
                        _motivationQuote,
                      );
                      if (!context.mounted) return;

                      Navigator.of(context).pop(true);
                    }
                  },

                  child: Text(
                    "Save Changes",
                    style: TextStyle(
                      fontSize: AppSizes.sp14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.h16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
