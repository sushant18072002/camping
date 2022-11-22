import 'package:flutter/material.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/screen/Login/login.dart';
import 'package:task2/screen/sign_up.dart';

class ResgistorSuccessfull extends StatelessWidget {
  const ResgistorSuccessfull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Column(
        children: [
          Container(
            height: DimensionManager.divH(180),
            margin:DimensionManager.fromLTRB(70,230,70,24),
            //EdgeInsets.fromLTRB(divW(70), divH(230), divW(70), divH(24)),
            child: Image.asset("assets/images/hurrey.png"),
          ),
          Text(
            "Hurrey",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,

            ),
          ),
          Padding(
            padding: DimensionManager.fromLTRB(20,8,20,24),
            //EdgeInsets.fromLTRB(divW(20), divH(8), divW(20), divH(24)),
            child: Text(
              "Your registration is successful. please go \n back and log-in.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: Color(0xff3F3F46),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: DimensionManager.fromLTRB(40,0,40),
            //EdgeInsets.fromLTRB(divW(40), divH(0), divH(40), 0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),), (route) => false);
              },
              child: Center(
                child: Text(
                  "Go Back",
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff84CC16),
                  minimumSize: Size.fromHeight(DimensionManager.divH(44)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                //fixedSize: Size(double.infinity, height/18.75)
              ),
            ),
          ),
        ],
      ),
    );
  }
}

