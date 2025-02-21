import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/assets.dart';
import '../../../provider/providers.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/pref_utils.dart';
import '../../../utils/utils.dart';
import '../../../view/products_item_view.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Yoqimli mahsulotlar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          scrolledUnderElevation: 0,
        ),
        body: provider.getFavoriteList.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.62),
                itemCount: PrefUtils.getFavoriteList().length,
                itemBuilder: (context, index) {
                  final data = PrefUtils.getFavoriteList()[index];
                  return ProductsItemView(
                    item: data,
                  );
                },
              )
            : SizedBox(
                width: getScreenWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.imagesFavoriteList,
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "Sizda hozircha tanlanganlar mavjud emas !",
                        style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w500, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
      );
    });
  }
}
