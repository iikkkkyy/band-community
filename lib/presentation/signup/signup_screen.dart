import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                key: const ValueKey(1),
                validator: (value) {
                  //TODO Validation 구현
                  if(value!.isEmpty || value.length < 4) {
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
                // onSaved: (value) {
                //   viewModel.userEmail = value!;
                // },
                // onChanged: (value) {
                //   viewModel.userEmail = value;
                // },
              ),
            ),
            SizedBox(height: 13,),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                key: const ValueKey(2),
                validator: (value) {
                  //TODO Validation 구현
                  if(value!.isEmpty || value.length < 4) {
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
                // onSaved: (value) {
                //   viewModel.userPassword = value!;
                // },
                // onChanged: (value) {
                //   viewModel.userPassword = value;
                // },
              ),
            ),
            SizedBox(height: 13,),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                key: const ValueKey(2),
                validator: (value) {
                  //TODO Validation 구현
                  if(value!.isEmpty || value.length < 4) {
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
                // onSaved: (value) {
                //   viewModel.userPassword = value!;
                // },
                // onChanged: (value) {
                //   viewModel.userPassword = value;
                // },
              ),
            ),
            SizedBox(height: 20,),
            TextButton(
              onPressed: () {
                // viewModel.tryValidation();
                // print('Email : ${viewModel.userEmail}');
                // print('Password : ${viewModel.userPassword}');
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
