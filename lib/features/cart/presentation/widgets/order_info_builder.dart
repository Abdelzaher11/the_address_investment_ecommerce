import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../generated/l10n.dart';
import '../bloc/cart_bloc.dart';
import 'order_info_card.dart';

class OrderInfoBuilder extends StatelessWidget {
  const OrderInfoBuilder({super.key,this.isLoading = false,required this.subTotal,required this.total});
  final bool isLoading;
  final int subTotal,total;
  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return const Skeletonizer(child: OrderInfoWidget(subTotal: 0,total: 0,));
    }
    return OrderInfoWidget(subTotal: subTotal,total: total,);
  }
}


class OrderInfoWidget extends StatelessWidget {
  const OrderInfoWidget({super.key,required this.subTotal,required this.total});
 final int subTotal,total;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //subtotal
        OrderInfoCard(label: S.of(context).subTotal, value: "$subTotal"),
        SizedBox(
          height: 10.h,
        ),
        //shipping cost
        OrderInfoCard(label: S.of(context).shippingCost, value: "${context.read<CartBloc>().shippingCost}"),
        SizedBox(
          height: 15.h,
        ),
        //total
        OrderInfoCard(label: S.of(context).total, value: "$total"),
      ],
    );
  }
}