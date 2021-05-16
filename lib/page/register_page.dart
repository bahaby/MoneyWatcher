import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_watcher/bloc/auth/form_submission_status.dart';
import 'package:money_watcher/bloc/auth/login/login_bloc.dart';
import 'package:money_watcher/bloc/auth/register/register_bloc.dart';
import 'package:money_watcher/page/home_page.dart';
import 'package:money_watcher/page/login_page.dart';
import 'package:money_watcher/service/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  static const routeName = '/register_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          context.read<AuthService>(),
        ),
        child: _registerForm(context),
      ),
    );
  }

  Widget _registerForm(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _fullNameField(),
                _emailField(),
                _passwordField(),
                SizedBox(height: 20),
                _registerButton(),
                SizedBox(height: 100),
                _loginPageLink(context),
              ],
            ),
          ),
        ));
  }

  Widget _fullNameField() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Name',
        ),
        validator: (value) => state.isValidName ? null : 'Name is too short',
        onChanged: (value) => context.read<RegisterBloc>().add(
              RegisterNameChanged(fullName: value),
            ),
      );
    });
  }

  Widget _emailField() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'Email',
        ),
        validator: (value) =>
            state.isValidEmail ? null : 'Email format is not correct',
        onChanged: (value) => context.read<RegisterBloc>().add(
              RegisterEmailChanged(email: value),
            ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Password',
        ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too short',
        onChanged: (value) => context.read<RegisterBloc>().add(
              RegisterPasswordChanged(password: value),
            ),
      );
    });
  }

  Widget _registerButton() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<RegisterBloc>().add(RegisterSubmitted());
                }
              },
              child: Text('Register'),
            );
    });
  }

  Widget _loginPageLink(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
        },
        child: Text("Login"));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
