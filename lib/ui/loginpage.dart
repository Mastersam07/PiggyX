import 'package:flutter/material.dart';
import 'package:PiggyX/services/auth.dart';
import 'package:PiggyX/services/auth_provider.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        final BaseAuth auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          final String userId =
              await auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        } else {
          final String userId =
              await auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

//  Future<void> validateAndLoginGoogle() async {
//      final BaseAuth auth = AuthProvider.of(context).auth;
//        final String userId = await auth.signInWithGoogle();
//        print('Signed in: $userId');
//  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PiggyX'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.center,
            children: buildImage() + buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return <Widget>[
      TextFormField(
        key: Key('email'),
        decoration: InputDecoration(
          labelText: 'Email',
          icon: Icon(
            Icons.mail,
            color: Colors.grey,
          ),
        ),
        validator: EmailFieldValidator.validate,
        onSaved: (String value) => _email = value,
      ),
      TextFormField(
        key: Key('password'),
        decoration: InputDecoration(
          labelText: 'Password',
          icon: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
        obscureText: true,
        validator: PasswordFieldValidator.validate,
        onSaved: (String value) => _password = value,
      ),
      SizedBox(
        height: 8.0,
      ),
    ];
  }

  List<Widget> buildImage() {
    return <Widget>[
//      new Container(alignment: Alignment.center,
//          height: 200.0,
//          width: 100.0,
//          decoration: new BoxDecoration(
//              shape: BoxShape.circle,
//              image: new DecorationImage(
//                  fit: BoxFit.fill,
//                  image: new AssetImage("assets/images/piggyicon.png")))),
      Container(
        child: Center(
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/piggyicon.png'),
            backgroundColor: Colors.white,
            radius: 100.0,
          ),
        ),
      ),
      SizedBox(
        height: 25.0,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return <Widget>[
        OutlineButton(
          key: Key('SignIn'),
          splashColor: Colors.grey,
          onPressed: validateAndSubmit,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//                Image(
//                    image: AssetImage("assets/images/google_logo.png"), height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'SignIn',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
//        OutlineButton(
//          key: Key('SignInWithGogle'),
//          splashColor: Colors.grey,
//          onPressed: validateAndLoginGoogle,
//          shape:
//              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//          highlightElevation: 0,
//          borderSide: BorderSide(color: Colors.grey),
//          child: Padding(
//            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//            child: Row(
//              mainAxisSize: MainAxisSize.min,
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Image(
//                    image: AssetImage("assets/images/google_logo.png"),
//                    height: 35.0),
//                Padding(
//                  padding: const EdgeInsets.only(left: 10),
//                  child: Text(
//                    'Sign in with Google',
//                    style: TextStyle(
//                      fontSize: 20,
//                      color: Colors.grey,
//                    ),
//                  ),
//                )
//              ],
//            ),
//          ),
//        ),
//        SizedBox(
//          height: 8.0,
//        ),
        OutlineButton(
          key: Key('SignUp'),
          splashColor: Colors.grey,
          onPressed: moveToRegister,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//                Image(
//                    image: AssetImage("assets/images/google_logo.png"), height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ];
    } else {
      return <Widget>[
        OutlineButton(
          splashColor: Colors.grey,
          onPressed: validateAndSubmit,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//                Image(
//                    image: AssetImage("assets/images/google_logo.png"), height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        OutlineButton(
          splashColor: Colors.grey,
          onPressed: moveToLogin,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//                Image(
//                    image: AssetImage("assets/images/google_logo.png"), height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Existing User? SignIn',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ];
    }
  }
}
