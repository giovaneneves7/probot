import 'package:probot/config.dart';

class ContentWriterScreen extends StatelessWidget {
  final contentCtrl = Get.put(ContentWriterController());

  ContentWriterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentWriterController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          key: contentCtrl.scaffoldKey,
          drawer: const CommonDrawer(),
          appBar: AppAppBarCommon(
              title: appFonts.option3,
              leadingOnTap: () => Get.back()),
          body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: contentCtrl.isLoading.value
                  ? Center(
                      child: Image.asset(eGifAssets.loader, height: Sizes.s80))
                  : ListView(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContentCommonWidget()
                                .commonText(appFonts.businessIdea),
                            const VSpace(Sizes.s8),
                            const BusinessIdeaDropDown().authBoxExtension(),
                            const VSpace(Sizes.s15),
                            ContentCommonWidget().commonText(appFonts.topic),
                            const VSpace(Sizes.s8),
                            TextFieldCommon(
                                    controller: contentCtrl.contentController,
                                    hintText: appFonts.exUiUx,
                                    fillColor: appCtrl.appTheme.surface)
                                .authBoxExtension(),
                            ButtonCommon(
                                    title: appFonts.generateContent,
                                    onTap: () =>
                                        contentCtrl.onTapContentGenerate())
                                .marginSymmetric(vertical: Insets.i40)
                          ]).marginAll(Insets.i25),
                      if (contentCtrl.htmlData != null)
                        const ContentDescription()
                            .paddingAll(Insets.i20)
                            .decorated(
                                color: appCtrl.appTheme.white,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.r8))
                    ])));
    });
  }
}
