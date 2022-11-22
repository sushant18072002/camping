import 'package:flutter/material.dart';
import 'package:task2/Model/BagItemModel.dart';

import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/screen/prepare_your_bag.dart';

class CustumCheckbox extends StatefulWidget {
  BagItemModel? bagItemModel;

  CustumCheckbox({this.bagItemModel});

  @override
  State<CustumCheckbox> createState() => _CustumCheckbox();
}

class _CustumCheckbox extends State<CustumCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return ColorManager.green84CC16;
    }

    return Transform.scale(
      scale: 1.2,
      child: Checkbox(
        activeColor: ColorManager.color94A3B8,
        checkColor: ColorManager.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        side: MaterialStateBorderSide.resolveWith(
          (states) => BorderSide(
            width: 1.1,
            color: ColorManager.color94A3B8,
            style: BorderStyle.solid,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.5)),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            if(value!=null) {
              isChecked = value;
              if (widget.bagItemModel?.isCheck != null)
                widget.bagItemModel!.isCheckSet = value;
            }
          });
        },
      ),
    );
  }
}
