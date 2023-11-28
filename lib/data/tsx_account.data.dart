import 'package:rzf_canvasing_sirwal/model/tsx_account.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class TsxAccountData {
  Future<List<TsxAccount>> getAccounts() async {
    var accounts = <TsxAccount>[];
    var response = await ApiService.get(
      "$url$accountUrl",
      queryParameters: getParamQuery(),
    );
    var success = await manageResponse(response);
    if (success) {
      var data = getDataResponse(response)['data'];
      for (var item in data) {
        accounts.add(TsxAccount.fromJson(item));
      }
    }
    return accounts;
  }

  Future<TsxAccount> getSingleAccounts({String keyword = ""}) async {
    late TsxAccount account;
    var response = await ApiService.get(
      "$url$accountUrl",
      queryParameters: getParamQuery(query: {"account": keyword}),
    );
    var success = await manageResponse(response);
    if (success) {
      var data = getDataResponse(response)['data'];
      account = TsxAccount.fromJson(data);
    }
    return account;
  }
}
