import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class StepOrderPaymentPage extends StatefulWidget {
  const StepOrderPaymentPage({super.key});

  @override
  State<StepOrderPaymentPage> createState() => _StepOrderPaymentPageState();
}

class _StepOrderPaymentPageState extends State<StepOrderPaymentPage> {
  int? selectedOption;
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormFieldState> _specifyTextFieldKey =
      GlobalKey<FormFieldState>();

  ValueChanged _onChanged = (val) => print(val);
  var genderOptions = ['Male', 'Female', 'Other'];
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 35, left: 15, right: 15),
      child: Column(
        children: [
          const Height(30),
          Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.boxColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 2),
                // color: const Color(0xFFF9F8FF),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.boxShadowColor,
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0.0, 0.0),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SmallText(
                      text: 'SELECT PAY ON',
                      color: const Color.fromARGB(255, 155, 162, 207),
                      fontweights: FontWeight.w500,
                    ),
                  ),
                  const Height(10),
                  ListTile(
                    title: SmallText(
                      text: 'Pay on Pickup',
                      size: 14,
                    ),
                    leading: Radio(
                      value: 1,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                        print('pay $selectedOption and $value');
                        setState(() {
                          selectedOption = value!;
                        });

                        print('pay $selectedOption and $value');
                      },
                    ),
                  ),
                  ListTile(
                    title: SmallText(
                      text: 'Pay on Delivery',
                      size: 14,
                    ),
                    leading: Radio(
                      value: 2,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                        print('pay $selectedOption and $value');
                      },
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
