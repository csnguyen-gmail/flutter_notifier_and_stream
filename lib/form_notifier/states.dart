import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:im_back/services/signup_service.dart';

class SignUpModel{
  final SignUpBaseApi api;

  SignUpModel({
    @required this.api,
  });

  // signals
  final accountChecking = ValueNotifier<bool>(false);
  final accountValid = ValueNotifier<bool>(false);
  final pass1Valid = ValueNotifier<bool>(false);
  final pass2Valid = ValueNotifier<bool>(false);
  final submitValid = ValueNotifier<bool>(false);

  // data
  String _account;
  String _pass1;
  String _pass2;
  Timer _debounce;

  // triggers
  void updateAccount(String account) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      _account = account;
      try {
        accountChecking.value = true;
        accountValid.value = await api.checkAccountValid(account);
      } catch (_) {
        accountChecking.value = false;
      }
      finally {
        accountChecking.value = false;
      }
      submitValid.value = accountValid.value & pass1Valid.value & pass2Valid.value;
    });
  }

  void updatePass1(String pass) {
    _pass1 = pass;
    pass1Valid.value = pass.length >= 4;
    pass2Valid.value = _pass2 == _pass1;
    submitValid.value = accountValid.value & pass1Valid.value & pass2Valid.value;
  }

  void updatePass2(String pass) {
    _pass2 = pass;
    pass2Valid.value = pass1Valid.value && (_pass2 == _pass1);
    submitValid.value = accountValid.value & pass1Valid.value & pass2Valid.value;
  }

  void submit() {
    print("Account: $_account, Pass: $_pass1");
  }

  dispose() {
  }
}