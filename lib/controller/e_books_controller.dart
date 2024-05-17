
import 'package:flutter_english_hub/model/EBookCategory.dart';
import 'package:flutter_english_hub/model/EBookSeries.dart';
import 'package:flutter_english_hub/model/EBooks.dart';
import 'package:flutter_english_hub/service/e_books_service.dart';
import 'package:get/get.dart';

class EBooksController extends GetxController {
  
  final EBooksService eBooksService = Get.find<EBooksService>();

  var ebookCategories = <EBookCategory>[].obs;
  var ebookSeries = <EBookSeries>[].obs;
  var ebooks = <EBooks>[].obs;
  var isLoadingCategories = false.obs;
  var isLoadingSeries = false.obs;
  var isLoadingEBooks = false.obs;

  // 获取最新5条电子书
  Future<List<EBooks>> getLatestEBooks() async {
    var result = await eBooksService.getLatestEBooks();
    return result;
  }

  @override
  void onInit() {
    super.onInit();
    getEBookCategory();
  }

  Future<void> getEBookCategory() async {
    isLoadingCategories(true);
    try {
      var result = await eBooksService.getEBookCategory();
      ebookCategories.assignAll(result);
    } finally {
      isLoadingCategories(false);
    }
  }

  Future<void> getEBookSeriesByCategoryId(int categoryId) async {
    isLoadingSeries(true);
    try {
      var result = await eBooksService.getEBookSeriesByCategoryId(categoryId);
      ebookSeries.assignAll(result);
    } finally {
      isLoadingSeries(false);
    }
  }

  Future<void> getEBooksBySeriesId(int seriesId) async {
    isLoadingEBooks(true);
    try {
      var result = await eBooksService.getEBooksBySeriesId(seriesId);
      ebooks.assignAll(result);
    } finally {
      isLoadingEBooks(false);
    }
  }

  // // 根据categoryId获取电子书列表
  // Future<List<EBooks>> getEBooksByCategoryId(int categoryId) async {
  //   var result = await eBooksService.getEBooksByCategoryId(categoryId);
  //   return result;
  // }

  // // 根据categoryId获取电子书系列列表
  // Future<List<EBookSeries>> getEBookSeriesByCategoryId(int categoryId) async {
  //   var result = await eBooksService.getEBookSeriesByCategoryId(categoryId);
  //   return result;
  // }

  // // 获取全部电子书类别
  // Future<List<EBookCategory>> getEBookCategory() async {
  //   var result = await eBooksService.getEBookCategory();
  //   return result;
  // }
}