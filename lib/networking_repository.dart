import 'dart:convert';

import 'package:networking_like_a_pro/api_response_model.dart';
import 'package:networking_like_a_pro/constants.dart';
import 'package:http/http.dart' as http;
import 'package:networking_like_a_pro/networking_response.dart';

/// Network Repo will handle networking
/// It will take care of parsing and exception handling and return a data
/// model or exception message.

class NetworkRepo {
  /// Return a NetworkingResponse which wraps either an ApiResponseModel OR
  /// a failed response.

  Future<NetworkingResponse> getLatestDataFromAPI() async {
    try {
      var response = await http.get(Uri.parse(apiEndpointUrl));
      var parsedJson = await json.decode(response.body);

      APIResponseModel apiResponseModel = APIResponseModel.fromJson(parsedJson);
      return NetworkingResponseData(apiResponseModel);
    } catch (exception) {
      return NetworkingException(exception.toString());
    }
  }
}
