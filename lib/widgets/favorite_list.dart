import '../config.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuickAdvisorController>(
      builder: (homeCtrl) {
        return GridView.builder(
            padding: EdgeInsets.zero,
            physics:
            const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: homeCtrl
                .favoriteDataList.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 20,
                childAspectRatio: 1,
                mainAxisSpacing: 15,
                mainAxisExtent: 105,
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return QuickAdvisorLayout(
                  index: index,
                  isFavorite: true,
                  selectIndex: homeCtrl
                      .selectedIndexRemove,
                  data: homeCtrl
                      .favoriteDataList[index],
                  onTap: () => homeCtrl
                      .onTapRemoveFavorite(
                      index));
            });
      }
    );
  }
}
