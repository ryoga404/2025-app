import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'password_validator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyAuthPage(),
    );
  }
}

class MyAuthPage extends StatefulWidget {
  const MyAuthPage({super.key});

  @override
  _MyAuthPageState createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();

  String newUserEmail = "";
  String newUserPassword = "";
  String loginUserEmail = "";
  String loginUserPassword = "";
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Auth")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 登録フォーム
            Text("【ユーザー登録】", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "メールアドレス"),
                    onChanged: (value) => newUserEmail = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'メールを入力してください';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "パスワード（8〜20文字、小大英字・数字・記号）",
                    ),
                    obscureText: true,
                    onChanged: (value) => newUserPassword = value,
                    validator: (value) => PasswordValidator.getError(value ?? ""),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        setState(() {
                          infoText = "入力内容にエラーがあります";
                        });
                        return;
                      }
                      try {
                        final auth = FirebaseAuth.instance;
                        final result = await auth.createUserWithEmailAndPassword(
                          email: newUserEmail,
                          password: newUserPassword,
                        );
                        setState(() => infoText = "登録OK：${result.user?.email}");
                      } catch (e) {
                        setState(() => infoText = "登録NG：$e");
                      }
                    },
                    child: Text("ユーザー登録"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),
            Divider(),
            SizedBox(height: 16),

            /// ログインフォーム
            Text("【ログイン】", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Form(
              key: _loginFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "メールアドレス"),
                    onChanged: (value) => loginUserEmail = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'メールを入力してください';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "パスワード"),
                    obscureText: true,
                    onChanged: (value) => loginUserPassword = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'パスワードを入力してください';
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      if (!_loginFormKey.currentState!.validate()) {
                        setState(() {
                          infoText = "入力内容にエラーがあります";
                        });
                        return;
                      }
                      try {
                        final auth = FirebaseAuth.instance;
                        final result = await auth.signInWithEmailAndPassword(
                          email: loginUserEmail,
                          password: loginUserPassword,
                        );
                        setState(() => infoText = "ログインOK：${result.user?.email}");
                      } catch (e) {
                        setState(() => infoText = "ログインNG：$e");
                      }
                    },
                    child: Text("ログイン"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),
            Text(infoText, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
