import 'package:flutter/material.dart';
import 'package:task2/Model/BagItemModel.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/screen/prepare_your_bag.dart';

class Counter extends StatefulWidget {
  BagItemModel? bagItemModel;
  Counter({this.bagItemModel});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0.4,
              blurRadius: 12, // changes position of shadow
            ),
          ]),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                count -= 1;
                widget.bagItemModel!.countSet=count;
              });
            },
            style: ElevatedButton.styleFrom(
              padding:const EdgeInsets.all(0),
              alignment: Alignment.center,
              primary: ColorManager.white,
              shadowColor: ColorManager.black,
              shape: const CircleBorder(),
            ),
            child: Text(
              "-",
              style: StyleManager.textWeight400Size17color(ColorManager.black),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            count.toString(),
            style: StyleManager.textWeight400Size14color(ColorManager.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Container(
            height: 24,
            width: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0.4,
                blurRadius: 12, // changes position of shadow
              ),
            ]),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  count += 1;
                  widget.bagItemModel!.countSet=count;
                });
              },
              style: ElevatedButton.styleFrom(
                padding:const EdgeInsets.all(0),
                alignment: Alignment.center,
                primary: ColorManager.white,
                shadowColor: ColorManager.black,
                shape: const CircleBorder(),
              ),
              child: Text(
                "+",
                style:
                    StyleManager.textWeight500Size14Color(ColorManager.black),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget roundButton(String sign) {
    return Container(
      height: 24,
      width: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 0.4,
          blurRadius: 12, // changes position of shadow
        ),
      ]),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            sign == '+' ? count + 1 : count -= 1;
          });
        },
        style: ElevatedButton.styleFrom(
          padding:const EdgeInsets.all(0),
          alignment: Alignment.center,
          primary: ColorManager.white,
          shadowColor: ColorManager.black,
          shape: const CircleBorder(),
        ),
        child: Text(
          sign,
          style: StyleManager.textWeight400Size12black(),
        ),
      ),
    );
  }
}
