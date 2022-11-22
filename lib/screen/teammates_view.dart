import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/Model/UserModel.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';

import '../Utilities/color_manager.dart';

class TeammateView extends StatelessWidget {
  UserModel usermodel;

  TeammateView({required this.usermodel});

  static Row ratingIcon(int rating) {
    List<Image> imageList = [];
    for (int i = 0; i < rating; i++) {
      imageList.add(Image.asset(
        "assets/icons/awardLight.png",
        width: 24,
        height: 24,
      ));
    }
    return Row(
      children: imageList.map((item) {
        return Padding(
          padding: DimensionManager.onlyright(8.0),
          child: item,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtilies.appbarUtil("Teammate"),
      backgroundColor: ColorManager.white,
      body: Container(
        padding: DimensionManager.fromLTRB(20, 5, 20),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: imageProvider(usermodel.image.toString()),
            ),
            Padding(
              padding: DimensionManager.topAndBottom(24, 8),
              child: Text(
                usermodel.name.toString(),
                style: StyleManager.textweight600size20black(),
              ),
            ),
            Text(
              "Chef",
              style: StyleManager.textWeight500Size14Color(
                  ColorManager.colorA1A1AA),
            ),
            Padding(
              padding: DimensionManager.topAndBottom(8, 24),
              child: ratingIcon(5),
            ),
            Text(
              "Description",
              style: StyleManager.textweight600size20black(),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              usermodel.description.toString().length<1?"No Descreption set yet":usermodel.description.toString(),
              style: StyleManager.textWeight400Size16color(
                  ColorManager.color3F3F46),
            )
          ],
        ),
      ),
    );
  }

  static Widget imageProvider(String imageUrl) {
    if (imageUrl.length < 10 || imageUrl.isEmpty) {
      return Image.asset(
        "assets/images/Avatarrectangle.png",
        fit: BoxFit.cover,
        height: DimensionManager.divH(335),
        width: DimensionManager.divW(335),
      );
    } else
      return Image.network(
        imageUrl,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            height: DimensionManager.divH(335),
            width: DimensionManager.divW(335),
            child: Shimmer.fromColors(
              child: Card(
                color: Colors.grey,
              ),
              baseColor: Colors.white70,
              highlightColor: ColorManager.colorA1A1AA,
              direction: ShimmerDirection.ltr,
            ),
          );
        },
        fit: BoxFit.cover,
        height: DimensionManager.divH(335),
        width: DimensionManager.divW(335),
      );
  }
}
