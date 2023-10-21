// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:new_clocare_delivery_boy/utiles/themes/ColorConstants.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final bool? isLoding;
  final GestureTapCallback onPressed;
  final Color? backgroundColor;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoding = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Shader textGradient = LinearGradient(
    //   colors: <Color>[textColor[0], textColor[1]],
    // ).createShader(
    //   const Rect.fromLTWH(
    //     0.0,
    //     0.0,
    //     200.0,
    //     70.0,
    //   ),
    // );
    var size = MediaQuery.of(context).size;

    return

        // Container(
        //   width: double.infinity,
        //   height: 70,
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: ElevatedButton(
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: backgroundColor ?? AppColor.primaryColor1,
        //         elevation: 3, // Adjust the elevation value as per your preference
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(13),
        //         ),
        //       ),
        //       onPressed: onPressed,
        //       child: Align(
        //           child: isLoding!
        //               ? const CircularProgressIndicator(

        //                   backgroundColor: Colors.white,
        //                 )
        //               : Text(
        //                   text,
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                     // foreground: Paint()..shader,
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: size.height * 0.02,
        //                   ),
        //                 )),
        //     ),
        //   ),
        // );

        SizedBox(
      height: size.height * 0.07,
      width: double.infinity,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color:
                backgroundColor ?? AppColor.primaryColor2, //Color(0xFF57B1E3),
            borderRadius: BorderRadius.circular(13.0),

            gradient: const LinearGradient(
              stops: [0.2, 3],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color(0xFF57B1E3),
                Color(0xFF174FA2),
              ],
            ),
          ),
          child: Align(
              child: isLoding!
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
                        size: 35,
                      ),
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        // foreground: Paint()..shader,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.02,
                      ),
                    )),
        ),
      ),
    );
  }
}

class ButtonWidget2 extends StatelessWidget {
  final String text;
  final bool? isLoding;
  final GestureTapCallback onPressed;
  final Color? backgroundColor;

  const ButtonWidget2({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoding = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.07,
      width: double.infinity,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: AppColor.primaryColor2,
              width: 2,
            ),
            // color: AppColor.primaryColor1, //Color(0xFF57B1E3),
            borderRadius: BorderRadius.circular(13.0),
            // gradient: const LinearGradient(
            //   stops: [0.2, 3],
            //   begin: Alignment.centerRight,
            //   end: Alignment.centerLeft,
            //   colors: [
            //     Color(0xFF57B1E3),
            //     Color(0xFF174FA2),
            //   ],
            // ),
          ),
          child: Align(
              child: isLoding!
                  ? const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        color: AppColor.primaryColor2,
                        // foreground: Paint()..shader,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.02,
                      ),
                    )),
        ),
      ),
    );
  }
}
