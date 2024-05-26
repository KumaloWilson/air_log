import 'package:air_log/providers/user_provider.dart';
import 'package:air_log/providers/userprofile_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'global/global.dart';
import 'helpers/shared_preferances_helper.dart';
import 'views/universal_screens/splash_screen/splash_screen.dart';

bool? hasSeenOnboarding;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  // await NotificationServices.getFCMDeviceToken();
  // await NotificationServices.requestNotifications();
  // await NotificationServices.initInfo();
  await SharedPreferencesHelper.getSelectedUserRole();

  if (userRole != null) {
    await SharedPreferencesHelper.checkOnBoardingStatus();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => UserProfileProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
