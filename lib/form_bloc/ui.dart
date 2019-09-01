import 'package:flutter/material.dart';
import 'package:im_back/form_bloc/bloc.dart';
import 'package:im_back/form_bloc/services.dart';


class SignUpForm extends StatelessWidget {
  final bloc = SignUpBloc(
    api: SignUpApi(),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          _buildAccount(),
          _buildPass(),
          _buildPass2(),
          _buildSubmit(),
        ],
      ),
    );
  }

  Widget _buildAccount() {
    return Row(
      children: <Widget>[
        StreamBuilder<bool>(
            stream: bloc.accountValid,
            builder: (context, snapshot) {
              return Icon(Icons.account_circle, color: snapshot.data??false ? Colors.green : Colors.black,);
            }
        ),
        Expanded(
          child: TextField(
            onChanged: bloc.changeAccount,
          ),
        ),
        StreamBuilder<bool>(
            stream: bloc.accountChecking,
            builder: (context, snapshot) {
              return SizedBox.fromSize(
                  size: Size.square(snapshot.data??false ? 25.0 : 0.0),
                  child: CircularProgressIndicator()
              );
            }
        ),
      ],
    );
  }

  Widget _buildPass() {
    return Row(
      children: <Widget>[
        StreamBuilder<bool>(
            stream: bloc.passValid,
            builder: (context, snapshot) {
              return Icon(Icons.fingerprint, color: snapshot.data??false ? Colors.green : Colors.black,);
            }
        ),
        Expanded(
          child: TextField(
            obscureText: true,
            onChanged: bloc.changePass,
          ),
        ),
      ],
    );
  }

  Widget _buildPass2() {
    return Row(
      children: <Widget>[
        StreamBuilder<bool>(
            stream: bloc.pass2Valid,
            builder: (context, snapshot) {
              return Icon(Icons.fingerprint, color: snapshot.data??false ? Colors.green : Colors.black,);
            }
        ),
        Expanded(
          child: TextField(
            obscureText: true,
            onChanged: bloc.changePass2,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmit() {
    return StreamBuilder<bool>(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text("Submit"),
          color: Colors.green,
          onPressed: snapshot.data??false ? bloc.submit : null,
        );
      }
    );
  }
}
