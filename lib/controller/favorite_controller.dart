import 'package:flutter_english_hub/model/favorite.dart';
import 'package:flutter_english_hub/service/favorite_service.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final FavoriteService favoriteService = Get.find<FavoriteService>();
  var favoritesList = <Favorite>[].obs;
  var isLoading = true.obs;

  Future<void> addFavorite(Favorite favorite) async {
    try {
      isLoading(true);
      bool isAdded = await favoriteService.addFavorite(favorite);
      if (isAdded) {
        fetchFavorites();
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchFavorites() async {
    try {
      isLoading(true);
      var favorites = await favoriteService.getFavoritesByUserId();
      favoritesList.value = favorites;
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteFavorite(int resourceId, String resourceType) async {
    try {
      isLoading(true);
      bool isDeleted = await favoriteService.deleteFavorite(resourceId, resourceType);
      if (isDeleted) {
        fetchFavorites();
      }
    } finally {
      isLoading(false);
    }
  }
}
