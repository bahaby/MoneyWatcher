import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_watcher/bloc/form_submission_status.dart';
import 'package:money_watcher/bloc/auth/login/login_bloc.dart';
import 'package:money_watcher/page/home_page.dart';
import 'package:money_watcher/page/register_page.dart';
import 'package:money_watcher/service/local_storage_service.dart';

import '../service_locator.dart';

class LoginPage extends StatelessWidget {
  final _focusScopeNode = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();
  static const routeName = '/login_page';
  final storageService = getIt<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginForm(context),
    );
  }

  Widget _loginForm(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          } else if (formStatus is SubmissionSuccess) {
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          }
        },
        child: Form(
          key: _formKey,
          child: FocusScope(
            node: _focusScopeNode,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _emailField(),
                  _passwordField(),
                  SizedBox(height: 20),
                  _loginButton(),
                  SizedBox(height: 100),
                  _registerPageLink(context),
                  Text(storageService.getJwtToken()),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'Email',
        ),
        validator: (value) =>
            state.isValidEmail ? null : 'Email format is not correct',
        onEditingComplete: _focusScopeNode.nextFocus,
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginEmailChanged(email: value),
            ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Password',
        ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too short',
        onEditingComplete: _focusScopeNode.unfocus,
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginPasswordChanged(password: value),
            ),
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              child: Text('Login'),
            );
    });
  }

  Widget _registerPageLink(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xffbf0000))),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(RegisterPage.routeName);
        },
        child: Text("Register", style: TextStyle(color: Colors.white)));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
