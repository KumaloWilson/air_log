
import 'package:flutter/material.dart';

import '../../../widgets/custom_switch.dart';



class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  Color primaryColor = const Color(0xFF0693ea);
  final TextEditingController amountController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  bool activityGeneralNotifications = false;
  bool forYouGeneralNotifications = false;
  bool reminderGeneralNotifications = true;
  bool membershipGeneralNotifications = true;


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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text(
          'Security Settings',
          style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: ListView(
        children: [

          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: const Row(
              children: [
                Text(
                  'Credit Card',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),

          SettingTile(
              context,
              title: 'Double Verification',
              subtitle: 'Enter CVV & OTP code for more secure payment verification',
              selectOption: activityGeneralNotifications,
              radioButtonWidth: 22.0
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: Colors.grey.shade300,
            ),
          ),
          SettingTile(
              context,
              title: 'Single Verification',
              subtitle: 'Enter only CVV code for a swift and hassle free payment verification',
              selectOption: !activityGeneralNotifications,
              radioButtonWidth: 22.0
          ),

          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: const Row(
              children: [
                Text(
                  'Biometric',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),

          SettingTile(
            context,
            title: 'Activate Biometric Feature',
            subtitle: 'To enjoy a seamless log in with fingerprint or '
                'face recognition',
            selectOption: forYouGeneralNotifications,
          ),

          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: const Row(
              children: [
                Text(
                  'Device',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),

          SettingTile(
            context,
            title: 'Set Device as Trusted',
            subtitle: 'Activate to set a PIN and Manage device connectivity',
            selectOption: reminderGeneralNotifications,
          ),

          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: const Row(
              children: [
                Text(
                  'Pin',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),

          SettingTile(
            context,
            title: 'Set PIN',
            subtitle: "Set a 6 digit verification PIN to secure your account activities",
            selectOption: membershipGeneralNotifications,
          ),



        ],
      ),
    );
  }

  Widget SettingTile(BuildContext context, {String? title, String? subtitle, bool? selectOption, double? radioButtonWidth}){
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.75,
                child: Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              CustomSwitch(
                value: selectOption!,
                onChanged: (value) {
                  setState(() {
                    selectOption = value;
                  });
                },
                activeColor: Theme.of(context).primaryColor,
                backgroundColor:
                Theme.of(context).disabledColor,
                width: radioButtonWidth ?? 40.0,
                height: 22.0,
                padding: const EdgeInsets.all(
                    4
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
