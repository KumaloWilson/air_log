
import 'package:air_log/helpers/helpers/genenal_helpers.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String country = "";

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

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;


    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.1,
            padding: const EdgeInsets.all(8),
            width: screenWidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Helpers.back(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24,
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
                          "Edit Profile",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                  color: Colors.black,
                                  fontSize: 8,
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
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16
                              ),
                              child: CustomTextField(
                                labelText: "FirstName",
                                controller: descriptionController,
                                prefixIcon: const Icon(
                                  Icons.person
                                ),
                                fillColor: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.1),
                                // hintStyle: AppStyles.getPaGrillHintStyle(context),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8
                              ),
                              child: CustomTextField(
                                prefixIcon: const Icon(
                                  Icons.person
                                ),
                                labelText: "LastName",
                                controller: descriptionController,
                                fillColor: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.1),
                                // hintStyle: AppStyles.getPaGrillHintStyle(context),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8
                              ),
                              child: CustomTextField(
                                labelText: "useremail@flickapay.com",
                                controller: descriptionController,
                                fillColor: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.1),
                                prefixIcon: const Icon(
                                  Icons.email
                                ),
                                // hintStyle: AppStyles.getPaGrillHintStyle(context),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8
                              ),
                              child: CustomTextField(
                                prefixIcon: const Icon(
                                  Icons.flag
                                ),
                                labelText: "Country",
                                controller: descriptionController,
                                fillColor: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.1),
                                // hintStyle: AppStyles.getPaGrillHintStyle(context),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8
                              ),
                              child: CustomTextField(
                                prefixIcon: const Icon(
                                  Icons.phone_android
                                ),
                                labelText: "Phone",
                                controller: descriptionController,
                                fillColor: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.1),
                                // hintStyle: AppStyles.getPaGrillHintStyle(context),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8
                              ),
                              child: CustomTextField(
                                prefixIcon: const Icon(
                                  Icons.person
                                ),
                                labelText: "Address",
                                controller: descriptionController,
                                fillColor: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.1),
                                // hintStyle: AppStyles.getPaGrillHintStyle(context),
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
              width: screenWidth * 0.9,
              height: 50.0,
              child: const Text(
                  'Update'
              ),
              btnColor: Theme.of(context).primaryColor,
              borderRadius: 100,
              onTap: () {  },
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
