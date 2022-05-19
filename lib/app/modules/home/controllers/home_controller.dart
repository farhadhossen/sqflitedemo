import 'package:get/get.dart';
import 'package:sqflitedemo/app/data/provider/list_data_model.dart';

import '../../../data/sqfitedb/favorite_database.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  late FavoriteDatabase favoriteDatabase;
  late List<Datum> data;
  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}


  insert() async {

    final datum = Datum(
      imageUrl: "img url",
      stramUrl: "stram url",
      chName: "sports",
      description: "ffffffffff",
      viewing: "105k",
      isFav: 1
    );

    await FavoriteDatabase.instance.create(datum);



  }
  read() async {



    data = await FavoriteDatabase.instance.readAllFavorites();
    print("=> "+data[0].id.toString());

  }

}
