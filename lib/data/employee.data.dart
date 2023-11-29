import 'package:rzf_canvasing_sirwal/model/employee.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class EmployeeData {
  Future<List<Employee>> fetchData() async {
    var employees = <Employee>[];
    print(getParamQuery());
    var response = await ApiService.get(
      url + employeeUrl,
      queryParameters: getParamQuery(),
    );
    var succes = await manageResponse(response);
    if (succes) {
      var data = getDataResponse(response)['data'];
      for (var item in data) {
        employees.add(Employee.fromJson(item));
      }
    }

    return employees;
  }
}
