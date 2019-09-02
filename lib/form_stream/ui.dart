import 'package:flutter/material.dart';
import 'package:im_back/form_stream/bloc.dart';
import 'package:im_back/services/signup_service.dart';
import 'package:provider/provider.dart';


class FormByStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<SignUpBloc>(
      builder: (_) => SignUpBloc(
        api: SignUpApi(), // inject API
      ),
      child: Builder(builder: (context) => _buildForm(context)),
    );
  }

  Widget _buildForm(BuildContext context) {
    final bloc = Provider.of<SignUpBloc>(context, listen: false);
    return Container(
      margin: EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          _buildAccount(context, bloc),
          _buildPass1(context, bloc),
          _buildPass2(context, bloc),
          _buildSubmit(context, bloc),
        ],
      ),
    );
  }

  Widget _buildAccount(BuildContext context, SignUpBloc bloc) {
    return Row(
      children: <Widget>[
        StreamBuilder<bool>(
            stream: bloc.accountValid,
            builder: (context, snapshot) {
              return Icon(Icons.account_circle, color: snapshot.data??false ? Colors.green : Colors.black,);
            }
        ),
        Expanded(child: TextField(
            onChanged: bloc.changeAccount,
        ),),
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

  Widget _buildPass1(BuildContext context, SignUpBloc bloc) {
    return Row(
      children: <Widget>[
        StreamBuilder<bool>(
            stream: bloc.pass1Valid,
            builder: (context, snapshot) {
              return Icon(Icons.fingerprint, color: snapshot.data??false ? Colors.green : Colors.black,);
            }
        ),
        Expanded(
          child: TextField(
            obscureText: true,
            onChanged: bloc.changePass1,
          ),
        ),
      ],
    );
  }

  Widget _buildPass2(BuildContext context, SignUpBloc bloc) {
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

  Widget _buildSubmit(BuildContext context, SignUpBloc bloc) {
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
