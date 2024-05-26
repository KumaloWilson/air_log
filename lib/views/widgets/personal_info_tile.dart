import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class PersonalTile extends StatelessWidget {
  const PersonalTile({super.key, required this.onTap, required this.icon, required this.title});
  final void Function() onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.withOpacity(0.6)
          )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Pallete.primaryColor,
              size: 20,
            ),

            SizedBox(
              width: 16,
            ),

            Text(
              title,
              style: TextStyle(
                  color: Pallete.lightPrimaryTextColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}
