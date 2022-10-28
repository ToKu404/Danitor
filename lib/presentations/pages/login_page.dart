import 'package:danitor/core/routes/route_names.dart';
import 'package:danitor/core/themes/color_const.dart';
import 'package:danitor/presentations/providers/auth_notifier.dart';
import 'package:danitor/presentations/providers/danitor_notifier.dart';
import 'package:danitor/presentations/providers/login_notifier.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final provider = context.watch<LoginNotifier>();

  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     if (provider.detectionState == RequestState.success &&
  //         provider.userToken != null) {
  //           Navigator.pushNamedAndRemoveUntil(context, newRouteName, (route) => false)

  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginNotifier>();

    return Scaffold(
      body: Center(
        child: Builder(builder: (context) {
          if (provider.detectionState == RequestState.loading) {
            return CircularProgressIndicator(
              color: kGreen,
            );
          } else if (provider.detectionState == RequestState.init) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kGreen),
                        child: SvgPicture.asset(
                          'assets/logo.svg',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Danitor',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: kGreen,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Selamat',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: kGreyDark,
                      ),
                      children: [
                        TextSpan(
                          text: ' Datang',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: kGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Silahkan masukkan akun anda dibawah',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: kGreyDark,
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
                          controller: usernameController,
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () async {
                            final username = usernameController.text;
                            final password = passwordController.text;
                            if (username.isNotEmpty && password.isNotEmpty) {
                              await provider.login(username, password);
                              Provider.of<AuthNotifier>(context, listen: false)
                                  .checkLoginStatus();
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Masukkan Username dan Password'),
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
                              'Masuk',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kWhite,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            final provider = context.read<AuthNotifier>();
                            provider.setAnonymous(true);
                            Navigator.pushReplacementNamed(
                              context,
                              MAIN_ROUTE_NAME,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              'Anonymous',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: kGreyDark,
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
                          text: 'Belum memiliki akun?  ',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: kGreyDark,
                          ),
                          children: [
                        TextSpan(
                          text: 'Daftar',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacementNamed(
                                context, REGISTER_ROUTE_NAME),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: kGreen,
                          ),
                        )
                      ]))
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
      controller: controller,
      onChanged: (value) {},
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

class _PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const _PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  ValueNotifier<bool> isHide = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isHide,
        builder: (context, data, _) {
          return TextFormField(
            controller: widget.controller,
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
