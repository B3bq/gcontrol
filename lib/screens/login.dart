import 'package:flutter/material.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Kontrolery do przechwytywania tekstu z pól
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ikona lub Logo
              const Icon(
                Icons.sports_soccer,
                size: 100,
                color: Colors.lightGreenAccent,
              ),
              const SizedBox(height: 20),
              const Text(
                "G-Control",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text("Zaloguj się do swojego konta"),
              const SizedBox(height: 30),

              // Pole Email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 15),

              // Pole Hasło
              TextField(
                controller: _passwordController,
                obscureText: true, // Ukrywanie hasła
                decoration: InputDecoration(
                  labelText: 'Hasło',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 25),

              // Przycisk Logowania
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    // Logika logowania
                    print("Email: ${_emailController.text}");
                    print("Hasło: ${_passwordController.text}");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Próba logowania...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    await Future.delayed(const Duration(seconds: 2));
                    // Przekierowanie do strony głównej
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Zaloguj się", style: TextStyle(fontSize: 16)),
                ),
              ),

              const SizedBox(height: 20),

              // Przycisk Rejestracji
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Nie masz konta? "),
                  TextButton(
                    onPressed: () {
                      // Przekierowanie do strony rejestracji
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      "Załóż konto",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}