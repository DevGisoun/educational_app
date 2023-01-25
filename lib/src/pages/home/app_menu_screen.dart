import 'package:cached_network_image/cached_network_image.dart';
import 'package:educational_app/src/configs/themes/app_colors.dart';
import 'package:educational_app/src/configs/themes/settings_icons.dart';
import 'package:educational_app/src/configs/themes/ui_parameters.dart';
import 'package:educational_app/src/controllers/app_zoom_drawer_controller.dart';
import 'package:educational_app/src/models/user_model.dart';
import 'package:educational_app/src/utils/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../firebase_ref/loading_status.dart';

class AppMenuScreen extends GetView<AppZoomDrawerController> {
  final UserModel userModel;

  const AppMenuScreen({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppLayout.getWidth(25),
        vertical: AppLayout.getHeight(10),
      ),
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: mainGradient(),
      ),
      child: Theme(
        data: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: onSurfaceTextColor,
            ),
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    controller.toggleDrawer();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: AppLayout.getHeight(10),
                  right: MediaQuery.of(context).size.width * 0.3,
                ),
                child: Column(
                  children: [
                    if (controller.loadingStatus.value == LoadingStatus.loading)
                      SizedBox(
                        width: AppLayout.getHeight(50),
                        height: AppLayout.getHeight(50),
                        child: Image.asset(
                          'assets/images/app_splash_logo.png',
                        ),
                      ),
                    if (controller.loadingStatus.value ==
                        LoadingStatus.completed)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppLayout.getHeight(50),
                        ),
                        child: SizedBox(
                          width: AppLayout.getHeight(50),
                          height: AppLayout.getHeight(50),
                          child: CachedNetworkImage(
                            imageUrl: userModel.profilepic!,
                            placeholder: (context, url) => Container(
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            ),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/app_splash_logo.png',
                            ),
                          ),
                        ),
                      ),
                    Gap(
                      AppLayout.getHeight(10),
                    ),
                    Obx(
                      () => controller.user.value == null
                          ? const SizedBox()
                          : Text(
                              controller.user.value!.displayName ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: onSurfaceTextColor,
                              ),
                            ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: controller.user.value != null,
                          child: _DrawerButton(
                            icon: Icons.web,
                            label: 'Website',
                            onPressed: () => controller.website(),
                          ),
                        ),
                        Visibility(
                          visible: controller.user.value != null,
                          child: _DrawerButton(
                            icon: SettingsIcons.github_circled,
                            label: 'Github',
                            onPressed: () => controller.github(),
                          ),
                        ),
                        Visibility(
                          visible: controller.user.value != null,
                          child: _DrawerButton(
                            icon: Icons.email,
                            label: 'E-mail',
                            onPressed: () => controller.email(),
                          ),
                        ),
                        _DrawerButton(
                          icon: Icons.settings,
                          label: 'Settings',
                          onPressed: () => controller.settings(),
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                    Obx(
                      () => _DrawerButton(
                        icon: controller.checkLogIn()
                            ? Icons.logout
                            : Icons.login,
                        label: controller.checkLogIn() ? 'Logout' : 'Login',
                        onPressed: () => controller.checkLogIn()
                            ? controller.signOut()
                            : controller.signIn(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const _DrawerButton({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: AppLayout.getHeight(15),
      ),
      label: Text(label),
    );
  }
}
