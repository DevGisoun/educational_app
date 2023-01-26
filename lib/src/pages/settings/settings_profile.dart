import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app/src/configs/themes/app_colors.dart';
import 'package:educational_app/src/controllers/settings/settings_profile_controller.dart';
import 'package:educational_app/src/firebase_ref/references.dart';
import 'package:educational_app/src/utils/app_layout.dart';
import 'package:educational_app/src/widgets/settings/settings_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../configs/themes/custom_text_styles.dart';
import '../../controllers/settings/settings_controller.dart';
import '../../firebase_ref/loading_status.dart';

class SettingsProfile extends GetView<SettingsProfileController> {
  final SettingsController settingsController;

  SettingsProfile({
    super.key,
    required this.settingsController,
  });

  final ImagePicker _picker = ImagePicker();

  TextEditingController textEditingController_nickname =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => settingsController.unFocusKeyboard(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const SettingsAppBar(
          title: 'Profile',
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: AppLayout.getHeight(10),
          ),
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    XFile? xFile = await _picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 10,
                    );
                    await controller.updateProfileImage(
                      profilepic: xFile,
                    );
                  },
                  child: GetBuilder<SettingsProfileController>(
                    builder: (settingsProfileController) =>
                        FutureBuilder<DocumentSnapshot>(
                      future: settingsProfileController.getUsersDoc(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;

                          return Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: onSurfaceTextColor,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: SizedBox(
                                    width: AppLayout.getWidth(50),
                                    height: AppLayout.getHeight(50),
                                    child: CachedNetworkImage(
                                      imageUrl: data['profilepic'],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                bottom: 0,
                                child: Container(
                                  width: AppLayout.getWidth(20),
                                  height: AppLayout.getHeight(20),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: onSurfaceTextColor,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
                Gap(
                  AppLayout.getHeight(10),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: AppLayout.getWidth(30),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: AppLayout.getHeight(30),
                          ),
                          Gap(
                            AppLayout.getHeight(10),
                          ),
                          Text(
                            'Nickname',
                            style: TextStyle(
                              fontSize: AppLayout.getHeight(20),
                            ),
                          ),
                        ],
                      ),
                      FutureBuilder<DocumentSnapshot>(
                        future: controller.getUsersDoc(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: TextField(
                                controller: textEditingController_nickname
                                  ..text = data['name'],
                                decoration: const InputDecoration(
                                  hintText: 'nickname',
                                ),
                              ),
                            );
                          }

                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextField(
                              enabled: false,
                              controller: textEditingController_nickname,
                              decoration: const InputDecoration(
                                hintText: 'nickname',
                              ),
                            ),
                          );
                        },
                      ),
                      Gap(
                        AppLayout.getHeight(30),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              print('231331213231213312');
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: onSurfaceTextColor,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Check',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
