import '../../../../config.dart';

class WithoutProductGenerateLayout extends StatelessWidget {
  const WithoutProductGenerateLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AmazonProductFeatureController>(
        builder: (amazonProFeatCtrl) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        textCommon.outfitSemiBoldPrimary16(text: appFonts.describeYourProduct),
        const VSpace(Sizes.s10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.outfitSemiBoldTxt14(text: appFonts.productName),
          const VSpace(Sizes.s10),
          TextFieldCommon(
              hintText: appFonts.enterValue,
              controller: amazonProFeatCtrl.productController),
          const VSpace(Sizes.s30),
          InputLayout(
              title: appFonts.productDescription,
              hintText: appFonts.enterValue,
              isMax: true,
              controller: amazonProFeatCtrl.productDescController),
          const VSpace(Sizes.s20),
          Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  textCommon.outfitSemiBoldTxt14(text: appFonts.maxWord),
                  const VSpace(Sizes.s10),
                  TextFieldCommon(
                      keyboardType: TextInputType.number,
                      hintText: appFonts.enterValue,
                      controller: amazonProFeatCtrl.maxWordController)
                ])),
            const HSpace(Sizes.s10),
            Expanded(
                flex: 2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MusicCategoryLayout(
                          title: appFonts.language,
                          category: amazonProFeatCtrl.selectItem ?? "Hindi",
                          onTap: () => amazonProFeatCtrl.onLanguageSheet())
                    ]))
          ])
        ])
            .paddingSymmetric(horizontal: Insets.i15, vertical: Insets.i20)
            .authBoxExtension(),
        const VSpace(Sizes.s30),
        ButtonCommon(
            title: appFonts.bringMeTheBest,
            onTap: () => amazonProFeatCtrl.onProductGenerated())
      ]);
    });
  }
}
