import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_address_investments_ecommerce/config/app_theme.dart';
import 'package:the_address_investments_ecommerce/core/navigation/routes.dart';
import 'package:the_address_investments_ecommerce/generated/l10n.dart';

class LazaApp extends StatelessWidget {
  const LazaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => ScreenUtilInit(
        designSize: orientation == Orientation.landscape ? const Size(812, 375) : const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: MaterialApp(
            localizationsDelegates: const [
              S.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            title: 'Laza',
            theme: AppTheme.themeData,
            routes: AppRoutes.routes,
            initialRoute: AppRoutes.initialRoute,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
