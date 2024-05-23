import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/profile_model.dart';
import '../../utils/app_controller.dart';
import '../../utils/constants.dart';
import '../home.dart';
import '../home_screen.dart';
import '../registation/regisitration_screen.dart';
import '../welcom_page.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final LoginBloc _loginBloc;
   UserDetailsDao userDetailsDao=UserDetailsDao();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _loginBloc = LoginBloc(userDetailsDao: userDetailsDao);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginBloc,
      child: Scaffold(

        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Home(),
              ));
            } else if (state is LoginFailure) {
              AppController.showErrorDialog(context, state.error);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    //   color: Colors.deepOrange, // Set color for the custom container
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(57.0), // Set top left radius
                      bottomRight: Radius.circular(57.0), // Set top right radius
                    ),
                  ),
                  height: 320,
                  width: MediaQuery.of(context).size.width,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 30),
                    child: Image(
                      image: AssetImage("assets/images/illustration.jpeg"),
                      height: 250,
                      width: 350,
                      //  color: ColorConst.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0), // Make the border circular
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0), // Circular border
                          borderSide: BorderSide.none, // Remove the default border
                        ),                    ),
                    ),
                  ),
                ),
              ),
            ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0), // Make the border circular
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0), // Circular border
                              borderSide: BorderSide.none, // Remove the default border
                            ),                    ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40),
              height: defaultButtonSize,
              width: double.infinity, // Set the width to double.infinity to take full width
              child: FilledButton(
                onPressed: () {
                  _loginBloc.add(LoginButtonPressed(
                    username: _usernameController.text,
                    password: _passwordController.text,
                  ));
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blue,

                  padding: const EdgeInsets.all(8),
                ),
                child:  Text(
                  "LOGIN",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
                SizedBox(height:20),
                Padding(
                  padding: const EdgeInsets.only(bottom:28.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => RegistrationScreen(),
                      ));
                    },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        color: Colors.blue, // Set the text color
                        fontSize: 16.0, // Set the text size
                      ),
                    ),
                    child: const Text(
                      'New User? Create an Account',
                    ),
                  ),
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
