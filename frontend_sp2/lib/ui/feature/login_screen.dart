
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: Column(
              children: [
                Text(
                  "Bienvenido",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}