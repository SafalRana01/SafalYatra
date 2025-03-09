import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:khalti_flutter/localization/khalti_localizations.dart';
import 'package:safal_yatra/utils/memory.dart';

import 'app/routes/app_pages.dart';

void main() async {
  // Ensures Flutter binding is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences for local storage
  await Memory.init();

  // Run the application wrapped with KhaltiScope for payment integration
  runApp(KhaltiScope(
    // Public key for Khalti payment gateway (test environment)
    publicKey: "test_public_key_dbf46546d51e4d07b678b47fcd520848",

    // publicKey: "test_public_key_c07849ed94d3404096c9700c8a13f469",

    builder: (context, navigator) => GetMaterialApp(
      navigatorKey: navigator, // Set navigator key for KhaltiScope integration

      // Supported locales for language translations
      supportedLocales: const [
        Locale('en', 'US'), // English (United States)
        Locale('ne', 'NP'), // Nepali (Nepal)
      ],

      // Localization delegates for Khalti and other packages
      localizationsDelegates: const [
        KhaltiLocalizations.delegate, // Khalti payment localization
        // MonthYearPickerLocalizations.delegate,
      ],

      // Define the application theme
      theme: ThemeData(
        useMaterial3: true, // Enables Material 3 design
      ),

      debugShowCheckedModeBanner: false, // Hide debug banner

      // Default page transition animation
      defaultTransition: Transition.cupertino, // iOS-style page transition

      title: "Application", // App title

      // Initial route when the app starts
      initialRoute: Routes.SPLASH_SCREEN,

      // Define app routes from the AppPages class
      getPages: AppPages.routes,
    ),
  ));
}
