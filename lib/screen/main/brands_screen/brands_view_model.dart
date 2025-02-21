import 'package:amin_qassob/utils/pref_utils.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

import '../../../model/brand_model.dart';

class BrandsViewModel extends BaseViewModel {
  List<BrandModel> brandList = [];
  late final Box<BrandModel> boxBrand = Hive.box<BrandModel>('brands_table');
  late final Box<BrandModel> boxGroup = Hive.box<BrandModel>('groups_table');

  var progressData = false;

  void getBrandList(String categoryId, String keyword) {
    progressData = true;
    notifyListeners();
      brandList = boxGroup.values
          .where((element) =>
      (element.category_id == categoryId) && (element.brendName.toLowerCase().contains(keyword.toLowerCase())))
          .toList();

    progressData = false;
    notifyListeners();
  }
}
