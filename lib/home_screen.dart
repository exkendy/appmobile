import 'package:iota/auth/auth_service.dart';
import 'package:iota/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Bienvenido",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: "Cerrar sesión",
              onPressed: () async {
                await auth.signout();
                Fluttertoast.showToast(
                    msg: "Sesión cerrada exitosamente",
                    backgroundColor: Colors.green);
              },
            )
          ],
        ),
      ),
    );
  }
}
