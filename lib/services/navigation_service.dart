import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  static final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  static void navigateToIndex(int index) {
    selectedIndex.value = index;
  }

  static void navigateToHome() => navigateToIndex(0);
  static void navigateToFavorites() => navigateToIndex(1);
  static void navigateToAbout() => navigateToIndex(2);
  static void navigateToSearch() => navigateToIndex(3);
}
