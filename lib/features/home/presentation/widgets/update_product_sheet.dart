// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_address_investments_ecommerce/core/entities/product_entity.dart';
import 'package:the_address_investments_ecommerce/core/utils/app_assets.dart';
import 'package:the_address_investments_ecommerce/core/widgets/tap_effect.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/utils/toast.dart';
import '../../../../generated/l10n.dart';
import '../bloc/home_bloc.dart';

class UpdateproductSheet extends StatefulWidget {
  UpdateproductSheet({super.key, required this.productEntity, required this.homeBloc});
  ProductEntity productEntity;
  final HomeBloc homeBloc;

  @override
  State<UpdateproductSheet> createState() => _UpdateproductSheetState();
}

class _UpdateproductSheetState extends State<UpdateproductSheet> {
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
     late TextEditingController titleController ;
     late TextEditingController priceController ;


    @override
  void initState() {

    super.initState();
     titleController = TextEditingController(text: widget.productEntity.title);
     priceController = TextEditingController(text: widget.productEntity.price.toString());
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //product info(title & price)
          SizedBox(
            height: 300.h,
            child: Padding(
              padding: EdgeInsets.only(
                top: 22.r,
                left: 20.r,
                right: 20.r,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title & close icon
                  Row(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      //title
                      Text(
                        S.of(context).editProduct,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.darkBackground,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Inter",
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      //close icon
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          AppAssets.closIcons,
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //title
                        Text(
                          S.of(context).title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                            color: AppColors.textFieldTitleColor,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        TextFormField(
                          controller: titleController,
                          onTap: () {
                            
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return AppValidator.validateText(
                                value: value, isEmptyErrorMessage: S.of(context).enterProductTitle);
                          },
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.lightBlack,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.lightBlack,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                            ),
                            hintText: S.of(context).productTitle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide: BorderSide(
                                color: AppColors.textFieldBorderColor,
                                width: 0.5.w,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.r,
                              vertical: 8.r,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        //price
                        Text(
                          S.of(context).price,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                            color: AppColors.textFieldTitleColor,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            return AppValidator.validateText(
                                value: value, isEmptyErrorMessage: S.of(context).enterProductPrice);
                          },
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.lightBlack,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.lightBlack,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                            ),
                            hintText: S.of(context).productPrice,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide: BorderSide(
                                color: AppColors.textFieldBorderColor,
                                width: 0.5.w,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.r,
                              vertical: 8.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //update button
          BlocConsumer<HomeBloc, HomeStates>(
            bloc: widget.homeBloc,
            buildWhen: (prevoius, current) =>
                current is UpdateProductLoadingState ||
                current is UpdateProductSuccessState ||
                current is UpdateProductFailureState,
            listener: (context, state) {
              if (state is UpdateProductSuccessState) {
                CustomToast.showToast(
                  background: Colors.green,
                  msg: S.of(context).productUpdatedSuccessfully,
                );
              }
              if (state is UpdateProductFailureState) {
                CustomToast.showToast(
                  msg: state.message,
                  background: Colors.red,
                );
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: TapEffect(
                  onClick: ( ) async{
                                     if (_formKey.currentState!.validate()) {
                        final Map<String, dynamic> updatedProductData = {
                          "title": titleController.text,
                          "price": int.parse(priceController.text),
                        };
                        await widget.homeBloc.updateProduct(id: widget.productEntity.id, updatedProductData: updatedProductData);
                      }
                      Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 68.h,
                    alignment: Alignment.center,

                    color: AppColors.primary,
                    child: state is UpdateProductLoadingState
                        ? CircularProgressIndicator(color: AppColors.white)
                        : Text(
                            S.of(context).update,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                              fontFamily: "Inter",
                            ),
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
