import '../../../../config.dart';

class ChatTextBox extends StatelessWidget {
  const ChatTextBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return GetBuilder<AppController>(builder: (appCtrl) {
        return   appCtrl.isGuestLogin == true ?const SubscribeTextBox() : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("userSubscribe")
                .where("email", isEqualTo: appCtrl.storage.read("userName"))
                .limit(1)
                .snapshots(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                if (snapShot.data!.docs.isNotEmpty) {
                  if(snapShot.data!.docs[0].data()["isSubscribe"] == true) {

                    return const ChatLayoutTextBox();
                  }else{
                    return const SubscribeTextBox();
                  }
                } else {
                  return const SubscribeTextBox();
                }
              } else {
                return const SubscribeTextBox();
              }
            });
      });
    });
  }
}
