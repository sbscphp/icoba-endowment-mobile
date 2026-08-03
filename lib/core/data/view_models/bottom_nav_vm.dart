
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ui/pages/bottom_nav_screens/home.dart';
import '../../../ui/pages/bottom_nav_screens/leaderboard.dart';
import '../../../ui/pages/bottom_nav_screens/portfolio.dart' show Portfolio;
import '../../../ui/pages/bottom_nav_screens/profile.dart';

class BottomNavVm extends ChangeNotifier{

  //current index of the bottom nav-bar
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void setCurrentIndex(int value, {bool refreshUi = true}){
    _currentIndex = value;
    if(refreshUi){
      notifyListeners();
    }
  }


  //children of the bottom Nav
  final List<Widget>  _screens = [
    Home(),
    Leaderboard(),
    Portfolio(),
    Profile(),
  ];
  List<Widget> get screens => _screens;


  //updates the current index of the bottom nav
  void updateIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }

}

final bottomNavViewModel = ChangeNotifierProvider.autoDispose<BottomNavVm>((ref){
  return BottomNavVm();
});