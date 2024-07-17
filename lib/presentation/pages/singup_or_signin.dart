import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/widgets/button/my_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class SingupOrSignin extends StatelessWidget {
  const SingupOrSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topRight),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.botRight),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.billieSignup),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppVectors.logo),
                const SizedBox(
                  height: 21,
                ),
                const Text(
                  'Lets Get Started !',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 21,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    '  Ready to find your next favorite tune? Lets Get you started by signing you up',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: AppColors.txt_grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [
                    MyButton(onpressed: () {}, txt_title: 'Register'),
                    const SizedBox(
                      width: 30,
                    ),
                    MyButton(onpressed: () {}, txt_title: 'Login')
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
