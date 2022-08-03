import 'package:flutter/material.dart';
import 'package:networking_like_a_pro/api_response_model.dart';
import 'package:networking_like_a_pro/home_repository.dart';
import 'package:networking_like_a_pro/networking_response.dart';

class HomeScreenViewModel extends ChangeNotifier {
  HomeScreenViewModel() {
    // As soon as the VM initializes, we want to get the latest data.
    getDataFromAPI();
  }

  APIResponseModel? apiResponseModel;
  String messageToShow = "";
  bool isLoading = false;

  void getDataFromAPI() async {
    // start showing the loader.
    isLoading = true;
    notifyListeners();

    // Wait for response;
    NetworkingResponse networkingResponse = await HomeScreenRepository().getLatestStatsData();

    // Check type of response and update required field.
    if (networkingResponse is NetworkingResponseData) {
      // Update api response model.
      apiResponseModel = networkingResponse.apiResponseModel;
    } else if (networkingResponse is NetworkingException) {
      messageToShow = networkingResponse.message;
    }

    // Stop the loader.
    isLoading = false;
    notifyListeners();
  }
}
