import 'package:iota/auth/auth_service.dart';
import 'package:iota/auth/signup_screen.dart';
import 'package:iota/widgets/button.dart';
import 'package:iota/widgets/textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();

  bool isLoading = false;

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const Spacer(),
            const Text("iniciar sesión",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
            const SizedBox(height: 50),
            CustomTextField(
              hint: "Escribe tu Email",
              label: "Email",
              controller: _email,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "Escribe la contraseña",
              label: "contraseña",
              isPassword: true,
              controller: _password,
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: "iniciar sesión",
              onPressed: _login,
            ),
            const SizedBox(height: 10),
            isLoading?const CircularProgressIndicator():CustomButton(
              label: "con Google",
              onPressed: () async{
                setState(() {
                  isLoading=true;
                });
              await _auth.loginWithGoogle();
                setState(() {
                  isLoading=false;
                });
              },
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("¿Ya tienes una cuenta? "),
              InkWell(
                onTap: () => goToSignup(context),
                child:
                    const Text("registrate", style: TextStyle(color: Colors.red)),
              )
            ]),
            const Spacer()
          ],
        ),
      ),
    );
  }

  goToSignup(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );

  _login() async {
        await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);


  }
}
