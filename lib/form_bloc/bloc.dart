import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:im_back/form_bloc/services.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc {
  final SignUpBaseApi api;

  SignUpBloc({
    @required this.api,
  });

  // subjects
  final _accountSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _pass2Subject = BehaviorSubject<String>();
  final _accountCheckingSubject = BehaviorSubject<bool>.seeded(false);

  // triggers
  Function(String) get changeAccount => _accountSubject.sink.add;
  Function(String) get changePass => _passSubject.sink.add;
  Function(String) get changePass2 => _pass2Subject.sink.add;
  Function() get submit => (){
    print("Account: ${_accountSubject.value}, Pass: ${_passSubject.value}");
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
  Stream<bool> get passValid => _passSubject.stream.transform(
      StreamTransformer<String, bool>.fromHandlers(handleData: (pass, sink) {
        if (pass.length >= 4) {
          sink.add(true);
        } else {
          sink.add(false);
        }
      })
  );
  Stream<bool> get pass2Valid => Observable.combineLatest2(_passSubject.stream, _pass2Subject.stream, (p1, p2) => p1 == p2);
  Stream<bool> get submitValid => Observable.combineLatest3(accountValid, passValid, pass2Valid, (a, p1, p2) => a & p1 & p2);

  dispose() {
    _accountSubject.close();
    _passSubject.close();
    _pass2Subject.close();
    _accountCheckingSubject.close();
  }

}