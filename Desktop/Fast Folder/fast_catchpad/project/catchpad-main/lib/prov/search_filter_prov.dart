


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchFilterProvider extends StateNotifier<String> {
  SearchFilterProvider(String state) : super("");
  ScrollController? scrollController;
  bool requiredRefreshList = false;

  /*
  When typing any text into a text field, you must use the onChanged function.
  This function is triggered every time you type a character, and if you want
  to apply a filter to the search field, you must update it using the
  onChanged function. This ensures that your list only shows items
  that match the current filter. If an item does not match the filter,
  it will be hidden.
  */
  void setScrollController(ScrollController controller){
    scrollController = controller;
  }

  void updateFilterText(String text){
    state = text;
    requiredRefreshList = true;

    if(scrollController != null){
      scrollController!.notifyListeners();
    }

  }

  void updateRequireStateToFalse(){
    requiredRefreshList = false;
  }


  //You can clear all filter
  void clearFilterText(TextEditingController controller){
    controller.clear();
    state = "";
  }




}