import 'package:air_log/utils/asset_utils/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../../../providers/user_provider.dart';
import '../../../api_services/auth_methods/authorization_services.dart';
import '../../../constant/colors.dart';
import '../../../helpers/helpers/genenal_helpers.dart';
import '../../widgets/personal_info_tile.dart';

class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MyImageLocalAssets.bannerImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(userProvider.user != null
                        ? (userProvider.user!.photoURL ??
                            'https://cdn-icons-png.flaticon.com/128/3177/3177440.png')
                        : 'https://cdn-icons-png.flaticon.com/128/3177/3177440.png'),
                  ),
                ),
                title: Text(userProvider.user!.displayName ?? '',
                    style: TextStyle(
                        color: Pallete.darkPrimaryTextColor,
                        fontWeight: FontWeight.bold)),
                subtitle: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Pallete.darkPrimaryTextColor, fontSize: 10),
                      children: [
                        TextSpan(text: "${userProvider.user!.email}\n"),
                      ]),
                ),
                trailing: GestureDetector(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Pallete.primaryColor.withBlue(200)),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                'Personalize',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              PersonalTile(
                onTap: () => (),
                icon: FontAwesomeIcons.shield,
                title: 'Security and Privacy',
              ),

              PersonalTile(
                onTap: () => (),
                icon: FontAwesomeIcons.gear,
                title: 'Settings',
              ),
              PersonalTile(
                onTap: () => (),
                icon: FontAwesomeIcons.wallet,
                title: 'Payment Methods',
              ),
              PersonalTile(
                onTap: () => (),
                icon: FontAwesomeIcons.clockRotateLeft,
                title: 'History',
              ),
              PersonalTile(
                onTap: () => (),
                icon: FontAwesomeIcons.paintRoller,
                title: 'Theme',
              ),
              PersonalTile(
                onTap: () => (),
                icon: FontAwesomeIcons.users,
                title: 'Invite a friend',
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Support',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              PersonalTile(
                onTap: () => (),
                icon: FontAwesomeIcons.globe,
                title: 'FAQs',
              ),
              PersonalTile(
                onTap: () => (),
                icon: FontAwesomeIcons.globe,
                title: 'Help Center',
              ),
              PersonalTile(
                onTap: () => (),
                icon: FontAwesomeIcons.phone,
                title: 'Contact Us',
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Legal',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              PersonalTile(
                onTap: () => (),
                icon: FontAwesomeIcons.lock,
                title: 'Terms of Use',
              ),
              PersonalTile(
                onTap: () => (),
                icon: FontAwesomeIcons.lock,
                title: 'Privacy Policy',
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Other',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              PersonalTile(
                onTap: () => (),
                icon: FontAwesomeIcons.upload,
                title: 'Check for Updates',
              ),
              PersonalTile(
                onTap: () => (),
                icon: FontAwesomeIcons.arrowRotateLeft,
                title: 'Switch Role',
              ),
              PersonalTile(
                onTap: () => AuthServices.signOut(),
                icon: FontAwesomeIcons.arrowRightFromBracket,
                title: 'SignOut',
              ),
            ],
          ),
        ),
      );
    });
  }
}
