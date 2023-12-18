import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/data/sales.data.dart';
import 'package:rzf_canvasing_sirwal/enum/product_price_type.enum.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/extension.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/model/customer.dart';
import 'package:rzf_canvasing_sirwal/model/product.onCart.dart';
import 'package:rzf_canvasing_sirwal/model/supplier.dart';
import 'package:rzf_canvasing_sirwal/model/tsx_account.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/services/printer/blue_thermal_printer.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/payment/succes.page.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class PaymentController extends GetxController {
  late final TransactionType type;
  late final List<ProductOnCart> products;
  final data = Get.arguments as Map<String, dynamic>;

  final fakturController = TextEditingController();
  final grandTotalController = TextEditingController();
  final salesController = TextEditingController();
  final dateController = TextEditingController();
  final accountController = TextEditingController();
  final tempoController = TextEditingController();
  final totalController = TextEditingController();
  final payController = TextEditingController();
  final discountController = TextEditingController();
  final personController = TextEditingController();
  final totalBarangC = TextEditingController();
  final totalHematC = TextEditingController();

  var transactionDate = DateTime.now();
  var tempoDate = DateTime.now();
  var moneySuggestion = <int>[].obs;
  var paymentTypes = <String>['Tunai', 'Kredit'].obs;
  var salesList = <String>[].obs;
  var salesLoading = false.obs;
  var saleType = Rx<String?>(null);

  Supplier? supplier;
  Customer? customer;
  var paymentType = "Tunai".obs;
  var discount = 0.0;
  var grandTotal = 0.0;
  var total = 0.0;
  var pay = 0.0;
  var point = 0.obs;
  var faktur = <String, dynamic>{};

  getSales() async {
    salesLoading.value = true;
    salesList.value = await SalesData().fetchApiData();
    salesLoading.value = false;
  }

  onSave() async {
    var valid = _validation();
    if (valid) {
      if (type.isBuy) {
        _buySave();
      } else {
        _saleSave();
      }
    }
  }

  _buySave() async {
    waitingDialog();
    var response = await ApiService.post(
      '$url$buyUrl',
      data: {
        'user_id': GlobalVar.userId,
        'buy_date': dateFormatAPI(transactionDate),
        'supplier_id': supplier!.id,
        'total': grandTotal,
        'payment': pay,
        'type': paymentType.value,
        'faktur': fakturController.text,
        'ppn': 0,
        'note':
            '${isPass() || isTunai() ? "Pembelian dari" : "Pembayaran DP ke"} ${supplier!.name}',
        if (paymentType.value == 'Kredit') 'tempo': dateFormatAPI(tempoDate),
        'product_list': _productsToJson(),
      },
    );
    Get.back();
    var success = await manageResponse(response);
    if (success) {
      Get.to(const PaySuccessPage());
    }
  }

  _saleSave() async {
    waitingDialog();
    var response = await ApiService.post(
      '$url$saleUrl',
      data: {
        'user_id': GlobalVar.userId,
        'cabang_id': GlobalVar.employee!.idCabang,
        'cabang': GlobalVar.employee!.cabang,
        'cashier': GlobalVar.employee!.user,
        'sale_date': dateFormatAPI(transactionDate),
        'customer_id': customer!.id,
        'sales': salesController.text,
        'account': accountController.text,
        'sale_type': saleType.value,
        'total': grandTotal,
        'discount': discount.toInt(),
        'type': paymentType.value,
        'payment': pay,
        'poin': point.value,
        'note':
            '${isPass() || isTunai() ? "Penjualan" : "Terima DP"} dari ${customer!.name}',
        if (paymentType.value == 'Kredit') 'tempo': dateFormatAPI(tempoDate),
        'product_list': _productsToJson(),
      },
    );
    Get.back();
    var success = await manageResponse(response);
    if (success) {
      var data = getDataResponse(response);
      faktur = data;
      Get.to(const PaySuccessPage());
      printInvoice();
    }
  }

  printInvoice() {
    Printer.printInvoice(faktur);
  }

  showPrinterWarning() async {
    if (Printer.printerConnected == null) {
      await Future.delayed(const Duration(milliseconds: 100));
      showDialogAction(
        ActionDialog.warning,
        "Aplikasi belum terhubung ke printer",
      );
    }
  }

  bool isTunai() => paymentType.value == "Tunai";
  bool isPass() => pay == grandTotal;

  discountOnChanged(double value) {
    if (value <= total) {
      discount = value;
      grandTotal = total;
      grandTotal -= discount;
      pay = 0;
      payController.text = moneyFormatter(pay);
      if (discount == 0) grandTotal = total;
      grandTotalController.text = moneyFormatter(grandTotal);
      getMoneySugest();
    }
  }

  accountPage() async {
    var data = await Get.toNamed(Routes.tsxAccount);
    if (data != null) {
      var account = data as TsxAccount;
      accountController.text = account.name;
    }
  }

  personPage() async {
    if (type.isBuy) {
      var data = await Get.toNamed(Routes.supplier, arguments: true);
      if (data != null) {
        supplier = (data as Supplier);
        personController.text = supplier!.name;
      }
    } else {
      var data = await Get.toNamed(Routes.customer, arguments: true);
      if (data != null) {
        customer = (data as Customer);
        personController.text = customer!.name;
      }
    }
  }

  pickSuggestion(double suggest) {
    pay = suggest;
    payController.text = moneyFormatter(pay);
  }

  pickDate() {
    showCustomDatePicker((date) {
      tempoDate = date;
      tempoController.text = dateFormatUI(tempoDate);
    });
  }

  Future<bool> onWillPopScope() async {
    if (products.isEmpty) {
      Get.back(result: {"clear": products.isEmpty});
      Get.back();
    } else {
      Get.back();
    }
    return true;
  }

  close() {
    Get.back();
    supplier = null;
    customer = null;
    saleType.value = null;
    discount = 0;
    total = 0;
    grandTotal = 0;
    pay = 0;
    point.value = 0;
    transactionDate = DateTime.now();
    tempoDate = DateTime.now();
    dateController.text = dateFormatUI(transactionDate);
    tempoController.text = dateFormatUI(tempoDate);
    paymentType.value = "Tunai";
    discountController.clear();
    personController.clear();
    accountController.clear();
    fakturController.clear();
    payController.clear();
    grandTotalController.clear();
    totalController.clear();
    totalBarangC.clear();
    totalHematC.clear();
    products.clear();
    salesController.clear();
    _countTotal();
    getMoneySugest();
  }

  getBack() {
    Get.back(result: {"clear": products.isEmpty});
  }

  ///Method untuk menampilkan
  ///uang money suggestion pada pembayaran
  getMoneySugest() {
    var moneyFractions = [
      10000,
      20000,
      50000,
      70000,
      100000,
      120000,
      140000,
      150000,
    ];
    var moneyTotal = (type.isBuy ? total : grandTotal).toInt();
    var moneySuggest = <int>[moneyTotal];
    for (var i in moneyFractions) {
      if (moneyTotal < moneyFractions.last) {
        if (moneyTotal < i && !moneySuggest.contains(i)) {
          moneySuggest.add(i);
        }
      } else {
        int roundedMoney = moneyTotal ~/ 50000;
        if (roundedMoney % 2 != 0) {
          roundedMoney -= 1;
        }
        int money = roundedMoney * 50000;
        var m = i + money;
        if (moneyTotal < m && !moneySuggest.contains(m)) {
          moneySuggest.add(m);
        }
      }
      if (moneySuggest.length == 3) {
        break;
      }
    }
    moneySuggestion.value = [...moneySuggest];
  }

  List<Map<String, dynamic>> _productsToJson() {
    var data = <Map<String, dynamic>>[];
    for (var item in products) {
      var priceType = FuncHelper().getPriceFromCustomerLevels(
        item.onCart,
        customer,
        item.getSimilarProductOnCart(products),
      );
      data.add(type.isBuy ? item.toBuyJson() : item.toSaleJson(priceType));
    }
    return data;
  }

  bool _validation() {
    if (products.isEmpty) {
      showDialogAction(
        ActionDialog.warning,
        "Keranjang kosong silahkan pilih produk terlebih dahulu",
      );
      return false;
    } else if (personController.text.isEmpty) {
      var fieldName = type.isBuy ? "supplier" : "pelanggan";
      showDialogAction(
        ActionDialog.warning,
        "Pilih $fieldName terlebih dahulu",
      );
      return false;
    } else if (type.isBuy && fakturController.text == '') {
      showDialogAction(
        ActionDialog.warning,
        "Masukan faktur terlebih dahulu",
      );
      return false;
    } else if (salesController.text == '' && type.isSale) {
      showDialogAction(
        ActionDialog.warning,
        "Pilih sales terlebih dahulu",
      );
      return false;
    } else if (saleType.value == null) {
      showDialogAction(
        ActionDialog.warning,
        "Pilih jenis jual terlebih dahulu",
      );
      return false;
    } else if (paymentType.value == "Tunai" && pay < grandTotal) {
      showDialogAction(
        ActionDialog.warning,
        "Jenis pembayaran tunai harus sama atau lebih dengan jumlah total pembelian",
      );
      return false;
    } else if (paymentType.value == "Kredit" && pay == total) {
      showDialogAction(
        ActionDialog.warning,
        "Untuk bayar pas ubah jenis pembayaran menjadi tunai",
      );
      return false;
    } else if (paymentType.value == "Kredit" && pay > total) {
      showDialogAction(
        ActionDialog.warning,
        "Pembayaran melebihi nominal pembelian",
      );
      return false;
    }
    return true;
  }

  initialize() async {
    getSales();
    type = data['type']!;
    products = data['data']! as List<ProductOnCart>;
    customer = data['customer'] as Customer?;
    _countTotal();
    totalController.text = moneyFormatter(total);
    grandTotalController.text = moneyFormatter(grandTotal);
    dateController.text = dateFormatUI(transactionDate);
    tempoController.text = dateFormatUI(transactionDate);
    personController.text = customer?.name ?? '';
    getMoneySugest();
    showPrinterWarning();
  }

  _countTotal() {
    var totalBarang = 0;
    var totalHemat = 0.0;
    for (var item in products) {
      var price = item.getPrice(priceType: getProductPrice(item));
      total += (price - item.dscNominal) * (item.onCart ~/ item.unit!.isi!);
      totalBarang += item.onCart;
      totalHemat += (item.getPrice() - price) * item.onCart;
    }
    if (customer?.type.isMember ?? false) {
      var productTmp = [...products.unique((e) => e.id, false)];
      for (var item in productTmp) {
        point.value += item.pointsEarned;
      }
    }
    grandTotal = total;
    totalBarangC.text = totalBarang.toString();
    totalHematC.text = moneyFormatter(totalHemat);
  }

  ProductPriceType getProductPrice(ProductOnCart data) {
    var qty = data.onCart;
    var similarProduct = data.getSimilarProductOnCart(products);
    var priceType = FuncHelper().getPriceFromCustomerLevels(
      qty,
      customer,
      similarProduct,
    );
    return priceType;
  }

  @override
  void onInit() {
    initialize();
    super.onInit();
  }
}
