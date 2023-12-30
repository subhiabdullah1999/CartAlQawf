import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/splash_controller.dart';
import '../../utils/app_theme_data.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashController controller = Get.put(SplashController());

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: AppThemeData.splashScreenColor,
      body: SafeArea(
        child: Container(
            color: Colors.white,
            height: size.height,
            width: size.width,
            child: Container(
              color: Colors.white,

              // color: AppThemeData.splashScreenColor,
              height: 300,
              child: Center(
                child: AspectRatio(
                  aspectRatio:
                      controller.videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(controller.videoPlayerController),
                ),
              ),
            )
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       width: 142.w,
            //       height: 142.h,
            //       child: Center(
            //         child: Image.asset("assets/logos/logo.png"),
            //       ),
            //     ),
            //   ],
            // ),
            ),
      ),
    );
  }
}
