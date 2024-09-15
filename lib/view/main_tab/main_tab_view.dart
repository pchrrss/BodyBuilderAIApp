import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/common_widget/tab_buttom.dart';
import 'package:flutter/material.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  var selectTab = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        height: 70,
        shadowColor: TColor.black,
        elevation: 10,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabButtom(
              icon: Icons.home_outlined,
              selectIcon: Icons.home,
              onTap: () {
                if (mounted) {
                  setState(() {
                    selectTab = 0;
                  });
                }
              },
              isActive: selectTab == 0,
            ),
            TabButtom(
              icon: Icons.search_outlined,
              selectIcon: Icons.search,
              onTap: () {
                if (mounted) {
                  setState(() {
                    selectTab = 1;
                  });
                }
              },
              isActive: selectTab == 1,
            ),
            TabButtom(
              icon: Icons.add_outlined,
              selectIcon: Icons.add,
              onTap: () {
                if (mounted) {
                  setState(() {
                    selectTab = 2;
                  });
                }
              },
              isActive: selectTab == 2,
            ),
            TabButtom(
              icon: Icons.favorite_outline,
              selectIcon: Icons.favorite,
              onTap: () {
                if (mounted) {
                  setState(() {
                    selectTab = 3;
                  });
                }
              },
              isActive: selectTab == 3,
            ),
          ],
        ),
      ),
    );
  }
}
