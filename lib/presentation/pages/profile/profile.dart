import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spotify/common/helpers/is_dark.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  BasicAppBar(
        bgColor: context.isDarkMode ? const Color.fromARGB(255, 39, 116, 35) : const Color.fromARGB(255, 166, 235, 162),
        title:  const Text('Profile',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          _profileInfo(context),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color.fromARGB(255, 39, 116, 35) : const Color.fromARGB(255, 166, 235, 162),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
