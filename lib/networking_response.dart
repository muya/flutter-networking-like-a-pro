import 'package:networking_like_a_pro/api_response_model.dart';

class NetworkingResponse {}

class NetworkingException extends NetworkingResponse {
  String message;

  NetworkingException(this.message);
}

class NetworkingResponseData extends NetworkingResponse {
  APIResponseModel apiResponseModel;

  NetworkingResponseData(this.apiResponseModel);
}

