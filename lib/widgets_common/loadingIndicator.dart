// Container(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.generate(
//                     controller.subcat.length,
//                     (index) => "${controller.subcat[index]}"
//                         .text
//                         .size(12)
//                         .fontFamily(semibold)
//                         .color(darkFontGrey)
//                         .makeCentered()
//                         .box
//                         .white
//                         .rounded
//                         .size(123, 60)
//                         .margin(const EdgeInsets.symmetric(horizontal: 4))
//                         .make()),
//               ),
//             ),

//             //items Container

//             20.heightBox,

//             Expanded(
//                 child: GridView.builder(
//                     physics: const BouncingScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: 6,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             mainAxisExtent: 250,
//                             mainAxisSpacing: 8,
//                             crossAxisSpacing: 8),
//                     itemBuilder: ((context, index) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Image.asset(
//                             imgP5,
//                             width: 200,
//                             height: 150,
//                             fit: BoxFit.cover,
//                           ),
//                           'Laptop 4GB/64GB'
//                               .text
//                               .fontFamily(semibold)
//                               .color(darkFontGrey)
//                               .make(),
//                           10.heightBox,
//                           '\$600'
//                               .text
//                               .color(redColor)
//                               .fontFamily(bold)
//                               .size(16)
//                               .make()
//                         ],
//                       )
//                           .box
//                           .white
//                           .margin(const EdgeInsets.symmetric(horizontal: 4))
//                           .roundedSM
//                           .outerShadowSm
//                           .padding(const EdgeInsets.all(12))
//                           .make()
//                           .onTap(() {
//                         Get.to(() => const ItemDetails(title: 'Dummy item'));
//                       });
//                     })))
//           ],
//         ),
//       ),

import 'package:emart_app/consts/colors.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
