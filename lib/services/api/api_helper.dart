//API URL
import 'package:dio/dio.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

var url = "https://rzfkomputer.com/cnv-api/abm";
var loginUrl = '/login';
var supplierUrl = '/supplier';
var customerUrl = '/customer';
var productUrl = '/product';
var salesUrl = '/sales';
var productTypeUrl = '/type';
var categoryProductUrl = '/category';
var categoryCashFlowUrl = '/category';
var reportCashFlowUrl = '/report';
var accountUrl = '/account';
var multisatUrl = '/multi-satuan';
var rackUrl = '/rak';
var factoryUrl = '/factory';
var unitUrl = '/unit';
var buyUrl = '/buy';
var saleUrl = '/sale';
var cashFlowUrl = '/cash';
var mutasiCash = '/mutation';

getHeader({Map<String, dynamic>? header}) {
  var dataHeader = {
    "Access-Control-Allow-Origin": "*",
    "Accept": "application/json",
  };

  if (header != null) {
    for (var key in header.keys) {
      dataHeader[key] = header[key];
    }
  }

  return dataHeader;
}

getParamQuery({Map<String, dynamic>? query}) {
  Map<String, dynamic> paramQuery = {"user_id": GlobalVar.userId};

  if (query != null) {
    for (var key in query.keys) {
      paramQuery[key] = query[key];
    }
  }

  return paramQuery;
}

dynamic getDataResponse(dynamic data) {
  var response = (data as Response).data;
  return response;
}

Future<bool> manageResponse(
  dynamic data, {
  bool success = false,
  bool error = true,
}) async {
  if (data is Response) {
    var response = data;
    return await _succesResponse(response, success);
  } else {
    var exception = data as DioException;
    // showDialogCustom(SingleChildScrollView(
    //   child: Text(exception.response!.data),
    // ));
    // return false;
    return await _errorResponse(exception, error);
  }
}

Future<bool> _succesResponse(Response data, bool showMsg) async {
  var response = data.data;
  if (showMsg == true) {
    showDialogAction(ActionDialog.succes, response['message']);
  }
  return true;
}

Future<bool> _errorResponse(DioException exception, bool showMsg) async {
  var response = exception.response?.data;
  if (response != null) {
    if (showMsg) {
      try {
        var statusCode = exception.response!.statusCode;
        await showDialogAction(
          statusCode == 409 ? ActionDialog.warning : ActionDialog.failed,
          response['message'],
        );
      } catch (e) {
        await showDialogAction(ActionDialog.failed, exception.message!);
      }
    }
    return false;
  }
  if (exception.message != null) {
    showDialogAction(ActionDialog.failed, exception.message!);
    return false;
  } else {
    showDialogAction(ActionDialog.failed, exception.error.toString());
    return false;
  }
}
