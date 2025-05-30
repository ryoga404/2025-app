import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Extra',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();

  String user_id = "";
  String user_id_dis = "";
  String u_pass = "";
  String pass_dis = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Extra'),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'ログイン',
                    style : TextStyle(
                      fontSize: 20,
                    ),
                ),
                TextFormField(
                  onChanged: (value) {
                    user_id = value;
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'ユーザーIDを入力してください';
                    }
                    if (value.contains('-')) {
                      return '「-」は使用できません';
                    }
                    if (value.length > 21) {
                      return 'ユーザIDは２０文字以内です。';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'User ID *',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    u_pass = value;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password_rounded),
                    labelText: 'Password *',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.numbers),
                    labelText: 'Invite Code',
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        user_id_dis = user_id;
                        pass_dis = u_pass;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LoginedPage(userId: user_id_dis),
                        ),
                      );
                    }
                  },
                  child: Text('ログイン'),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// LoginedPage（ログイン後の画面）
class LoginedPage extends StatelessWidget {
  final String userId;

  const LoginedPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン完了'),
      ),
      body: Center(
        child: Text(
          'ようこそ、$userId さん！',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
