import 'package:flutter/material.dart';
import 'package:mark_and_check/go_router/app_router.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Padding(
          //TODO 個別のPadding
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Text(
                'Let\'s Mark!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    AppRouter.toMarkModeSelect(context);
                  },
                  child: const Text('Mark'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
