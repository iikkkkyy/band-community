import 'package:band_community/presentation/signup/signup_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpIdScreen extends StatefulWidget {
  const SignUpIdScreen({super.key});

  @override
  State<SignUpIdScreen> createState() => _SignUpIdScreenState();
}

class _SignUpIdScreenState extends State<SignUpIdScreen> {
  final _idTextController = TextEditingController();
  final _passWordTextController = TextEditingController();
  final _rePassWordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignUpViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '회원가입',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w400,
            height: 0.08,
            letterSpacing: -0.43,
          ),
        ),
      ),
      body: Form(
        key: viewModel.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                key: const ValueKey(1),
                validator: (value) {
                  //TODO Validation 구현
                  if (value!.isEmpty || value.length < 4) {
                    return 'Please enter at least 4 charactors';
                  }
                  return null;
                },
                controller: _idTextController,
                cursorColor: Colors.grey.shade600,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.account_circle),
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: TextStyle(color: Colors.grey[800], fontSize: 14),
                  hintText: '아이디를 입력하세요.',
                ),
                onSaved: (value) {
                  viewModel.userEmail = value!;
                },
                onChanged: (value) {
                  viewModel.userEmail = value;
                },
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                key: const ValueKey(2),
                validator: (value) {
                  //TODO Validation 구현
                  if (value!.isEmpty || value.length < 4) {
                    return 'Please enter at least 4 charactors';
                  }
                  return null;
                },
                controller: _passWordTextController,
                obscureText: true,
                cursorColor: Colors.grey.shade600,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: TextStyle(color: Colors.grey[800], fontSize: 14),
                  hintText: '비밀번호를 입력하세요.',
                ),
                onSaved: (value) {
                  viewModel.userPassword = value!;
                },
                onChanged: (value) {
                  viewModel.userPassword = value;
                },
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                key: const ValueKey(2),
                validator: (value) {
                  //TODO Validation 구현
                  if (value!.isEmpty || value.length < 4) {
                    return 'Please enter at least 4 charactors';
                  }
                  return null;
                },
                controller: _rePassWordTextController,
                obscureText: true,
                cursorColor: Colors.grey.shade600,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: TextStyle(color: Colors.grey[800], fontSize: 14),
                  hintText: '비밀번호를 한번 더 입력하세요.',
                ),
                onSaved: (value) {
                  viewModel.userPassword = value!;
                },
                onChanged: (value) {
                  viewModel.userPassword = value;
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '*영문,특수문자 포함 8~12자',
                    style: TextStyle(
                      color: Color(0xFF515151),
                      fontSize: 12,
                      fontFamily: 'Noto Sans',
                      fontWeight: FontWeight.w400,
                      height: 0.15,
                      letterSpacing: -0.43,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () async {
                viewModel.tryValidation();
                try {
                  await viewModel.authentication.createUserWithEmailAndPassword(
                      email: viewModel.userEmail,
                      password: viewModel.userPassword);
                } catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(
                          'Please Check your email address and password')
                        , backgroundColor: Colors.blue,)
                  );
                }
                print('Email : ${viewModel.userEmail}');
                print('Password : ${viewModel.userPassword}');
              },
              child: Container(
                width: 358,
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '다음',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Noto Sans',
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                        letterSpacing: -0.43,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
