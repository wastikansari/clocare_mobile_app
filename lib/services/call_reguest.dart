import 'package:clocare/screen/widget/show_custom_snackbar.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CallReuest {
  confermationBox(context) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Send Call Request'),
        content: Column(
          children: [
            const Height(10),
            Lottie.asset('asset/svg/callback.json', height: 150),
            const Height(6),
            SmallText(
              text:
                  'Are you sure you want to send a call request? This action will prompt a call from the CloCare team',
              color: Colors.black,
              overFlow: TextOverflow.visible,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
              // errormsg();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
              showCustomSnackBar(
                  title: 'Call Request',
                  "Please wait, you will get a call from us");
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  comingSoon(context, String value, String msg) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(value),
        content: Column(
          children: [
            // const Height(10),
            Lottie.asset('asset/svg/www.json', height: 150),
            // const Height(6),
            SmallText(
              text: msg
                  ,
              color: Colors.black,
              overFlow: TextOverflow.visible,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
              // errormsg();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
              // showCustomSnackBar(
              //     title: 'Call Request',
              //     "Please wait, you will get a call from us");
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }
}
