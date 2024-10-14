import 'package:probot/controllers/ecommerce_controller/amazon_product_listing_controller.dart';

import '../../../config.dart';

class AmazonProductListingScreen extends StatelessWidget {
  final amazonListingCtrl = Get.put(AmazonProductListingController());

  AmazonProductListingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AmazonProductListingController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          resizeToAvoidBottomInset: false,
          appBar: AppAppBarCommon(
              isBalanceShow: false, title: appFonts.amazonProductListing,leadingOnTap: ()=> Get.back()),
          body: Column(children: [
            amazonListingCtrl.isProductGenerated == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textCommon.outfitSemiBoldPrimary16(
                          text: appFonts.useAppropriate),
                      const VSpace(Sizes.s10),
                      InputLayout(
                          hintText: "",
                          title: appFonts.productDetail,
                          color: appCtrl.appTheme.white,
                          isMax: false,
                          responseText: "birthdayCtrl.response"),
                      const VSpace(Sizes.s30),
                      ButtonCommon(
                          title: appFonts.endProductList,
                          onTap: () => amazonListingCtrl.endNameSuggestion())
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        textCommon.outfitSemiBoldPrimary16(
                            text: appFonts.entireProductDescriptions),
                        const VSpace(Sizes.s10),
                        Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              textCommon.outfitSemiBoldTxt14(
                                  text: appFonts.productName),
                              const VSpace(Sizes.s10),
                              TextFieldCommon(
                                  hintText: appFonts.enterValue,
                                  controller:
                                      amazonListingCtrl.productController),
                              const VSpace(Sizes.s30),
                              InputLayout(
                                  title: appFonts.productDescription,
                                  hintText: appFonts.enterValue,
                                  isMax: true,
                                  controller:
                                      amazonListingCtrl.productDescController),
                              const VSpace(Sizes.s20),
                              MusicCategoryLayout(
                                  title: appFonts.language,
                                  category:
                                      amazonListingCtrl.selectItem ?? "Hindi",
                                  onTap: () =>
                                      amazonListingCtrl.onLanguageSheet())
                            ])
                            .paddingSymmetric(
                                horizontal: Insets.i15, vertical: Insets.i20)
                            .authBoxExtension(),
                        const VSpace(Sizes.s30),
                        ButtonCommon(
                            title: appFonts.bringMeTheBest, onTap: ()=> amazonListingCtrl.onProductGenerated())
                      ])
          ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20));
    });
  }
}
