import '../../../config.dart';

class AmazonProductReviewScreen extends StatelessWidget {
  final amazonProRevCtrl = Get.put(AmazonProductReviewController());

  AmazonProductReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AmazonProductReviewController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          resizeToAvoidBottomInset: false,
          appBar: AppAppBarCommon(
              title: appFonts.amazonProductReview,
              isBalanceShow: false,
              leadingOnTap: () => Get.back()),
          body: Column(children: [
            amazonProRevCtrl.isProductGenerated == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        textCommon.outfitSemiBoldPrimary16(
                            text: appFonts.sendingYourFinest),
                        const VSpace(Sizes.s10),
                        InputLayout(
                            hintText: "",
                            title: appFonts.productReview,
                            color: appCtrl.appTheme.white,
                            isMax: false,
                            responseText: "birthdayCtrl.response"),
                        const VSpace(Sizes.s30),
                        ButtonCommon(
                            title: appFonts.endProductReview,
                            onTap: () => amazonProRevCtrl.endNameSuggestion())
                      ])
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        textCommon.outfitSemiBoldPrimary16(
                            text: appFonts.giveAnOverview),
                        const VSpace(Sizes.s10),
                        Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              textCommon.outfitSemiBoldTxt14(
                                  text: appFonts.productDetail),
                              const VSpace(Sizes.s10),
                              TextFieldCommon(
                                  hintText: appFonts.enterValue,
                                  controller:
                                      amazonProRevCtrl.productController),
                              const VSpace(Sizes.s20),
                              InputLayout(
                                  title: appFonts.productDescription,
                                  hintText: appFonts.enterValue,
                                  isMax: true,
                                  controller:
                                      amazonProRevCtrl.productDescController),
                              const VSpace(Sizes.s20),
                              MusicCategoryLayout(
                                  title: appFonts.language,
                                  category:
                                      amazonProRevCtrl.selectItem ?? "Hindi",
                                  onTap: () =>
                                      amazonProRevCtrl.onLanguageSheet())
                            ])
                            .paddingSymmetric(
                                vertical: Insets.i20, horizontal: Insets.i15)
                            .authBoxExtension(),
                        const VSpace(Sizes.s30),
                        ButtonCommon(
                            title: appFonts.bringMeTheBestDetail,
                            onTap: () => amazonProRevCtrl.onProductGenerated())
                      ])
          ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i30));
    });
  }
}
