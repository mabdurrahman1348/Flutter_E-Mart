import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/chat_screen/messaging_screen.dart';
import 'package:emart_app/views/order_screen/orders_screen.dart';
import 'package:emart_app/views/profile_screen/components/details_card.dart';
import 'package:emart_app/views/profile_screen/edit_profile_screen.dart';
import 'package:emart_app/views/wishlist_screen/wishlist_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/loadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    // var media = MediaQuery.of(context).size.height;
    return bgWidget(Scaffold(
        body: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor)),
                );
              } else {
                var data = snapshot.data!.docs[0];

                return SafeArea(
                  child: Column(
                    children: [
                      //profile picture in user account and edit profile

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.edit,
                                color: whiteColor,
                              )).onTap(() {
                            controller.nameController.text = data['name'];
                            // controller.passController.text = data['password'];
                            Get.to(() => EditProfileScreen(data: data));
                          }),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            data['imageUrl'] == ''
                                ? Image.asset(
                                    imgB1,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make()
                                : Image.network(
                                    data['imageUrl'],
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                            5.widthBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      // 'dummy'
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make(),
                                  5.heightBox,
                                  "${data['email']}".text.white.make(),
                                ],
                              ),
                            ),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: whiteColor)),
                                onPressed: () {
                                  Get.offAll(() => const LoginScreen());
                                },
                                child: logout.text
                                    .fontFamily(semibold)
                                    .white
                                    .make())
                          ],
                        ),
                      ),

                      20.heightBox,
                      FutureBuilder(
                          future: FirestoreServices.getCounts(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: loadingIndicator());
                            } else {
                              var countdata = snapshot.data;
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  detailsCard(
                                      count: countdata[0].toString(),
                                      title: 'in your cart',
                                      width: context.screenWidth / 3.4),
                                  detailsCard(
                                      count: countdata[1].toString(),
                                      title: 'in your wishlist',
                                      width: context.screenWidth / 3.4),
                                  detailsCard(
                                      count: countdata[2].toString(),
                                      title: 'your orders',
                                      width: context.screenWidth / 3.4),
                                ],
                              );
                            }
                          })
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     detailsCard(
                      //         count: data['cart_count'],
                      //         title: 'in your cart',
                      //         width: context.screenWidth / 3.4),
                      //     detailsCard(
                      //         count: data['wishlist_count'],
                      //         title: 'in your wishlist',
                      //         width: context.screenWidth / 3.4),
                      //     detailsCard(
                      //         count: data['order_count'],
                      //         title: 'your orders',
                      //         width: context.screenWidth / 3.4),
                      //   ],
                      // ),

                      //buttons section

                      // (media / 14).heightBox,

                      ,
                      ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  color: lightGrey,
                                );
                              },
                              itemCount: profileButtonsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() => const OrdersScreen());
                                        break;
                                      case 1:
                                        Get.to(() => const WishlistScreen());
                                        break;
                                      case 2:
                                        Get.to(() => const MessagesScreen());
                                        break;
                                    }
                                  },
                                  leading: Image.asset(
                                    profileButtonIcon[index],
                                    width: 22,
                                  ),
                                  title: profileButtonsList[index]
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                );
                              })
                          .box
                          .white
                          .rounded
                          .margin(const EdgeInsets.all(12))
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .shadowSm
                          .make()
                          .box
                          .color(redColor)
                          .make(),
                    ],
                  ),
                );
              }
            })));
  }
}
