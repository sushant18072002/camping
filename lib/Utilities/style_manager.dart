import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_manager.dart';

class StyleManager {
  static FontWeight fontWeight400 = FontWeight.w400;
  static FontWeight fontWeight500 = FontWeight.w500;
  static FontWeight fontWeight600 = FontWeight.w600;
  static String fontFamily = 'SF Pro Text';
  
  static fontFamilyCustum(styletext){
    return GoogleFonts.roboto(textStyle: styletext);
  }

  static TextStyle textweight600size20black() {
    return  fontFamilyCustum(TextStyle(
            color: ColorManager.black,
            fontWeight: fontWeight600,
            fontSize: 20));
  }
  static TextStyle textweight600size20white() {
    return  fontFamilyCustum(TextStyle(
        color: ColorManager.white,
        fontWeight: fontWeight600,
        fontSize: 20));
  }
  static TextStyle textweight600size20Color(Color color) {
    return  fontFamilyCustum(TextStyle(
        color: color,
        fontWeight: fontWeight600,
        fontSize: 20));
  }
  static TextStyle textweight600size24color(Color color) {
    return  fontFamilyCustum(TextStyle(
        color: color,
        fontWeight: fontWeight600,
        fontSize: 20));
  }
  static TextStyle textweight600size24black() {
    return  fontFamilyCustum(TextStyle(
        color: ColorManager.black,
        fontWeight: fontWeight600,
        fontSize: 20));
  }


  static TextStyle textweight400size14black() {
    return fontFamilyCustum(TextStyle(
            color: ColorManager.black,
            fontWeight: fontWeight400,
            fontSize: 14));
  }
  static TextStyle textweight400size13black() {
    return fontFamilyCustum(TextStyle(
        color: ColorManager.black,
        fontWeight: fontWeight400,
        fontSize: 13));
  }

  static TextStyle textweight400size20black() {
    return fontFamilyCustum(TextStyle(
            color: ColorManager.black,
            fontWeight: fontWeight400,
            fontSize: 20));
  }

  static TextStyle textweight400size20white() {
    return fontFamilyCustum(TextStyle(
            color: ColorManager.white,
            fontWeight: fontWeight400,
            fontSize: 20));
  }
  static TextStyle textweight400size20color(Color color) {
    return fontFamilyCustum(TextStyle(
        color: color,
        fontWeight: fontWeight400,
        fontSize: 20));
  }


  static TextStyle textweight600size32white() {
    return fontFamilyCustum(TextStyle(
            color: ColorManager.white,
            fontWeight: fontWeight600,
            fontSize: 32));
  }

  static TextStyle textWeight400Size12black() {
    return fontFamilyCustum(TextStyle(
            color: ColorManager.black,
            fontWeight: fontWeight400,
            fontSize: 12));
  }
  static TextStyle textWeight400Size12color(Color color) {
    return fontFamilyCustum(TextStyle(
        color: color,
        fontWeight: fontWeight400,
        fontSize: 12));
  }
  static TextStyle textWeight400Size16White() {
    return fontFamilyCustum(TextStyle(
            color: ColorManager.white,
            fontWeight: fontWeight400,
            fontSize: 16));
  }

  static TextStyle textWeight400Size14White() {
    return fontFamilyCustum(TextStyle(
            color: ColorManager.white,
            fontWeight: fontWeight400,
            fontSize: 14));
  }
  static TextStyle textWeight400Size14color(Color color) {
    return fontFamilyCustum(TextStyle(
        color: color,
        fontWeight: fontWeight400,
        fontSize: 14));
  }
  static TextStyle textWeight500Size14color(Color color) {
    return fontFamilyCustum(TextStyle(
        color: color,
        fontWeight: fontWeight400,
        fontSize: 14));
  }
  static TextStyle textWeight400Size16color(Color color) {
    return fontFamilyCustum(TextStyle(
        color: color,
        fontWeight: fontWeight400,
        fontSize: 16));
  }
  static TextStyle textWeight500Size14White() {
    return fontFamilyCustum(TextStyle(
            color: ColorManager.white,
            fontWeight: fontWeight400,
            fontSize: 14));
  }

  static TextStyle textWeight600Size24color(Color color) {
    return GoogleFonts.lato(
        textStyle:
            TextStyle(color: color, fontWeight: fontWeight600, fontSize: 24));
  }
  static TextStyle textWeight400Size24color(Color color) {
    return GoogleFonts.lato(
        textStyle:
        TextStyle(color: color, fontWeight: fontWeight600, fontSize: 24));
  }
  static TextStyle textWeight600Size20color(Color color) {
    return GoogleFonts.lato(
        textStyle:
        TextStyle(color: color, fontWeight: fontWeight600, fontSize: 20));
  }

  static TextStyle textWeight400Size14Color(Color color) {
    return GoogleFonts.lato(
        textStyle:
            TextStyle(color: color, fontWeight: fontWeight400, fontSize: 14));
  }

  static TextStyle textWeight400Size16Color(Color color) {
    return GoogleFonts.lato(
        textStyle:
            TextStyle(color: color, fontWeight: fontWeight400, fontSize: 16),);
  }

  static TextStyle textWeight600Size32Color(Color color) {
    return GoogleFonts.lato(
        textStyle:
            TextStyle(color: color, fontWeight: fontWeight600, fontSize: 32));
  }

  static TextStyle textWeight500Size16White() {
    return fontFamilyCustum(TextStyle(
            color: ColorManager.white,
            fontWeight: fontWeight500,
            fontSize: 16));
  }

  static TextStyle textWeight500Size14black() {
    return fontFamilyCustum(TextStyle(
      fontWeight: fontWeight500,
      fontSize: 14,
    ));
  }

  static TextStyle textWeight500Size14Color(Color color) {
    return fontFamilyCustum(TextStyle(
      fontWeight: fontWeight500,
      color: color,
      fontSize: 14,
    ));
  }

  static TextStyle textWeight400Size16black() {
    return fontFamilyCustum(TextStyle(
            fontWeight: fontWeight400,
            fontSize: 16,
            color: ColorManager.black,
    ));
  }
  static TextStyle textWeight600Size17black() {
    return fontFamilyCustum(TextStyle(
      fontWeight: fontWeight600,
      fontSize: 17,
    ));
  }
  static TextStyle textWeight400Size17color(Color color) {
    return fontFamilyCustum(TextStyle(
      fontWeight: fontWeight400,
      fontSize: 17,
      color: color,
    ));
  }
  static TextStyle textWeight400Size13color(Color color) {
    return fontFamilyCustum(TextStyle(
      fontWeight: fontWeight400,
      fontSize: 13,
      color:color,
    ));
  }
}
