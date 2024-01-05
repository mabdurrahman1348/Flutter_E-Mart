import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/cart_screen/payment_method.dart';
import 'package:emart_app/widgets_common/custom_textfeild.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ourButton(
          onPress: () {
            if (controller.addressController.text.length < 10) {
              VxToast.show(context, msg: "Please enter detailed address!");
            } else if (controller.cityController.text.isEmpty) {
              VxToast.show(context, msg: "Please enter your city!");
            } else if (controller.stateController.text.isEmpty) {
              VxToast.show(context, msg: "Please enter your state!");
            } else if (int.tryParse(controller.postalcodeController.text) ==
                null) {
              VxToast.show(context, msg: "Please enter correct postal code!");
            } else if (controller.phoneController.text.length != 11 ||
                int.tryParse(controller.phoneController.text) == null) {
              VxToast.show(context,
                  msg: "Please enter a valid 11-digit phone number!");
            } else {
              Get.to(() => const PaymentMethods());
            }
          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            customTextField(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            customTextField(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            customTextField(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalcodeController),
            customTextField(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController)
          ],
        ),
      ),
    );
  }
}





//  if (controller.addressController.text.length > 10 &&
//                 controller.cityController.text.isNotEmpty &&
//                 controller.stateController.text.isNotEmpty &&
//                 int.tryParse(controller.postalcodeController.text) != null &&
//                 int.tryParse(controller.phoneController.text)! < 11) {
//               Get.to(() => const PaymentMethods());
//             } else {
//               VxToast.show(context, msg: "Please fill the form correctly");
//             }