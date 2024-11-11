import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
            ),
            TextFormField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text('Password'),
              ),
            ),
            TextFormField(
              controller: confirmPassword,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text('Konfirmasi Password'),
              ),
            ),
            Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                    onPressed: () async {
                      if (password != confirmPassword) {
                        print('Passwords do not match.');
                        return;
                      }
                      try {
                        final kredensial = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email.text, password: password.text);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text('Register')))
          ],
        ),
      ),
    );
  }
}
