import 'package:get/get.dart';
import 'package:flutter/material.dart';


class ScreenController extends GetxController {
  // Reactive variable for the selected screen index
  var selectedScreen = 0.obs;  // This keeps track of the current selected screen (default is 0)

  // Reactive variable for the screen title
  var screenTitle = 'Dashboard'.obs;

  // List of screens to display (you can later add your actual screen widgets)
  var screens = <Widget>[ 
    DashboardScreen(),  // Assuming you have a DashboardScreen widget
    ProfileScreen(),    // Assuming you have a ProfileScreen widget
    SettingsScreen(),   // Assuming you have a SettingsScreen widget
  ];

  // Method to change the selected screen
  void selectScreen(int index) {
    selectedScreen.value = index;
    updateTitle(index);  // Update the screen title when screen is selected
  }

  // Method to change the title based on the selected screen index
  void updateTitle(int index) {
    switch (index) {
      case 0:
        screenTitle.value = 'Dashboard';
        break;
      case 1:
        screenTitle.value = 'Profiles';
        break;
      case 2:
        screenTitle.value = 'Settings';
        break;
      default:
        screenTitle.value = 'Dashboard';
        break;
    }
  }
}

// Example Screens
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Dashboard Screen"));
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile Screen"));
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Settings Screen"));
  }
}
