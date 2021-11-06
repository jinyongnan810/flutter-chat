import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

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
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  void _trySubmit() {
    final validated = this._formKey.currentState!.validate();
    if (!validated) return;
    // close the keyboard if its still there
    FocusScope.of(context).unfocus();
    this._formKey.currentState!.save();
    print('ok');
  }

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Authenticate Error'),
              content: Text(msg),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(ctx).pop(), child: Text('OK'))
              ],
            ));
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
                      ElevatedButton(
                          onPressed: _trySubmit,
                          child: _isLogin ? Text('Login') : Text('Sign up')),
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
