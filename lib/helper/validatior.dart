String? emailValidator(String email) {
  if (email != "") {
    var regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    if (regex) {
      return null;
    } else {
      return "Masukan email yang valid";
    }
  } else {
    return "Email harus diisi!";
  }
}

String? phoneValidator(String field, String value) {
  if (value.isNotEmpty) {
    var regex = RegExp(
      r"^[0-9]+$",
    ).hasMatch(value);
    if (regex) {
      return null;
    } else {
      return "$field harus valid!";
    }
  } else {
    return "$field tidak boleh kosong";
  }
}

String? pwValidator(String password) {
  if (password != "") {
    if (password.length >= 5) {
      return null;
    } else {
      return "Password minimal 5 huruf";
    }
  } else {
    return "Password harus diisi!";
  }
}

String? pwConfirmValidator(String password, String confirm) {
  if (confirm == "") {
    return "Konfirmasi password harus diisi";
  } else {
    if (confirm == password) {
      return null;
    } else {
      return "Konfirmasi password tidak cocok ";
    }
  }
}

String? emptyValidator(String field, String value) {
  if (value.isNotEmpty) {
    return null;
  } else {
    return "$field harus diisi!";
  }
}

String? paymentValidator(String value, double money, double total) {
  if (value.isNotEmpty) {
    if (money < total) {
      return "Uang yang dimasukan tidak cukup";
    } else {
      return null;
    }
  } else {
    return "Anda belum memasukan uang";
  }
}
