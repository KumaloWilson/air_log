import 'package:flutter/material.dart';

import '../../utils/asset_utils/image_assets.dart';

class MyLogo extends StatelessWidget {
  const MyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Colors.grey
          )
      ),
      child: Image.asset(
        MyImageLocalAssets.logo,
      ),
    );
  }
}
