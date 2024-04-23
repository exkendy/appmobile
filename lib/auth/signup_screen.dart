import 'package:iota/auth/auth_service.dart';
import 'package:iota/auth/login_screen.dart';
import 'package:iota/home_screen.dart';
import 'package:iota/widgets/button.dart';
import 'package:iota/widgets/textfield.dart';
import 'package:flutter/material.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();

  final _nombre = TextEditingController();
  final _apellido = TextEditingController();
  final _telefono = TextEditingController();
  final _email = TextEditingController();
  final _user = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nombre.dispose();
    _apellido.dispose();
    _telefono.dispose();
    _email.dispose();
    _user.dispose();
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
            const Text("Registrate",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
              hint: "Escribe tu nombre",
              label: "Nombre",
              controller: _nombre,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hint: "Escribe tu apellido",
              label: "apellido",
              controller: _apellido,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hint: "Escribe tu telefono",
              label: "telefono",
              controller: _telefono,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "escribe tu Email",
              label: "Email",
              controller: _email,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "escribe un usuario",
              label: "usuario",
              controller: _user,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "Escribe una contraseña",
              label: "Contraseña",
              isPassword: true,
              controller: _password,
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: "Registrarse",
              onPressed: _signup,
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("¿Ya tienes una cuenta? "),
              InkWell(
                onTap: () => goToLogin(context),
                child: const Text("inicia sesion", style: TextStyle(color: Colors.red)),
              )
            ]),
            const Spacer()
          ],
        ),
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  HomeScreen()),
      );

  _signup() async {
        await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
        Navigator.pop(context);
  }
}