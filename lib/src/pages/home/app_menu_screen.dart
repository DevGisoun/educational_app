import 'package:cached_network_image/cached_network_image.dart';
import 'package:educational_app/src/configs/themes/app_colors.dart';
import 'package:educational_app/src/configs/themes/settings_icons.dart';
import 'package:educational_app/src/configs/themes/ui_parameters.dart';
import 'package:educational_app/src/controllers/app_zoom_drawer_controller.dart';
import 'package:educational_app/src/utils/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AppMenuScreen extends GetView<AppZoomDrawerController> {
  const AppMenuScreen({super.key});

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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppLayout.getHeight(50),
                      ),
                      child: SizedBox(
                        width: AppLayout.getHeight(50),
                        height: AppLayout.getHeight(50),
                        child: CachedNetworkImage(
                          imageUrl: controller.user.value!.photoURL!,
                          fit: BoxFit.cover,
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
                        _DrawerButton(
                          icon: Icons.web,
                          label: 'Website',
                          onPressed: () => controller.website(),
                        ),
                        _DrawerButton(
                          icon: SettingsIcons.github_circled,
                          label: 'Github',
                          onPressed: () => controller.github(),
                        ),
                        _DrawerButton(
                          icon: Icons.email,
                          label: 'E-mail',
                          onPressed: () => controller.email(),
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
                        // icon: Icons.logout,
                        icon: controller.checkLogIn()
                            ? Icons.logout
                            : Icons.login,
                        // label: 'Logout',
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
