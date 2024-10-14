import 'package:probot/config.dart';

class Setting extends StatelessWidget {
  final settingCtrl = Get.put(SettingController());

  Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(builder: (context) {
      return DirectionalityRtl(
          child: Scaffold(
              key: settingCtrl.scaffoldKey,
              backgroundColor: appCtrl.appTheme.bg1,

              appBar: AppAppBarCommon(
                  title: appFonts.setting,
                  leadingOnTap: () => Get.back()),
              body: SingleChildScrollView(
                  child: Column(children: [
                Stack(alignment: Alignment.center, children: [
                  Image.asset(eImageAssets.settingBg).marginOnly(
                      top: Insets.i25,
                      left: Insets.i20,
                      right: Insets.i20,
                      bottom: Insets.i20),
                  Column(children: [
                    const SettingUser(),
                    const VSpace(Sizes.s10),
                    Text(settingCtrl.userName ?? "Welcome to Probot",
                        style: AppCss.outfitMedium14
                            .textColor(appCtrl.appTheme.lightText))
                  ])
                ]),
                const VSpace(Sizes.s20),
                ...settingCtrl.settingList
                    .asMap()
                    .entries
                    .map((e) => e.value["title"] == "logout"
                        ? appCtrl.isGuestLogin
                            ? Container()
                            : SettingList(index: e.key, data: e.value)
                                .marginSymmetric(horizontal: Insets.i20)
                        : SettingList(index: e.key, data: e.value)
                            .marginSymmetric(horizontal: Insets.i20))
                    .toList()
              ]).marginOnly(bottom: Insets.i25))));
    });
  }
}
