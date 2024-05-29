import 'package:flutter/material.dart';

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

  Color primaryColor = Color(0xFF0693ea);
  final TextEditingController amountController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  bool activityGeneralNotifications = false;
  bool activityEmailActive= false;

  bool forYouGeneralNotifications = false;
  bool forYouEmailActive= true;

  bool reminderGeneralNotifications = true;
  bool reminderEmailActive= false;


  bool membershipGeneralNotifications = true;
  bool membershipEmailActive= false;


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
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          'Notification Settings',
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
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Push Notification Disabled',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'To enable notifications, go to',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),

                      TextSpan(
                        text: ' Settings',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ]
                  ),
                ),

                SizedBox(
                  height: 8,
                ),

              ],
            ),
          ),

          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 25,
            color: Colors.grey.shade100,
          ),

          SettingTile(
            context,
            title: 'Activity',
            subtitle: 'Secure your account by keeping your log in, register, and OTP activity on track',
            email: activityEmailActive,
            notification: activityGeneralNotifications,
          ),

          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 25,
            color: Colors.grey.shade100,
          ),

          SettingTile(
            context,
            title: 'Special For You',
            subtitle: 'You can never have too much of limited-time discount, '
                'exclusive offers, tips and into new feature.',
            email: forYouEmailActive,
            notification: forYouGeneralNotifications,
          ),

          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 25,
            color: Colors.grey.shade100,
          ),

          SettingTile(
            context,
            title: 'Reminders',
            subtitle: 'Get important travel news and info, payment reminders,'
                ' check-in reminders, and more.',
            email: reminderEmailActive,
            notification: reminderGeneralNotifications,
          ),

          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 25,
            color: Colors.grey.shade100,
          ),

          SettingTile(
            context,
            title: 'Membership',
            subtitle: "You'll get emails about Rewards and surveys",
            email: membershipEmailActive,
            notification: membershipGeneralNotifications,
          ),



        ],
      ),
    );
  }

  Widget SettingTile(BuildContext context, {String? title, String? subtitle, bool? email, bool? notification}){
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
      
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),

          SizedBox(
            height: 8,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Email',
                style: TextStyle(
                  color: Colors.grey.shade700
                ),
              ),
              CustomSwitch(
                value: notification!,
                onChanged: (value) {
                  setState(() {
                    notification = value;
                  });
                },
                activeColor: Theme.of(context).primaryColor,
                backgroundColor:
                Theme.of(context).disabledColor,
                width: 40.0,
                height: 22.0,
                padding: EdgeInsets.all(
                    4
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Push Notification',
                style: TextStyle(
                    color: Colors.grey.shade700
                ),
              ),
              CustomSwitch(
                value: notification!,
                onChanged: (value) {
                  setState(() {
                    notification = value;
                  });
                },
                activeColor: Theme.of(context).primaryColor,
                backgroundColor:
                Theme.of(context).disabledColor,
                width: 40.0,
                height: 22.0,
                padding: EdgeInsets.all(
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
