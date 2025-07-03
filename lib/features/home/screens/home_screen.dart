import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/common/widgets/custom_assets_image_widget.dart';
import 'package:saladappv2_flutter/common/widgets/search_widget.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/images.dart';
import 'package:saladappv2_flutter/util/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool getTheme = Get.find<ThemeController>().darkTheme;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getTheme ? AppColors.black : Colors.transparent,
      appBar: AppBar(
        toolbarHeight: 0.h,
        backgroundColor: getTheme ? AppColors.darkerGrey : AppColors.green,
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverAppBar(
            backgroundColor: getTheme ? AppColors.darkerGrey : AppColors.green,
            floating: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 60.h,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3.w),
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        foregroundImage: AssetImage(Images.profileRonaldo),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeSmall.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "welcome_back".tr,
                            style: robotoMedium.copyWith(
                              color: AppColors.textWhite.withValues(alpha: 0.8),
                              fontSize: Dimensions.fontSizeDefault.sp,
                            ),
                          ),
                          Text(
                            "Mr, Ronaldo",
                            style: robotoMedium.copyWith(
                              color: AppColors.textWhite,
                              fontSize: Dimensions.fontSizeLarge.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.find<ThemeController>().toggleTheme();
                    setState(() {
                      getTheme = Get.find<ThemeController>().darkTheme;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(7.w),
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: CustomAssetImageWidget(
                      Images.modeOption,
                      fit: BoxFit.contain,
                      color: getTheme ? AppColors.black : AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverDelegate(
              height: 80.h,
              callback: (val) {},
              child: Container(
                decoration: BoxDecoration(
                  color: getTheme ? AppColors.darkerGrey : AppColors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                width: DeviceUtils.screenWidth(),
                height: 80.h,
                child: SearchWidget(
                  controller: _searchController,
                  title: "search_salad_disease".tr,
                  fillColor: getTheme ? AppColors.darkGrey : AppColors.white,
                  iconColor:
                      getTheme
                          ? AppColors.black.withValues(alpha: 0.5)
                          : AppColors.primary.withValues(alpha: 0.5),
                  titleStyle: robotoMedium.copyWith(
                    fontSize: Dimensions.fontSizeDefault.sp,
                    color:
                        getTheme
                            ? AppColors.white
                            : AppColors.black.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: CarouselSlider.builder(
                  itemCount: 3,
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayCurve: Curves.linearToEaseOut,
                    autoPlayInterval: Duration(seconds: 2),
                    height: 150,
                    autoPlayAnimationDuration: Duration(milliseconds: 700),
                    viewportFraction: 0.8,
                    pauseAutoPlayOnManualNavigate: true,
                  ),
                  carouselController: _carouselController,
                  itemBuilder: (context, index, realIndex) {
                    return Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(18.r),
                          border: Border(
                            left: BorderSide(
                              width: 7,
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ),
                        child: Image.asset(
                          Images.logo,
                          width: DeviceUtils.screenWidth(),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  Function(bool isPinned)? callback;
  bool isPinned = false;

  SliverDelegate({required this.child, this.height = 50, this.callback});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    isPinned = shrinkOffset == maxExtent /*|| shrinkOffset < maxExtent*/;
    callback!(isPinned);
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height ||
        oldDelegate.minExtent != height ||
        child != oldDelegate.child;
  }
}
