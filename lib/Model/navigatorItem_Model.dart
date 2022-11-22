import 'package:flutter/material.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/style_manager.dart';

class NavigatorItemModel {
  final Text title;
  final ImageIcon icon;

  NavigatorItemModel(this.title, this.icon);

  static List<NavigatorItemModel> getItems() {
    return <NavigatorItemModel>[
      NavigatorItemModel(
        Text(
          'Activities',
          style:
          StyleManager.textWeight500Size14Color(ColorManager.colorECFCCB),
        ),
        ImageIcon(
          AssetImage(
            "assets/icons/file-text.png",
          ),
          size: 24,
          color: ColorManager.colorECFCCB,
        ),
      ),
      NavigatorItemModel(
          Text(
            'Fitness',
            style:
            StyleManager.textWeight500Size14Color(ColorManager.colorECFCCB),
          ),
          ImageIcon(
            AssetImage(
              "assets/icons/heart.png",
            ),
            size: 24,
            color: ColorManager.colorECFCCB,
          )),
      NavigatorItemModel(
          Text(
            'Trips',
            style:
            StyleManager.textWeight500Size14Color(ColorManager.colorECFCCB),
          ),
          ImageIcon(
            AssetImage(
              "assets/icons/briefcase.png",
            ),
            size: 24,
            color: ColorManager.colorECFCCB,
          )),
      NavigatorItemModel(
          Text('Teammates',
              style: StyleManager.textWeight500Size14Color(
                  ColorManager.colorECFCCB)),
          ImageIcon(
            AssetImage(
              "assets/icons/people.png",
            ),
            size: 24,
            color: ColorManager.colorECFCCB,
          ))
    ];
  }

}