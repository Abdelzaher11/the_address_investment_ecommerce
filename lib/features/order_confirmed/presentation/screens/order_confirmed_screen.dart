import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_address_investments_ecommerce/core/widgets/tap_effect.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../generated/l10n.dart';

class OrderConfirmedScreen extends StatelessWidget {
  const OrderConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TapEffect(
        onClick: () {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRoute, (_) => false);
        },
        child: Container(
          color: AppColors.primary,
          alignment: Alignment.center,
          height: 68.h,
          child: Text(
            S.of(context).ContinueShopping,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
              fontFamily: "Inter",
            ),
          ),
        ),
      ),
      body: PopScope(
        canPop: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //bg
            SizedBox(
              width: double.infinity,
              height: 335.76.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  //bg
                  Positioned.fill(
                    child: Transform.flip(
                      flipY: true,
                      child: CustomPaint(
                        painter: SemiCirclesPainter(),
                      ),
                    ),
                  ),
                  //image
                  Image.asset(
                    AppAssets.orderConfirmed,
                  ),
                ],
              ),
            ),
            Text(
              S.of(context).orderConfirmed,
              style: TextStyle(
                color: AppColors.lightBlack,
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.r),
              child: Text(
                S.of(context).orderConfirmedDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.lightlyGrey,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SemiCirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.black.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Offset center = Offset(size.width / 2, size.height * 0.4); // Adjust position
    double radius = size.width * 0.35; // Initial radius

    // Draw 3 concentric semi-circles
    for (int i = 0; i < 3; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        0, // Start angle (0 radians)
        3.14, // Sweep angle (pi radians for half-circle)
        false,
        paint,
      );
      radius += 50; // Increase radius for next circle
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
