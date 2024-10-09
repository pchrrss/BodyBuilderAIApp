import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:flutter/material.dart';

class TransparentAppBarWithBorder extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const TransparentAppBarWithBorder({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
      child: AppBar(
        excludeHeaderSemantics: true,
        elevation: 0,
        title: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: TColor.secondaryColor2,
              ),
            ),
            const Spacer(),
            Image.asset(
              'assets/img/logo.png',
              height: 50,
            ),
          ],
        ),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
