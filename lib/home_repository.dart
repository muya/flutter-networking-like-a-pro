import 'package:networking_like_a_pro/networking_repository.dart';
import 'package:networking_like_a_pro/networking_response.dart';

class HomeScreenRepository {
  /// ViewModel calls its Repository to getLatestStatsData
  /// The Repository will take care of getting the data from the right source
  /// Only HomeRepository knows that it has to call NetworkRepo()
  /// ViewModel doesn't care if its coming from API or Offline cache.

  Future<NetworkingResponse> getLatestStatsData() {
    return NetworkRepo().getLatestDataFromAPI();
  }
}
