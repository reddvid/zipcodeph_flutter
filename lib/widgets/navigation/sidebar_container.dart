import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter2/widgets/navigation/sidebar_button.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 320, minWidth: 240),
      child: const Column(
        children: [
          SidebarButton(
            label: "Search",
            icon: Icons.search_outlined,
          )
        ],
      ),
    );
  }
}
