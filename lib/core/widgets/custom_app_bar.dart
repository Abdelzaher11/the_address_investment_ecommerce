import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../navigation/routes.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackButtonPressed;
  final bool showLogo, showActionButton, showBackButton;
  final String title;
  final Color? backButtonBackgroundColor;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    this.onBackButtonPressed,
    this.showLogo = false,
    this.showActionButton = true,
    this.showBackButton = true,
    this.backButtonBackgroundColor,
    this.backgroundColor,
    this.title = "",
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leadingWidth: 75.w,
      leading: showBackButton
          ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.r),
            child: InkWell(
                onTap: onBackButtonPressed ?? () => Navigator.of(context).pop(),
                child: Container(
                  height: 45.r,
                  width: 45.r,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: backButtonBackgroundColor ?? AppColors.white,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
          )
          : null,
      centerTitle: true,
      title: showLogo
          ? Image.asset(AppAssets.logo)
          : Text(
              title,
              style: TextStyle(
                color: AppColors.lightBlack,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
              ),
            ),
      automaticallyImplyLeading: false,
      actions: showActionButton
          ? [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.r,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.cartRoute);
                  },
                  child: Container(
                    height: 44.r,
                    width: 44.r,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightBackground,
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(AppAssets.cartIcon),
                  ),
                ),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
