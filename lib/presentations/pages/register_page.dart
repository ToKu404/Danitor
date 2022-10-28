import 'package:danitor/core/themes/color_const.dart';
import 'package:danitor/presentations/providers/danitor_notifier.dart';
import 'package:danitor/presentations/providers/register_notifier.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/routes/route_names.dart';
import '../providers/auth_notifier.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.watch<RegisterNotifier>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (provider.resultState == RequestState.success && provider.isRegister) {
        Navigator.pushReplacementNamed(context, LOGIN_ROUTE_NAME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterNotifier>();

    return Scaffold(
      body: Center(
        child: Builder(builder: (context) {
          if (provider.resultState == RequestState.loading) {
            return CircularProgressIndicator(
              color: kGreen,
            );
          } else if (provider.resultState == RequestState.init) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Buat',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: kGreyDark,
                      ),
                      children: [
                        TextSpan(
                          text: ' Akun Baru',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: kGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kGreyDark,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: kWhite,
                          ),
                        ),
                        _EmailField(
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Nama',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: kWhite,
                          ),
                        ),
                        _NamaField(
                          controller: nameController,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Kata Sandi',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: kWhite,
                          ),
                        ),
                        _PasswordField(
                          controller: passwordController,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Konfirmasi Kata Sandi',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: kWhite,
                          ),
                        ),
                        _ConfirmPasswordField(
                          controller: repasswordController,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () async {
                            final email = emailController.text;
                            final name = nameController.text;
                            final password = passwordController.text;
                            final repassword = repasswordController.text;
                            if (email.isNotEmpty &&
                                name.isNotEmpty &&
                                password.isNotEmpty &&
                                repassword == password) {
                              provider.register(email, password, name);
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Data Register Salah'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              'Daftar',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Sudah memiliki akun?  ',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: kGreyDark,
                      ),
                      children: [
                        TextSpan(
                          text: 'Masuk',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacementNamed(
                                context, LOGIN_ROUTE_NAME),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: kGreen,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Text(provider.message);
          }
        }),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  final TextEditingController controller;
  const _EmailField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {},
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: kWhite,
      ),
      cursorColor: kGreen,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kWhite, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kGreen, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        // errorText: !state.isEmailValid
        //     ? 'Please ensure the email entered is valid'
        //     : null,
        // labelText: 'Email',
      ),
    );
  }
}

class _NamaField extends StatelessWidget {
  final TextEditingController controller;
  const _NamaField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {},
      keyboardType: TextInputType.text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: kWhite,
      ),
      cursorColor: kGreen,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kWhite, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kGreen, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        // errorText: !state.isEmailValid
        //     ? 'Please ensure the email entered is valid'
        //     : null,
        // labelText: 'Email',
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const _PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isHide = ValueNotifier(true);

    return ValueListenableBuilder<bool>(
        valueListenable: isHide,
        builder: (context, data, _) {
          return TextFormField(
            onChanged: (value) {},
            controller: controller,
            keyboardType: TextInputType.visiblePassword,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: kWhite,
            ),
            cursorColor: kGreen,
            obscureText: data,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kWhite, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kGreen, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffixIcon: IconButton(
                onPressed: () async {
                  isHide.value = !data;
                },
                icon: const Icon(
                  Icons.visibility,
                  color: Colors.white,
                ),
              ),
              // errorText: !state.isEmailValid
              //     ? 'Please ensure the email entered is valid'
              //     : null,
              // labelText: 'Email',
            ),
          );
        });
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  const _ConfirmPasswordField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isHide = ValueNotifier(true);
    return ValueListenableBuilder<bool>(
        valueListenable: isHide,
        builder: (context, data, _) {
          return TextFormField(
            controller: controller,
            onChanged: (value) {},
            keyboardType: TextInputType.visiblePassword,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: kWhite,
            ),
            obscureText: data,
            cursorColor: kGreen,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kWhite, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kGreen, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffixIcon: IconButton(
                onPressed: () async {
                  isHide.value = !data;
                },
                icon: const Icon(
                  Icons.visibility,
                  color: Colors.white,
                ),
              ),
              // errorText: !state.isEmailValid
              //     ? 'Please ensure the email entered is valid'
              //     : null,
              // labelText: 'Email',
            ),
          );
        });
  }
}
