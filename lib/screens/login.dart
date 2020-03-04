import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum FormType {
  login,
  register
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  final _auth = FirebaseAuth.instance;
  FormType _formType = FormType.login;

bool validateAndSave(){
  if (_formKey.currentState.validate()) {
    _formKey.currentState.save();
    print('form valid $_email and $_password');
    return true;
  }
  return false;
}

void validateAndSubmit() async{
  if(validateAndSave()) {
    try{
      if(_formType == FormType.login){
       final user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
        print('LoggedUser:$user');
      } else {
        final user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
        print('Registered User: $user');
      }
    }
    catch(e) {
      print(e);
    }
  }
}

void moveToRegister(){
  _formKey.currentState.reset();
  setState(() {
    _formType = FormType.register;
  });
}void moveToLogin(){
  _formKey.currentState.reset();
  setState(() {
    _formType = FormType.login;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

List<Widget> buildInputs(){
  return [
    TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (value) => value.isEmpty ? 'Email cant be empty': null,
      onSaved: (value) => _email = value,
    ),
    TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
      onSaved: (value) => _password = value,
      validator: (value) => value.isEmpty ? 'Password cant be empty': null,
    ),
  ];
}
List<Widget> buildSubmitButtons(){
  if(_formType == FormType.login){
    return [
      RaisedButton(
        onPressed: validateAndSubmit,
        color: Colors.lightBlueAccent,
        child: Text('Login', style: TextStyle(fontSize: 18.0), ),
      ),
      FlatButton(
        onPressed: moveToRegister,
        child: Text('Create an account', style: TextStyle(fontSize: 20.0),),
      )
    ];
  } else {
    return [
      RaisedButton(
        onPressed: validateAndSubmit,
        color: Colors.lightBlueAccent,
        child: Text('Register', style: TextStyle(fontSize: 18.0), ),
      ),
      FlatButton(
        onPressed: moveToLogin,
        child: Text('Already have an account? Login', style: TextStyle(fontSize: 20.0),),
      )
    ];
  }

}
}


