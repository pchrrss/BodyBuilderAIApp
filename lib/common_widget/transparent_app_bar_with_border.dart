import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';
import 'package:bodybuilderaiapp/view/home/profile_view.dart';
import 'package:flutter/material.dart';

class TransparentAppBarWithBorder extends StatelessWidget implements PreferredSizeWidget {
  final UserInputModel userInput;
  final String title;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  const TransparentAppBarWithBorder({super.key, required this.title, this.actions, required this.userInput, this.automaticallyImplyLeading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: TColor.lightGrey,
            width: 1,
          ),
        ),
      ),
      child: AppBar(
        backgroundColor: TColor.white,
        automaticallyImplyLeading: automaticallyImplyLeading,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/img/logo.png',
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: TColor.black,
                ),
              ),
            ),
          ],
        ),
        actions: [
          if (actions != null) ...actions!,
          IconButton(
            icon: const Icon(Icons.manage_accounts),
            onPressed: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileView(userInput: userInput),
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
