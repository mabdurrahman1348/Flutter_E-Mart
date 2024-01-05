import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfeild.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    // controller.nameController.text = data['name'];
    // controller.passController.text = data['password'];
    return bgWidget(Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if data image url is empty and controller path is empty

              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgB1,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change"),
              const Divider(),
              20.heightBox,
              customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false,
              ),
              10.heightBox,
              customTextField(
                controller: controller.oldpassController,
                hint: passwordHint,
                title: oldpass,
                isPass: true,
              ),
              10.heightBox,
              customTextField(
                controller: controller.newpassController,
                hint: passwordHint,
                title: newpass,
                isPass: true,
              ),
              20.heightBox,
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 30,
                      child: ourButton(
                          color: redColor,
                          onPress: () async {
                            controller.isLoading(true);

                            // if image is not selected

                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImageLink = data['imageUrl'];
                            }

                            if (data['password'] ==
                                controller.oldpassController.text) {
                              await controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpassController.text,
                                newpassword: controller.newpassController.text,
                              );

                              await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: controller.newpassController.text,
                              );
                              VxToast.show(context, msg: "Updated");
                            } else {
                              VxToast.show(context, msg: "Wrong old password");
                              controller.isLoading(false);
                            }
                          },

                          //   if (data['password'] ==
                          //           controller.oldpassController.text &&
                          //       controller.newpassController.text == "") {
                          //     await controller.updateProfile(
                          //         name: controller.nameController.text,
                          //         password: controller.oldpassController.text,
                          //         imgUrl: controller.profileImageLink);
                          //     VxToast.show(context, msg: "updated");
                          //   } else if (data['password'] ==
                          //           controller.oldpassController.text &&
                          //       controller.newpassController.text != null) {
                          //     await controller.changeAuthPassword(
                          //       email: data['email'],
                          //       password: controller.oldpassController.text,
                          //       newpassword: controller.newpassController.text,
                          //     );
                          //     await controller.updateProfile(
                          //         name: controller.nameController.text,
                          //         password: controller.newpassController.text,
                          //         imgUrl: controller.profileImageLink);
                          //     VxToast.show(context, msg: "updated");
                          //   } else {
                          //     VxToast.show(context, msg: "Wrong password");
                          //   }
                          // },
                          textColor: whiteColor,
                          title: "Save"),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      ),
    ));
  }
}

















// if (data['password'] ==
//                                 controller.oldpassController.text) {
//                               await controller.changeAuthPassword(
//                                 email: data['email'],
//                                 password: controller.oldpassController.text,
//                                 newpassword: controller.newpassController.text,
//                               );

//                               await controller.updateProfile(
//                                 imgUrl: controller.profileImageLink,
//                                 name: controller.nameController.text,
//                                 password: controller.newpassController.text,
//                               );
//                               VxToast.show(context, msg: "Updated");
//                             } else {
//                               VxToast.show(context, msg: "Wrong old password");
//                               controller.isLoading(false);
//                             }
//                           },
