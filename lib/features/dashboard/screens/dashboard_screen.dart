import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:saladappv2_flutter/features/camera/screens/camera_screen.dart';
import 'package:saladappv2_flutter/features/disease/screens/disease_screen.dart';
import 'package:saladappv2_flutter/features/home/screens/home_screen.dart';
import 'package:saladappv2_flutter/features/profile/screens/profile_screen.dart';
import 'package:saladappv2_flutter/features/salad/screens/salad_screen.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  final bool fromSplash;
  const DashboardScreen({
    super.key,
    required this.pageIndex,
    this.fromSplash = false,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  @override
  void initState() {
    super.initState();
    print(widget.pageIndex);
    _pageIndex = widget.pageIndex;
    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      const HomeScreen(),
      const DiseaseScreen(),
      const CameraScreen(),
      const SaladScreen(),
      const ProfileScreen(),
    ];

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _screens.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return _screens[index];
            },
          ),
          SizedBox(
            width: DeviceUtils.screenWidth(),
            height: 80.h,
            child: InkWell(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home),
                  SizedBox(height: 20.h),
                  Text("Home"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
