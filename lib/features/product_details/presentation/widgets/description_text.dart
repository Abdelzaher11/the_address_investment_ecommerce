import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../generated/l10n.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final bool isLoading;
  const ExpandableText({super.key, required this.text, this.isLoading = false});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  bool _isOverflowing = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(
          text: widget.text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter",
            color: Colors.grey[600],
          ),
        );

        final textPainter = TextPainter(
          text: span,
          maxLines: 5,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);

        _isOverflowing = textPainter.didExceedMaxLines;

        if (widget.isLoading) {
          return Skeletonizer(
            child: Text(
              "The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends.The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends.The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter",
                color: AppColors.lightlyGrey,
              ),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: _isExpanded
                        ? widget.text
                        : "${widget.text.substring(0, textPainter.getOffsetBefore(100) ?? widget.text.length)}..",
                    style: TextStyle(
                      color: AppColors.lightlyGrey,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter",
                    ),
                  ),
                  if (_isOverflowing)
                    TextSpan(
                      text: _isExpanded ? "  ${S.of(context).seeLess}" : "  ${S.of(context).seeMore}",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter",
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
