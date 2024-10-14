

import 'dart:developer';

import '../../../../config.dart';

class ResponseData extends StatelessWidget {
  const ResponseData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentWriterController>(
      builder: (contentCtrl) {
        log("message : ${contentCtrl.htmlData}");
        return RawScrollbar(
          controller: contentCtrl.scrollController,
          trackColor: appCtrl.appTheme.greyLight,
          thumbColor: appCtrl.appTheme.primary,
          radius: const Radius.circular(AppRadius.r4),
          thickness: 3,
          child: ListView(
              controller: contentCtrl.scrollController,
              padding: EdgeInsets.zero,
              children: [
                AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperAnimatedText(contentCtrl.htmlData,
                          textStyle: AppCss.outfitMedium14
                              .textColor(appCtrl.appTheme.txt)
                              .textHeight(1.3),
                          speed: const Duration(milliseconds: 50))
                    ]).paddingAll(Insets.i15).backgroundColor(appCtrl.appTheme.bg1),
              ]).height(contentCtrl.htmlData.length > 350
              ? Sizes.s350
              : contentCtrl.htmlData.length > 200
              ? Sizes.s180
              : Sizes.s120),
        );
      }
    );
  }
}
