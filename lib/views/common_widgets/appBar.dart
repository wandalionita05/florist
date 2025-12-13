import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final double? leadingWidth;
  final Widget? title;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const MyAppBar({
    super.key,
    this.leading,
    this.leadingWidth,
    this.title,
    this.actions,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false, // 🔥 penting
      titleSpacing: 0,
      leading: leading,
      leadingWidth: leadingWidth,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
