import 'dart:developer';

import 'package:probot/config.dart';
import '../../env.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    bool onBoard = appCtrl.storage.read("isOnboard") ?? false;
    bool isGuestLogin = appCtrl.storage.read(session.isGuestLogin) ?? false;
    appCtrl.isGuestLogin = isGuestLogin;
    var name = appCtrl.storage.read("name");
    var userName = appCtrl.storage.read("userName");
    var firebaseUser = appCtrl.storage.read("firebaseUser");
    var number = appCtrl.storage.read("number");

    appCtrl.isOnboard = onBoard;

    appCtrl.envConfig = appCtrl.storage.read(session.envConfig) ?? environment;

    update();
    dynamic selectedImage =
        appCtrl.storage.read("backgroundImage") ?? appArray.backgroundList[0];
    appCtrl.storage.write("backgroundImage", selectedImage);

    await FirebaseFirestore.instance.collection("config").get().then((value) {
      if (value.docs.isNotEmpty) {
        appCtrl.firebaseConfigModel =
            FirebaseConfigModel.fromJson(value.docs[0].data());
        //Stripe.publishableKey = appCtrl.firebaseConfigModel!.stripePublishKey!;
        appCtrl.update();
        ThemeService().switchTheme(appCtrl.isTheme);
        Get.forceAppUpdate();
        appCtrl.storage.write(session.firebaseConfig, value.docs[0].data());
        if (!appCtrl.isGuestLogin) {
          appCtrl.envConfig["balance"] = appCtrl.firebaseConfigModel!.balance;
        }
        appCtrl.update();
        appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
      }
    });

    //category hide show
    await FirebaseFirestore.instance
        .collection("categoryAccess")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        appCtrl.categoryAccessModel =
            CategoryAccessModel.fromJson(value.docs[0].data());
        appCtrl.update();
        Get.forceAppUpdate();
        appCtrl.storage.write(session.categoryConfig, value.docs[0].data());
      }
    });

    if (!appCtrl.isGuestLogin && userName != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        if (value.exists) {
          appCtrl.envConfig["balance"] = value.data()!["balance"];
          appCtrl.update();
          appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
        }
      });
    } else {

      appCtrl.envConfig = appCtrl.storage.read(session.envConfig);
    }
    appCtrl.update();
    bool isLoginSave = appCtrl.storage.read(session.isLogin) ?? false;

    bool isBiometricSave = appCtrl.storage.read(session.isBiometric) ?? false;
    bool isLanguageSaved = appCtrl.storage.read(session.isLanguage) ?? false;
    bool isCharacterSaved = appCtrl.storage.read(session.isCharacter) ?? false;
    bool isUserThemeChange =
        appCtrl.storage.read(session.isUserThemeChange) ?? false;
    bool isUserRTLChange =
        appCtrl.storage.read(session.isUserChangeRTL) ?? false;
    appCtrl.isLocalChatApi =
        appCtrl.storage.read(session.isChatGPTKey) ?? false;
    appCtrl.isCharacter = isCharacterSaved;
    appCtrl.isLanguage = isLanguageSaved;
    appCtrl.isBiometric = isBiometricSave;
    appCtrl.isLogin = isLoginSave;

    //select Character as per selected or guest
    if (appCtrl.isGuestLogin) {
      await FirebaseFirestore.instance
          .collection("characters")
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          appCtrl.selectedCharacter = value.docs[3].data();
          appCtrl.storage.write(session.characterIndex, 3);
          appCtrl.characterIndex =
              appCtrl.storage.read(session.characterIndex) ?? 3;
          appCtrl.characterIndex =
              appCtrl.storage.read(session.characterIndex) ?? 3;
          appCtrl.update();
        }
      });
    } else {
      appCtrl.selectedCharacter =
          appCtrl.storage.read(session.selectedCharacter) ?? "";
      log("SPLASH CHAR : ${appCtrl.selectedCharacter}");
      if (appCtrl.selectedCharacter == "") {
        log("SPLASH CHAR 2: ${appCtrl.selectedCharacter}");
        await FirebaseFirestore.instance
            .collection("characters")
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            appCtrl.selectedCharacter = value.docs[3].data();
            appCtrl.storage.write(session.characterIndex, 3);
            appCtrl.characterIndex =
                appCtrl.storage.read(session.characterIndex) ?? 3;
            appCtrl.characterIndex =
                appCtrl.storage.read(session.characterIndex) ?? 3;
            appCtrl.update();
          }
        });
        appCtrl.update();
      } else {
        appCtrl.selectedCharacter =
            appCtrl.storage.read(session.selectedCharacter) ??
                appArray.selectCharacterList[0];
        appCtrl.update();
      }
    }

    log("SPLASH CHAR1: ${appCtrl.selectedCharacter}");
    // Language Save
    Locale? locale = const Locale("en", "US");

    // Theme Save
    bool isTheme = appCtrl.storage.read(session.isDarkMode) ?? false;
    ThemeService().switchTheme(isTheme);
    appCtrl.isTheme = isTheme;

    //language
    var language = await appCtrl.storage.read(session.locale) ?? "en";

    if (language != null) {
      appCtrl.languageVal = language;
      if (language == "en") {
        locale = const Locale("en", "US");
      } else if (language == "hi") {
        locale = const Locale("hi", "IN");
      } else if (language == "it") {
        locale = const Locale("it", "IT");
      } else if (language == "fr") {
        locale = const Locale("fr", "CA");
      } else if (language == "ge") {
        locale = const Locale("ge", "GE");
      } else if (language == "ja") {
        locale = const Locale("ja", "JP");
      }
    } else {
      locale = const Locale("en", "US");
    }

    Get.updateLocale(locale);
    appCtrl.update();
    Get.forceAppUpdate();


    appCtrl.isOnboard = onBoard;

    update();

    appCtrl.isUserTheme = appCtrl.storage.read(session.isUserTheme) ?? false;
    await FirebaseFirestore.instance.collection("config").get().then((value) {
      if (value.docs.isNotEmpty) {
        appCtrl.firebaseConfigModel =
            FirebaseConfigModel.fromJson(value.docs[0].data());


        if (isUserThemeChange) {
          appCtrl.storage.write(session.isUserTheme, true);
          appCtrl.isUserThemeChange = true;
          ThemeService().switchTheme(appCtrl.isUserTheme);
          Get.forceAppUpdate();
        } else {
          appCtrl.isUserThemeChange = false;
          appCtrl.storage.write(session.isUserTheme, false);

          appCtrl.isTheme = appCtrl.firebaseConfigModel!.isTheme!;

          appCtrl.update();
          ThemeService().switchTheme(appCtrl.isTheme);
          Get.forceAppUpdate();
        }

//RTL
        if (isUserRTLChange) {
          bool isUserRtl = appCtrl.storage.read(session.isUserRTL) ?? false;

          appCtrl.storage.write(session.isUserRTL, isUserRtl);
          appCtrl.isUserRTL = isUserRtl;
          appCtrl.isUserRTLChange = true;
          appCtrl.update();
          Get.forceAppUpdate();
        } else {
          appCtrl.isUserRTLChange = false;
          appCtrl.isUserRTL = false;
          appCtrl.storage.write(session.isUserChangeRTL, false);
          appCtrl.storage.write(session.isUserRTL, false);
          appCtrl.update();
          Get.forceAppUpdate();
        }
        appCtrl.update();

        appCtrl.storage.write(session.firebaseConfig, value.docs[0].data());
        if (!appCtrl.isGuestLogin) {
          appCtrl.envConfig["balance"] = appCtrl.firebaseConfigModel!.balance;
        }
        appCtrl.update();
        appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
      }
    });

    if (!appCtrl.isGuestLogin && userName != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        if (value.exists) {
          appCtrl.envConfig["balance"] = value.data()!["balance"];
          appCtrl.update();
          appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
        }
      });
    } else {
      int balance = appCtrl.storage.read(session.envConfig)["balance"];
      appCtrl.envConfig["balance"] = balance;
      appCtrl.envConfig = appCtrl.storage.read(session.envConfig);
    }

    update();
    Future.delayed(const Duration(seconds: 3), () {


      if (onBoard) {
        if (isGuestLogin) {
          appCtrl.isGuestLogin = isGuestLogin;
          appCtrl.storage.write(session.isGuestLogin, isGuestLogin);
          Get.toNamed(routeName.dashboard);
        } else {
          appCtrl.isGuestLogin = false;
          appCtrl.storage.write(session.isGuestLogin, false);

          if (isLoginSave) {
            if (isBiometricSave) {
              Get.offAllNamed(routeName.addFingerprintScreen);
            } else {
              Get.toNamed(routeName.dashboard);
            }
          } else {
            if (name != null ||
                userName != null ||
                firebaseUser != null ||
                number != null) {
              if (isLanguageSaved) {
                if (isBiometricSave) {
                  Get.offAllNamed(routeName.addFingerprintScreen);
                } else {
                  Get.toNamed(routeName.dashboard);
                }
              } else {
                Get.toNamed(routeName.selectLanguageScreen);
              }
            } else {
              Get.toNamed(routeName.loginScreen);
            }
          }
        }
      } else {
        Get.toNamed(routeName.onBoardingScreen);
      }
      update();
    });
  }
}
