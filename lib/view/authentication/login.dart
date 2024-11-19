import 'package:flutter/material.dart';
import 'package:prototype/components/app_bar.dart';
import 'package:prototype/components/landing_page.dart';
import 'package:prototype/components/my_button.dart';
import 'package:prototype/components/my_textfield.dart';
import 'package:prototype/view/authentication/Auth.dart';
import 'package:prototype/view/student/data/student_datatable.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.login});
  final bool login;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  // text editing controller
  final usernameController = TextEditingController();
  final useremailController = TextEditingController();
  final passwordController = TextEditingController();
  // final FocusNode _focusNodePaaword = FocusNode();

  // clear
  void clear() {
    usernameController.clear();
    useremailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: MyAppBar(
            automaticallyImplyLeading: false, appbartitle: 'B R O T O T Y P E'),
      ),
      // AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text(
      //     'BROTOTYPE',
      //     style: TextStyle(
      //       fontSize: 30,
      //       color: Colors.white,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                //logo
                //
                const Image(image: AssetImage('assets/images/brototype.jpg')),
                const SizedBox(
                  height: 50,
                ),
                //welcome
                Text(
                  'WELCOME ALL',
                  style: TextStyle(fontSize: 35, color: Colors.grey[700]),
                ),
                const SizedBox(
                  height: 25,
                ),
                // UserName textfield
                widget.login
                    ? const SizedBox()
                    : MyTextField(
                        // focusNode: FocusNode(),
                        controller: usernameController,
                        keyBoard: TextInputType.name,
                        hintText: 'UserName',
                        labelText: 'Name',
                        obscureText: false,
                        validator: 'Enter Username',

                        // focusNode: FocusNode(),
                      ),
                const SizedBox(
                  height: 10,
                ),
                // UserEmail textfield
                MyTextField(
                  // focusNode: FocusNode(),
                  controller: useremailController,
                  keyBoard: TextInputType.name,
                  hintText: 'UserEmail',
                  labelText: 'Email',
                  obscureText: false,
                  validator: 'Enter Username',

                  // focusNode: FocusNode(),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: passwordController,
                  keyBoard: TextInputType.name,
                  hintText: 'PassWord',
                  labelText: 'Password',
                  obscureText: true,
                  validator: 'Enter Password',
                  // focusNode: _focusNodePaaword,
                ),
                const SizedBox(
                  height: 10,
                ),

                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        Login(login: !widget.login)));
                          },
                          child: widget.login
                              ? Text(
                                  'Sign up',
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              : const Text('Log In')),
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                // login
                widget.login
                    ? MyButton(
                        login: true,
                        onTap: () {
                          loginUser(context);
                        })
                    : MyButton(
                        login: false,
                        onTap: () {
                          loginUser(context);
                        }),
                const SizedBox(
                  height: 25,
                ),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child:
                              Divider(thickness: 0.5, color: Colors.grey[400])),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                          child:
                              Divider(thickness: 0.5, color: Colors.grey[400])),
                    ],
                  ),
                )
                //google
              ],
            ),
          ),
        ),
      ),
    );
  }

// login user method
  void loginUser(BuildContext context) async {
    final name = usernameController.text.trim();
    final email = useremailController.text.trim();
    final password = passwordController.text.trim();

    if (_formkey.currentState!.validate()) {
      if (widget.login) {
        final login = await LogAuth.checkSignIn(
                formlog: _formkey,
                context: context,
                email: email,
                password: password)
            .then((value) => null);
        // if (login == 'admin') {
        //   Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (ctx) => LandingPage()));
        // } else {
        //   Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (ctx) =>  StudentDataTable()));
        // }
      } else {
        LogAuth.checkSignUp(
                context: context, name: name, email: email, password: password)
            .then((value) => null);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const Login(login: true)));
      }

      // Go to Students Profile
      // final sharedPrefs = await SharedPreferences.getInstance();
      // await sharedPrefs.setBool(SAVE_KEY_NAME, true);
    } else {
      clear();
      const errormessage = 'Username password doesnot match';

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          content: Text(errormessage)));
    }
  }

  @override
  void dispose() {
    useremailController.dispose();
    passwordController.dispose();
    _formkey.currentState?.dispose();

    super.dispose();
  }
}
