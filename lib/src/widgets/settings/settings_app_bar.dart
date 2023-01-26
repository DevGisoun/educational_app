import 'package:flutter/material.dart';

import '../../utils/app_layout.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const SettingsAppBar({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        title ?? 'Untitle',
        style: TextStyle(
          fontSize: AppLayout.getHeight(20),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(
        double.maxFinite,
        AppLayout.getHeight(60),
      );
}
