import 'package:flutter/material.dart';
import 'package:im_back/form_notifier/states.dart';
import 'package:im_back/services/signup_service.dart';
import 'package:provider/provider.dart';

class FormByNotifier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<SignUpModel>(
        builder: (context) => SignUpModel(
          api: SignUpApi(), // inject API
        ),
        dispose: (context, value) => value.dispose(),
        child: Builder(builder: (context) => _buildForm(context)),
    );
  }

  Widget _buildForm(BuildContext context) {
    final signUpModel = Provider.of<SignUpModel>(context, listen: false);
    return Container(
      margin: EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          _buildAccount(context, signUpModel),
          _buildPass1(context, signUpModel),
          _buildPass2(context, signUpModel),
          _buildSubmit(context, signUpModel),
        ],
      ),
    );
  }

  Widget _buildAccount(BuildContext context, SignUpModel signUpModel) {
    return Row(
      children: <Widget>[
        ChangeNotifierProvider.value(
          value: signUpModel.accountValid,
          child: Consumer<ValueNotifier<bool>>(
            builder: (_, valid, __) => Icon(Icons.account_circle, color: valid.value??false ? Colors.green : Colors.black,),
          )
        ),
        Expanded(child: TextField(
          onChanged: signUpModel.updateAccount,
        )),
        ChangeNotifierProvider.value(
            value: signUpModel.accountChecking,
            child: Consumer<ValueNotifier<bool>>(
              builder: (_, checking, __) => SizedBox.fromSize(
                  size: Size.square(checking.value??false ? 25.0 : 0.0),
                  child: CircularProgressIndicator()
              ),
            )
        )
      ],
    );
  }

  Widget _buildPass1(BuildContext context, SignUpModel signUpModel) {
    return Row(
      children: <Widget>[
        ChangeNotifierProvider.value(
            value: signUpModel.pass1Valid,
            child: Consumer<ValueNotifier<bool>>(
              builder: (_, valid, __) => Icon(Icons.fingerprint, color: valid.value??false ? Colors.green : Colors.black,),
            )
        ),
        Expanded(child: TextField(
          obscureText: true,
          onChanged: signUpModel.updatePass1,
        )),
      ],
    );
  }

  Widget _buildPass2(BuildContext context, SignUpModel signUpModel) {
    return Row(
      children: <Widget>[
        ChangeNotifierProvider.value(
            value: signUpModel.pass2Valid,
            child: Consumer<ValueNotifier<bool>>(
              builder: (_, valid, __) => Icon(Icons.fingerprint, color: valid.value??false ? Colors.green : Colors.black,),
            )
        ),
        Expanded(child: TextField(
          obscureText: true,
          onChanged: signUpModel.updatePass2,
        )),
      ],
    );
  }

  Widget _buildSubmit(BuildContext context, SignUpModel signUpModel) {
    return ChangeNotifierProvider.value(
        value: signUpModel.submitValid,
        child: Consumer<ValueNotifier<bool>>(
          builder: (_, valid, __) => RaisedButton(
            child: Text("Submit"),
            color: Colors.green,
            onPressed: valid.value??false ? signUpModel.submit : null,
          ),
        )
    );
  }
}