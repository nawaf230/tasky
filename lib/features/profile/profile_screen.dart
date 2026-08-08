import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/profile/user_details_screen.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _username;
  String? _motivationQuote;
  String? userImagePath;
  bool isLoding = true;

  void _loadData() async {
    setState(() {
      _username = PreferencesManager().getString(StorageKey.username) ?? "";
      _motivationQuote =
          PreferencesManager().getString(StorageKey.motivationQuote) ??
          "One task at a time. One step closer.";
      userImagePath = PreferencesManager().getString(StorageKey.userImage);
      isLoding = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // hint the bice code in method build not working if else isLoading is false.
  @override
  Widget build(BuildContext context) {
    return isLoding
        ? Center(child: CircularProgressIndicator(color: Color(0xFFFFFCFC)))
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Center(
                    child: Text(
                      "My Profile",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
                const Gap(18),

                Center(
                  child: Column(
                    children: [
                      const Gap(8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          border: Border.all(
                            color: ThemeController.isDark()
                                ? Colors.transparent
                                : Color(0xFFD1DAD6),
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              backgroundImage: userImagePath != null
                                  ? FileImage(File(userImagePath!))
                                  : null,
                              child: userImagePath == null
                                  ? ClipOval(
                                      child: CustomSvgPicture.withoutColor(
                                        path: "assets/images/person.svg",
                                      ),
                                    )
                                  : null,
                            ),
                            GestureDetector(
                              onTap: () async {
                                showImageSourceDialog(context, (selectedFile) {
                                  _saveImage(selectedFile);
                                  setState(() {
                                    userImagePath = selectedFile.path;
                                  });
                                });
                              },
                              child: Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: ThemeController.isDark()
                                        ? Colors.transparent
                                        : Color(0xFFD1DAD6),
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  weight: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(8),
                      Text(
                        _username,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const Gap(4),

                      Text(
                        _motivationQuote == null
                            ? "One task at a time. One step closer."
                            : "$_motivationQuote",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                const Gap(24),
                Text(
                  "Profile Info",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const Gap(20),
                ListTile(
                  onTap: () async {
                    bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsScreen(
                          userName: _username,
                          motivationQuote: _motivationQuote,
                        ),
                      ),
                    );
                    if (result ?? false) {
                      _loadData();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text("User Details"),
                  leading: CustomSvgPicture(
                    path: "assets/images/profile_icon.svg",
                    colorFilter: ThemeController.isDark()
                        ? Color(0xFFFFFCFC)
                        : Color(0xFF161F1B),
                  ),
                  trailing: SvgPicture.asset(
                    "assets/images/arrow_right.svg",
                    colorFilter: ColorFilter.mode(
                      ThemeController.isDark()
                          ? Color(0xFFC6C6C6)
                          : Color(0xFF3A4640),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Dark Mode"),
                  leading: CustomSvgPicture(
                    path: "assets/images/dark_icon.svg",
                    colorFilter: Theme.of(context).colorScheme.secondary,
                  ),
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themeNotifier,
                    // this variable lisane Are changed or not than return the value changed in the value
                    builder:
                        (BuildContext context, ThemeMode value, Widget? child) {
                          return Switch(
                            value: value == ThemeMode.dark,
                            onChanged: (value) {
                              // print("==================$value");
                              ThemeController.toggleTheme();
                            },
                          );
                        },
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () async {
                    await PreferencesManager().remove(StorageKey.username);
                    await PreferencesManager().remove(
                      StorageKey.motivationQuote,
                    );
                    await PreferencesManager().remove(StorageKey.tasks);

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text("Log Out"),
                  leading: CustomSvgPicture(
                    path: "assets/images/logout_icon.svg",
                    colorFilter: Theme.of(context).colorScheme.secondary,
                  ),
                  trailing: CustomSvgPicture(
                    path: "assets/images/arrow_right.svg",
                    colorFilter: ThemeController.isDark()
                        ? Color(0xFFC6C6C6)
                        : Color(0xFF3A4640),
                  ),
                ),
              ],
            ),
          );
  }

  void _saveImage(XFile file) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy("${appDir.path}/${file.name}");
    await PreferencesManager().setString(StorageKey.userImage, newFile.path);
  }
}

void showImageSourceDialog(BuildContext context, Function(XFile) selectedFile) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text(
          "Chooes Image Source",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                selectedFile(image);
              }
            },
            child: Row(
              children: [Icon(Icons.camera_alt), const Gap(8), Text("Camera")],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                selectedFile(image);
              }
            },
            child: Row(
              children: [
                Icon(Icons.photo_library_outlined),
                const Gap(8),
                Text("Gallery"),
              ],
            ),
          ),
        ],
      );
    },
  );
}
