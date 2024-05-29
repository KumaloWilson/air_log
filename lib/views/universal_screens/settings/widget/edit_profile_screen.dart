import 'package:flutter/material.dart';



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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.1,
            padding: EdgeInsets.only(
                left: 8,
                right: 8,
                top: 8
            ),
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
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
              // children: <Widget>[
              //   SingleChildScrollView(
              //     child: Padding(
              //       padding: EdgeInsets.all(8),
              //       child: Column(
              //         children: [
              //           const SizedBox(
              //             height: 8,
              //           ),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Padding(
              //                 padding: EdgeInsets.symmetric(
              //                     vertical: 8),
              //                 child: CustomTextField(
              //                   borderRadius: 20,
              //                   borderColor: Colors.transparent,
              //                   hintText: "FirstName",
              //                   controller: descriptionController,
              //                   fillColor: Theme.of(context)
              //                       .disabledColor
              //                       .withOpacity(0.1),
              //                   // hintStyle: AppStyles.getPaGrillHintStyle(context),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: EdgeInsets.symmetric(
              //                     vertical: 8
              //                 ),
              //                 child: CustomTextField(
              //                   borderRadius: 20,
              //                   borderColor: Colors.transparent,
              //                   hintText: "LastName",
              //                   controller: descriptionController,
              //                   fillColor: Theme.of(context)
              //                       .disabledColor
              //                       .withOpacity(0.1),
              //                   // hintStyle: AppStyles.getPaGrillHintStyle(context),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: EdgeInsets.symmetric(
              //                     vertical: 8
              //                 ),
              //                 child: CustomDatePicker(
              //                   borderRadius: 20,
              //                   borderColor: Colors.transparent,
              //                   hintText: "Date",
              //                   controller: descriptionController,
              //                   fillColor: Theme.of(context)
              //                       .disabledColor
              //                       .withOpacity(0.1),
              //                   // hintStyle: AppStyles.getPaGrillHintStyle(context),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: EdgeInsets.symmetric(
              //                     vertical: 8
              //                 ),
              //                 child: CustomTextField(
              //                   borderRadius: 20,
              //                   borderColor: Colors.transparent,
              //                   hintText: "useremail@flickapay.com",
              //                   controller: descriptionController,
              //                   fillColor: Theme.of(context)
              //                       .disabledColor
              //                       .withOpacity(0.1),
              //                   // hintStyle: AppStyles.getPaGrillHintStyle(context),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: EdgeInsets.symmetric(
              //                     vertical: 8
              //                 ),
              //                 child: CustomTextField(
              //                   borderRadius: 20,
              //                   borderColor: Colors.transparent,
              //                   hintText: "Country",
              //                   controller: descriptionController,
              //                   fillColor: Theme.of(context)
              //                       .disabledColor
              //                       .withOpacity(0.1),
              //                   // hintStyle: AppStyles.getPaGrillHintStyle(context),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: EdgeInsets.symmetric(
              //                     vertical: 8
              //                 ),
              //                 child: CustomTextField(
              //                   borderRadius: 20,
              //                   borderColor: Colors.transparent,
              //                   hintText: "Phone",
              //                   controller: descriptionController,
              //                   fillColor: Theme.of(context)
              //                       .disabledColor
              //                       .withOpacity(0.1),
              //                   // hintStyle: AppStyles.getPaGrillHintStyle(context),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: EdgeInsets.symmetric(
              //                     vertical: 8
              //                 ),
              //                 child: CustomDropdownWidget(
              //                   items: ["water", "rice"],
              //                   selectedValue: 'water',
              //                   onChanged: (value) {
              //                     setState(() {
              //                       country = value ?? "";
              //                     });
              //                     print("Selected value: $value");
              //                   },
              //                 ),
              //               ),
              //               Padding(
              //                 padding: EdgeInsets.symmetric(
              //                     vertical: 8
              //                 ),
              //                 child: CustomDropdownWidget(
              //                   items: ["male", "female"],
              //                   selectedValue: 'male',
              //                   onChanged: (value) {
              //                     setState(() {
              //                       country = value ?? "";
              //                     });
              //                     print("Selected value: $value");
              //                   },
              //                 ),
              //               ),
              //               Padding(
              //                 padding: EdgeInsets.symmetric(
              //                     vertical: 8
              //                 ),
              //                 child: CustomTextField(
              //                   borderRadius: 20,
              //                   borderColor: Colors.transparent,
              //                   hintText: "Address",
              //                   controller: descriptionController,
              //                   fillColor: Theme.of(context)
              //                       .disabledColor
              //                       .withOpacity(0.1),
              //                   // hintStyle: AppStyles.getPaGrillHintStyle(context),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),

        ],
      ),
    );
  }
}
