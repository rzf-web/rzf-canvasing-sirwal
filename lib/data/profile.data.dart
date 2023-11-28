import 'package:rzf_canvasing_sirwal/abstract/fetch_api_data.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/model/profile.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class ProfileData extends FetchApiData {
  @override
  Future fetchApiData() async {
    var response = await ApiService.get(
      "$url/profile",
      queryParameters: getParamQuery(),
    );
    var data = getDataResponse(response)['data'];
    GlobalVar.profile = Profile.fromJson(data);
  }
}
