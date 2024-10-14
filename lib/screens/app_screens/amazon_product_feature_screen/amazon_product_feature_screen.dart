import '../../../config.dart';

class AmazonProductFeatureScreen extends StatelessWidget {
  final amazonProFeatCtrl = Get.put(AmazonProductFeatureController());

  AmazonProductFeatureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AmazonProductFeatureController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          resizeToAvoidBottomInset: false,
          appBar: AppAppBarCommon(
              isBalanceShow: false,
              title: appFonts.amazonProductFeature,
              leadingOnTap: () => Get.back()),
          body: Column(children: [
            amazonProFeatCtrl.isProductGenerated == true
                ?   Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textCommon.outfitSemiBoldPrimary16(
                      text: appFonts.greatProduct),
                  const VSpace(Sizes.s10),
                  InputLayout(
                      hintText: "",
                      title: appFonts.productDetail,
                      color: appCtrl.appTheme.white,
                      isMax: false,
                      responseText: "birthdayCtrl.response"),
                  const VSpace(Sizes.s30),
                  ButtonCommon(title: appFonts.endProduct, onTap: ()=> amazonProFeatCtrl.endNameSuggestion() )
                ])
                : const WithoutProductGenerateLayout()

          ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20));
    });
  }
}
