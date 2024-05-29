import 'package:air_log/helpers/helpers/genenal_helpers.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_switch.dart';

class ChangeNotificationScreen extends StatefulWidget {
  const ChangeNotificationScreen({super.key});

  @override
  State<ChangeNotificationScreen> createState() =>
      _ChangeNotificationScreenState();
}

class _ChangeNotificationScreenState extends State<ChangeNotificationScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  bool generalNotifications = false;
  bool sound = false;
  bool vibrate = false;
  String country = "";
  bool appupdates = false;
  bool billreminder = false;
  bool promotion = false;
  bool disscountAvailable = false;
  bool paymentRequest = false;
  bool newService = false;
  bool newTips = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            height: height * 0.1,
            padding: EdgeInsets.all(8),
            width: width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Helpers.back(context),
                      child: Icon(
                        Icons.arrow_back,
                        size: 24,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Notifications",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "General Notifications",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.bold),
                                  ),
                                  CustomSwitch(
                                    value: generalNotifications,
                                    onChanged: (value) {
                                      setState(() {
                                        generalNotifications = value;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    backgroundColor:
                                        Theme.of(context).disabledColor,
                                    width: 40.0,
                                    height: 25.0,
                                    padding: EdgeInsets.all(
                                        4
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sound",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.bold),
                                  ),
                                  CustomSwitch(
                                    value: sound,
                                    onChanged: (value) {
                                      setState(() {
                                        sound = value;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    backgroundColor:
                                        Theme.of(context).disabledColor,
                                    width: 40.0,
                                    height: 25.0,
                                    padding: EdgeInsets.all(4),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Vibrate",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.bold),
                                  ),
                                  CustomSwitch(
                                    value: generalNotifications,
                                    onChanged: (value) {
                                      setState(() {
                                        generalNotifications = value;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    backgroundColor:
                                        Theme.of(context).disabledColor,
                                    width: 40.0,
                                    height: 25.0,
                                    padding: EdgeInsets.all(4),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "App Updates",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.bold),
                                  ),
                                  CustomSwitch(
                                    value: generalNotifications,
                                    onChanged: (value) {
                                      setState(() {
                                        generalNotifications = value;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    backgroundColor:
                                        Theme.of(context).disabledColor,
                                    width: 40.0,
                                    height: 25.0,
                                    padding: EdgeInsets.all(
                                        4
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Bill Reminder",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.bold),
                                  ),
                                  CustomSwitch(
                                    value: generalNotifications,
                                    onChanged: (value) {
                                      setState(() {
                                        generalNotifications = value;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    backgroundColor:
                                        Theme.of(context).disabledColor,
                                    width: 40.0,
                                    height: 25.0,
                                    padding: EdgeInsets.all(4),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Promotion",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.bold),
                                  ),
                                  CustomSwitch(
                                    value: generalNotifications,
                                    onChanged: (value) {
                                      setState(() {
                                        generalNotifications = value;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    backgroundColor:
                                        Theme.of(context).disabledColor,
                                    width: 40.0,
                                    height: 25.0,
                                    padding: EdgeInsets.all(4)
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount Available",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.bold),
                                  ),
                                  CustomSwitch(
                                    value: generalNotifications,
                                    onChanged: (value) {
                                      setState(() {
                                        generalNotifications = value;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    backgroundColor:
                                        Theme.of(context).disabledColor,
                                    width: 40.0,
                                    height: 25.0,
                                    padding: EdgeInsets.all(4),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Payment Request",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.bold),
                                  ),
                                  CustomSwitch(
                                    value: generalNotifications,
                                    onChanged: (value) {
                                      setState(() {
                                        generalNotifications = value;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    backgroundColor:
                                        Theme.of(context).disabledColor,
                                    width: 40.0,
                                    height: 25.0,
                                    padding: EdgeInsets.all(
                                        4
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "New Service Available",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black.withOpacity(0.5),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  CustomSwitch(
                                    value: generalNotifications,
                                    onChanged: (value) {
                                      setState(() {
                                        generalNotifications = value;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    backgroundColor:
                                        Theme.of(context).disabledColor,
                                    width: 40.0,
                                    height: 25.0,
                                    padding: EdgeInsets.all(4),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "New Tips",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black.withOpacity(0.5),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  CustomSwitch(
                                    value: generalNotifications,
                                    onChanged: (value) {
                                      setState(() {
                                        generalNotifications = value;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    backgroundColor:
                                        Theme.of(context).disabledColor,
                                    width: 40.0,
                                    height: 25.0,
                                    padding: EdgeInsets.all(4),
                                  ),
                                ],
                              ),
                            ),
                            
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Center(
            child: CustomButton(
              width: width * 0.9,
              height: 50.0,
              child: Text(
                  'Update'
              ),
              btnColor: Theme.of(context).primaryColor,
              borderRadius: 100,
              onTap: ()=>(),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
