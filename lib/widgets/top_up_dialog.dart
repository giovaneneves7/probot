import '../config.dart';

class TopUpDialog extends StatelessWidget {
  const TopUpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: appCtrl.appTheme.trans,
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(appFonts.topUpBalance.tr,
                    style: AppCss.outfitblack20
                        .textColor(appCtrl.appTheme.txt)
                        .textDecoration(TextDecoration.none)),
                InkWell(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(eSvgAssets.cancel,
                        height: Sizes.s24,
                        colorFilter: ColorFilter.mode(
                            appCtrl.appTheme.black, BlendMode.srcIn)))
              ]).paddingAll(Insets.i20),
              DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1,
                  dashLength: 3,
                  dashColor: appCtrl.appTheme.txt.withOpacity(.2)),
              Stack(alignment: Alignment.topCenter, children: [
                Image.asset(eImageAssets.coins, height: Sizes.s100)
                    .paddingSymmetric(
                        horizontal: Insets.i40, vertical: Insets.i10),
                Image.asset(eGifAssets.balance,
                        width: Sizes.s170, height: Sizes.s170)
                    .paddingOnly(top: Insets.i25)
              ]),
              const VSpace(Sizes.s10),
              Stack(alignment: Alignment.center, children: [
                Image.asset(eImageAssets.cashOffer),
                Text(
                    appFonts.totalCoinsAvailable(
                        appCtrl.envConfig["balance"].toString()),
                    style: AppCss.outfitSemiBold16
                        .textColor(appCtrl.appTheme.sameWhite))
              ]),
              const VSpace(Sizes.s12),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                CommonAppWidgets().columnTitleAndValu(appFonts.youCanTopUp),
                Text(appFonts.or.tr.toUpperCase(),
                        style: AppCss.outfitMedium14
                            .textColor(appCtrl.appTheme.lightText))
                    .marginSymmetric(vertical: Insets.i8),
                CommonAppWidgets().columnTitleAndValu(appFonts.youCanPurchase)
              ]).alignment(Alignment.center),
              const VSpace(Sizes.s30),
              ButtonCommon(
                  title: appFonts.purchaseCoinBalance,
                  style: AppCss.outfitMedium18
                      .textColor(appCtrl.appTheme.sameWhite),
                  margin: 20,
                  onTap: () {}),
              const VSpace(Sizes.s15),
              Text(appFonts.watchVideo.tr,
                      style: AppCss.outfitRegular18
                          .textColor(appCtrl.appTheme.primary))
                  .inkWell(onTap: () {
                if (appCtrl.firebaseConfigModel!.isGoogleAdmobEnable!) {
                  appCtrl.showRewardedAd();
                } else {
                  appCtrl.showFacebookRewardedAd();
                }
              }).alignment(Alignment.center),
              const VSpace(Sizes.s25)
            ])
            .decorated(
                color: appCtrl.appTheme.white,
                borderRadius: BorderRadius.circular(AppRadius.r10))
            .marginSymmetric(horizontal: Insets.i20));
  }
}
