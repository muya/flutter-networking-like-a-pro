import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:networking_like_a_pro/api_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:networking_like_a_pro/home_screen_viewmodel.dart';
import 'package:provider_architecture/provider_architecture.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  APIResponseModel? apiResponseModel;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeScreenViewModel>.withConsumer(
      viewModel: HomeScreenViewModel(),
      builder: (context, viewModel, child) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              appBar: buildAppBar(),
              body: buildBody(viewModel),
              floatingActionButton: buildFloatingActionButton(viewModel),
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Networking Example'),
    );
  }

  Widget buildBody(viewModel) {
    // Since viewModel is being observed, this will rebuild when there are
    // api changes in ViewModel
    return Container(child: Center(child: buildDataWidget(viewModel)));
  }

  FloatingActionButton buildFloatingActionButton(viewModel) {
    return FloatingActionButton(
      tooltip: "Get Data From API",
      onPressed: () => viewModel.getDataFromAPI(),
      child: isLoading
          ? const CircularProgressIndicator(
              backgroundColor: Colors.white,
            )
          : const Icon(Icons.cloud_download),
    );
  }

  void getDataFromAPI() async {
    setState(() {
      isLoading = true;
    });

    const String API_URL = "http://0.0.0.0:3012/corona-stats";
    var response = await http.get(Uri.parse(API_URL));
    var parsedJson = await json.decode(response.body);
    setState(() {
      apiResponseModel = APIResponseModel.fromJson(parsedJson);
      isLoading = false;
    });
  }

  buildDataWidget(viewModel) {
    APIResponseModel apiResponseModel = viewModel.apiResponseModel;

    if (apiResponseModel == null) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Press the floating button to get data',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Text(
        "Total Cases : ${apiResponseModel.cases}\n"
        "Today's Cases : ${apiResponseModel.todayCases}\n"
        "Total Deaths : ${apiResponseModel.deaths}\n"
        "Today's Deaths : ${apiResponseModel.todayDeaths}\n"
        "Total Recovered: ${apiResponseModel.recovered}\n"
        "Active Cases : ${apiResponseModel.active}\n"
        "Critical Cases : ${apiResponseModel.critical}\n"
        "Cases per million : ${apiResponseModel.casesPerOneMillion}\n"
        "Deaths per million : ${apiResponseModel.deathsPerOneMillion}\n"
        "Total Tests Done : ${apiResponseModel.tests}\n"
        "Tests per million : ${apiResponseModel.testsPerOneMillion}\n"
        "Affected countries : ${apiResponseModel.affectedCountries}\n",
        style: const TextStyle(fontSize: 18),
      );
    }
  }
}
