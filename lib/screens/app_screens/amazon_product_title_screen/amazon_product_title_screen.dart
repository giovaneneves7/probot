import 'package:probot/config.dart';


class AmazonProductTitleScreen extends StatelessWidget {
  final amazonProDetCtrl = Get.put(AmazonProductTitleController());
  AmazonProductTitleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCtrl.appTheme.bg1,
      resizeToAvoidBottomInset: false,
      appBar: AppAppBarCommon(title: appFonts.amazonProductTitle,leadingOnTap: ()=> Get.back()),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textCommon.outfitSemiBoldPrimary16(text: appFonts.giveYourProduct)
            ],
          )
        ],
      ).paddingSymmetric(vertical: Insets.i30,horizontal: Insets.i20),
    );
  }
}
