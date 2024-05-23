//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
//
// import '../config/app_appearance_cubit.dart';
// import '../config/routes.dart';
// import '../models/profile_model.dart';
// import '../pages/login/login_bloc.dart';
// import '../pages/login/login_page.dart';
// import '../pages/registation/regisitration_bloc.dart';
// import '../pages/registation/regisitration_screen.dart';
// import '../pages/splash_page.dart';
// import '../themes/theme_provider.dart';
//
// class MyApp extends StatefulWidget {
//   final AppAppearanceState _appearanceState;
//
//   const MyApp(this._appearanceState, {super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider.value(
//       value: true,
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (context) => AppAppearanceCubit(
//                 widget._appearanceState.themeData,
//                 widget._appearanceState.locale),
//           ),
//         ],
//         child: AppView(),
//       ),
//     );
//   }
// }
//
// class AppView extends StatelessWidget {
//    AppView({super.key});
//    final UserDetailsDao _userDetailsDao = UserDetailsDao();
//   @override
//   Widget build(BuildContext context) {
//
//         return MaterialApp(
//           title: "Registartion",
//           debugShowCheckedModeBanner: false,
//           theme: Provider.of<ThemeProvider>(context).themeData,
//           initialRoute: AppRoutes.splash,
//           routes: _registerRoutes(context),
//         );
//
//   }
//
//   Map<String, WidgetBuilder> _registerRoutes(BuildContext context) {
//     return <String, WidgetBuilder>{
//       AppRoutes.splash: (context) => SplashPage(),
//       AppRoutes.login: (context) => _buildLoginBloc(context),
//       AppRoutes.register: (context) => _buildRegister(context),
//       // Register other routes similarly
//     };
//   }
//
//   BlocProvider<LoginBloc> _buildLoginBloc(BuildContext context) {
//     return BlocProvider<LoginBloc>(
//       create: (context) => LoginBloc(),
//       child: const LoginPage(),
//     );
//   }
//    BlocProvider<RegistrationBloc> _buildRegister(BuildContext context) {
//      return BlocProvider<RegistrationBloc>(
//        create: (context) => RegistrationBloc(_userDetailsDao),
//        child:  RegistrationScreen(), // Correct the child widget to RegistrationScreen
//      );
//    }
//
// }
