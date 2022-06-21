import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_app/model/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryId);
  
}

class CategoryDB implements CategoryDbFunctions {


  CategoryDB._interal();
  static CategoryDB instance = CategoryDB._interal();

  factory CategoryDB(){
    return instance;
  }



  ValueNotifier<List<CategoryModel>> incomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> exponseCategoryList = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id,value);
    refresUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refresUI() async {
    final _allCategroies = await getCategories();
    incomeCategoryList.value.clear();
    exponseCategoryList.value.clear();
    await Future.forEach(_allCategroies, (CategoryModel categroy) {
      if(categroy.type == CategoryType.income){
        incomeCategoryList.value.add(categroy);
      }else{
        exponseCategoryList.value.add(categroy);
      }
    });
    incomeCategoryList.notifyListeners();
    exponseCategoryList.notifyListeners();
  }
  
  @override
  Future<void> deleteCategory(String categoryId) async{
    final _categoryDB  = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.delete(categoryId);
    refresUI();
  }
  
  
  

}

