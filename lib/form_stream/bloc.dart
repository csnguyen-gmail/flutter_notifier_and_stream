import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:im_back/services/signup_service.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc {
  final SignUpBaseApi api;

  SignUpBloc({
    @required this.api,
  });

  // subjects
  final _accountSubject = BehaviorSubject<String>();
  final _pass1Subject = BehaviorSubject<String>();
  final _pass2Subject = BehaviorSubject<String>();
  final _accountCheckingSubject = BehaviorSubject<bool>.seeded(false);

  // triggers
  Function(String) get changeAccount => _accountSubject.sink.add;
  Function(String) get changePass1 => _pass1Subject.sink.add;
  Function(String) get changePass2 => _pass2Subject.sink.add;
  Function() get submit => (){
    print("Account: ${_accountSubject.value}, Pass: ${_pass1Subject.value}");
  };

  // signals
  Stream<bool> get accountValid => _accountSubject.debounceTime(Duration(milliseconds: 200)).transform(
      StreamTransformer<String, bool>.fromHandlers(handleData: (account, sink) async {
        try {
          _accountCheckingSubject.sink.add(true);
          sink.add(await api.checkAccountValid(account));
        } catch (_) {
          sink.add(false);
        }
        finally {
          _accountCheckingSubject.sink.add(false);
        }
      })
  );
  Stream<bool> get accountChecking => _accountCheckingSubject.stream;
  Stream<bool> get pass1Valid => _pass1Subject.stream.transform(
      StreamTransformer<String, bool>.fromHandlers(handleData: (pass, sink) {
        sink.add(pass.length >= 4);
      })
  );
  Stream<bool> get pass2Valid => Observable.combineLatest3(
      _pass1Subject.stream, _pass2Subject.stream, pass1Valid, (p1, p2, p1Valid) => p1Valid & (p1 == p2)
  );
  Stream<bool> get submitValid => Observable.combineLatest3(
      accountValid, pass1Valid, pass2Valid, (a, p1, p2) => a & p1 & p2
  );

  dispose() {
    print("bloc dispose");
    _accountSubject.close();
    _pass1Subject.close();
    _pass2Subject.close();
    _accountCheckingSubject.close();
  }
}