
import 'package:expence_tracker/pages/registation/regisitration_bloc.dart';
import 'package:expence_tracker/pages/registation/regisitration_event.dart';
import 'package:expence_tracker/pages/registation/regisitration_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/profile_model.dart';
import '../../utils/constants.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(UserDetailsDao()),
      child: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registration Successful')),
            );
            Navigator.of(context).pop();

          } else if (state.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registration Failed')),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(57.0),
                    bottomRight: Radius.circular(57.0),
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
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: buildWidget(context),
              ),
              const SizedBox(height: 10),

              buttonSave(context),
              const Padding(padding: EdgeInsets.only(top: 60.0)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWidget(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameField(context),
          buildPasswordField(context),
          buildPhoneField(context),
          buildEmailField(context),
        ],
      ),
    );
  }
  Widget buildNameField(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(8),
                  labelText: 'User Name',
                  hintText: 'Enter Name',
                ),
                onChanged: (value) => context.read<RegistrationBloc>().add(NameChanged(value)),
                validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
              ),
            ),
          ),
        );
      },
    );
  }


  Widget buildPasswordField(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(8),
                ),
                obscureText: true,
                onChanged: (value) => context.read<RegistrationBloc>().add(PasswordChanged(value)),
                validator: (value) => value == null || value.isEmpty ? 'Please enter your password' : null,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPhoneField(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(8),
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) => context.read<RegistrationBloc>().add(PhoneChanged(value)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length < 10) {
                    return 'Phone number must be 10 digits';
                  }
                  return null;
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildEmailField(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(8),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => context.read<RegistrationBloc>().add(EmailChanged(value)),
                validator: (value) => value == null || value.isEmpty ? 'Please enter your email' : null,
              ),
            ),
          ),
        );
      },
    );
  }


  Widget buttonSave(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 40, right: 40),
          height: defaultButtonSize,
          width: double.infinity,
          child: FilledButton(
            onPressed: state.isSubmitting
                ? null
                : () {
              if (_formKey.currentState!.validate()) {
                context.read<RegistrationBloc>().add(FormSubmitted());
              }
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.all(8),
            ),
            child: state.isSubmitting
                ? const CircularProgressIndicator()
                : Text(
              "REGISTER",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        );
      },
    );
  }
}
