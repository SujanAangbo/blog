import 'package:blog/core/common/cubits/user_cubit.dart';
import 'package:blog/core/theme/app_theme.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/pages/login_page.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presentation/pages/blog_page.dart';
import 'package:blog/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<BlogBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedInEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: BlocSelector<UserCubit, UserState, bool?>(
        selector: (state) {
          if (state is UserLoggedInState) {
            print('user: ${state.user}');
            return true;
          } else if (state is UserLoggedOutState) {
            return false;
          } else {
            return null;
          }
        },
        builder: (BuildContext context, bool? isUserLoggedIn) {
          if (isUserLoggedIn == null) {
            // splash screen
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (isUserLoggedIn) {
            return const BlogPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
