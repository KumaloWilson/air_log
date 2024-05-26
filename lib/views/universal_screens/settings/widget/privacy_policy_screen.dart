

import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen>
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Privacy Policy",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '1. Information We Collect\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'We may collect the following types of information when you use our Mobile Banking App:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\na. Personal Information:\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        '\nFull name\nDate of birth\nGender\nContact information (email address, phone number, address)\nIdentification details (passport, national ID, etc.)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nb. Financial Information:\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'Account details\nTransaction history\nAccount balances\nPayment details\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '2. How We Use Your Information\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'We use your personal information for the following purposes:\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\na. Provide and Improve Services:\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'Process transactions and provide banking services\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        'Customize and enhance your experience with the App\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nb. Security and Fraud Prevention:\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'Detect and prevent fraud and unauthorized access\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        'Ensure the security and integrity of our services\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nc. Communication:\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'Send important updates, notifications, and account information\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        'Respond to your inquiries and requests\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),

                                  TextSpan(
                                    text:
                                        '\n\nd. Legal Compliance:\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'Comply with applicable laws, regulations, and legal processes\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\n3. Information Sharing\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'We do not sell or rent your personal information to third parties. However, we may share your information with:\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\na. Service Providers:\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'Third-party service providers that help us deliver and improve our services\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nb. Legal Requirements:\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'To comply with legal obligations, court orders, or government requests\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nc. Business Transactions:\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'In the event of a merger, acquisition, or sale of assets, your information may be transferred as part of the transaction\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\n4. Your Choices\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'You can manage your privacy preferences within the App settings. You may choose to opt-out of certain communications or request the deletion of your account.\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\n5. Security Measures\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'We implement industry-standard security measures to protect your personal information from unauthorized access, disclosure, alteration, and destruction.\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\n6. Children\'s Privacy\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'The App is not intended for use by individuals under the age of 13. We do not knowingly collect personal information from children.\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\n7. Updates to Privacy Policy\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'We may update this Privacy Policy from time to time to reflect changes in our practices or for legal reasons. We will notify you of any significant changes through the App or other communication channels.\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\n8. Contact Information\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'If you have questions or concerns about this Privacy Policy, please contact us at ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        'ict@bluefountain.med.co.zw \n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nBy using the Zimbabwe Women\'s Microfinance Bank Mobile Banking App, you agree to the terms outlined in this Privacy Policy. ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
