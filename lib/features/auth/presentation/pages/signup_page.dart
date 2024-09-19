import 'package:blog/core/common/widgets/snackbar.dart';
import 'package:blog/core/theme/app_pallet.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/pages/login_page.dart';
import 'package:blog/features/auth/presentation/widgets/auth_button.dart';
import 'package:blog/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {

  static MaterialPageRoute route() => MaterialPageRoute(
    builder: (context) => const SignupPage(),
  );

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUp() {

    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        SignUpUserEvent(
          emailController.text,
          nameController.text,
          passwordController.text,
        ),
      );
    } else {
      print("Unsuccess");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthSuccessState) {
              Navigator.push(context, LoginPage.route());
            } else if(state is AuthErrorState) {
              showErrorSnackbar(context, state.message);
            }
          },
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up.",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                AuthField(
                  hintText: "Full Name",
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name cannot be empty.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                AuthField(
                  hintText: "Email",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email cannot be empty.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                AuthField(
                  hintText: "Password",
                  controller: passwordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return AuthButton(
                      text: "Sign Up",
                      onPressed: signUp,
                      isLoading: state is AuthLoadingState,
                    );
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: "Already have an account? ",
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            color: AppPallet.gradient2,
                            fontWeight: FontWeight.w600,
                          ),
                          // onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
