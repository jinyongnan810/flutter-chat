import 'dart:io';

import 'package:chat/components/image-picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitForm);
  // declare detailed function format passed from parent
  final Future<bool> Function(String email, String username, String password,
      bool isLogin, File? image) submitForm;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
// for using vsync in AnimatedSize
    with
        SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _username = '';
  String _password = '';
  File? _image;
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isLoading = false;

  void _trySubmit() async {
    final validated = this._formKey.currentState!.validate();
    if (_image == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an image as your icon.')));
      return;
    }
    if (!validated) return;
    setState(() {
      _isLoading = true;
    });
    // close the keyboard if its still there
    FocusScope.of(context).unfocus();
    this._formKey.currentState!.save();
    // print('ok');
    final success = await widget.submitForm(
        _email.trim(), _username.trim(), _password.trim(), _isLogin, _image);
    if (!success) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _setUserImage(File image) {
    this._image = image;
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!_isLogin) ImagePickerSet(_setUserImage),
                      TextFormField(
                        key: ValueKey('email'),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter an email';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          if (_isLogin) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          } else {
                            FocusScope.of(context)
                                .requestFocus(_usernameFocusNode);
                          }
                        },
                        onSaved: (value) {
                          this._email = value!;
                        },
                      ),
                      if (!_isLogin)
                        TextFormField(
                          key: ValueKey('username'),
                          decoration: InputDecoration(labelText: 'Username'),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 4) {
                              return 'Please enter a username with more than 4 characters';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            this._username = value!;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                          focusNode: _usernameFocusNode,
                        ),
                      TextFormField(
                        key: ValueKey('password'),
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 6) {
                            return 'Please enter a password with more than 6 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          this._password = value!;
                        },
                        onFieldSubmitted: (_) => _trySubmit(),
                        focusNode: _passwordFocusNode,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _trySubmit,
                              child:
                                  _isLogin ? Text('Login') : Text('Sign up')),
                      if (!_isLoading)
                        TextButton(
                            onPressed: () {
                              setState(() {
                                this._isLogin = !this._isLogin;
                              });
                            },
                            child: _isLogin
                                ? Text('Create Account')
                                : Text('Go to login'))
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
