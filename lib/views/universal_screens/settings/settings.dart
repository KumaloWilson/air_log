import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../helpers/shared_preferances_helper.dart';
import '../authorization_screens/auth_handler.dart';
import 'widget/notification_screen.dart';
import 'widget/privacy_policy_screen.dart';
import 'widget/security_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  Color primaryColor = Color(0xFF0693ea);
  final _auth = FirebaseAuth.instance;

   Future<void> switchRoless() async {
    await _auth.signOut();
    await SharedPreferencesHelper.clearCachedUserRole();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthHandler()));

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
          'Settings',
          style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                child: ListView(
                  children: [

                    Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.grey.shade100,
                      child: Row(
                        children: [
                          Text(
                            'General',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    profileButtonWidget(
                      context,
                      title: "Language",
                      subtitle: "English (US)",
                    ),

                    profileButtonWidget(
                        context,
                        title: "Notification Settings",
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c)=> ChangeNotificationScreen()))
                    ),

                    profileButtonWidget(
                        context,
                        title: "Location",
                    ),

                    Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.grey.shade100,
                      child: Row(
                        children: [
                          Text(
                            'Account & Security',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    profileButtonWidget(
                      context,
                      title: "Email & Mobile Number",
                    ),
                    profileButtonWidget(
                        context,
                        title: "Security Settings",
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c)=> SecurityScreen()))
                    ),

                    profileButtonWidget(
                        context,
                        title: "Delete Account"
                    ),


                    Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.grey.shade100,
                      child: Row(
                        children: [
                          Text(
                            'Other',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    profileButtonWidget(
                        context,
                        title: "Privacy Policy",
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c)=> PrivacyPolicyScreen()))
                    ),
                    profileButtonWidget(
                        context,
                        title: "Help & Support"
                    ),

                    profileButtonWidget(
                        context,
                        title: "Terms and Conditions"
                    ),

                    profileButtonWidget(
                        context,
                        title: "Contact Us"
                    ),
                    profileButtonWidget(
                        context,
                        title: "About",
                    ),

                    Container(
                      padding: EdgeInsets.all(2),
                      color: Colors.grey.shade100,
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: (){
                                switchRoless();
                          },
                              child: Text(
                            'Switch Roles',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              color: Colors.black
                            ),
                          ) )

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileButtonWidget(BuildContext context, {String? title,  String? subtitle,  Color? color,  void Function()? onTap,  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [

                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      title ?? "",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 13,
                          color: color,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      child: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.grey,),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey.shade200,
            ),
          )
        ],
      ),
    );
  }
}
