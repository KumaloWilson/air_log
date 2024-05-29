import 'package:air_log/api_services/auth_methods/authorization_services.dart';
import 'package:air_log/helpers/helpers/genenal_helpers.dart';
import 'package:air_log/utils/asset_utils/network_image_assets.dart';
import 'package:air_log/views/universal_screens/profile/widget/edit_profile_screen.dart';
import 'package:air_log/views/universal_screens/profile/widget/notification_screen.dart';
import 'package:air_log/views/universal_screens/profile/widget/security_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        padding: EdgeInsets.all(16),
        width: screenWidth,
        height: screenHeight,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          padding:
                              const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 100,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius:
                                BorderRadius.circular(10),
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Profile",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(
                              8,
                            )),
                        child: const Icon(Icons.more_horiz_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.12,
                      backgroundImage: NetworkImage(
                          MyNetworkImageAssets.defaultProfilePic
                      ),
                    ),
                    Text(
                      user!.displayName!,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        user.email!,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 0.1,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      profileButtonWidget(
                        context,
                        icon: Icons.person_outline,
                        title: "Edit Profile",onTap: ()=>Helpers.temporaryNavigator(context, const EditProfileScreen())
                      ),
                      profileButtonWidget(context,
                          icon: Icons.notifications_outlined,
                          title: "Notifications",onTap: ()=>Helpers.temporaryNavigator(context, const ChangeNotificationScreen())
                      ),
                      profileButtonWidget(
                        context,
                        icon: Icons.person_outline,
                        title: "Language",
                        subtitle: "English (US)",
                      ),
                      profileButtonWidget(context,
                          icon: Icons.shield_outlined, title: "Security",onTap: ()=>Helpers.temporaryNavigator(context, const SecurityScreen())
                      ),
                      profileButtonWidget(context,
                          icon: Icons.lock_outline, title: "Privacy Policy",onTap: ()=>()),
                      profileButtonWidget(context,
                          icon: Icons.info_outline, title: "Help & Support"),
                      profileButtonWidget(context,
                          icon: Icons.chat_outlined, title: "Contact Us"),
                      profileButtonWidget(context,
                          icon: Icons.logout,
                          title: "Logout",
                          color: Colors.red,
                        onTap: ()=> AuthServices.signOut()
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileButtonWidget(
    BuildContext context, {
    IconData? icon,
    String? title,
    String? subtitle,
    Color? color,
    void Function()? onTap,
  }) {


    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;


    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth,
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  child: Icon(icon, color: color),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  title ?? "",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 12,
                      color: color,
                      fontWeight: FontWeight.w500),
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
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
