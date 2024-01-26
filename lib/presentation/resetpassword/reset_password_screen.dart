import 'package:band_community/presentation/resetpassword/reset_password_view_model.dart';
import 'package:band_community/presentation/signup/error_case/firebase_auth_error_code.dart';
import 'package:band_community/presentation/signup/error_case/signup_validation.dart';
import 'package:band_community/presentation/signup/signup_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _idTextController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ResetPasswordViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '비밀번호 재설정',
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
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                key: const ValueKey(1),
                // validator: (value) {
                //   return idValidation(value!);
                // },
                validator: (value) =>
                    CheckValidate().validateEmail(_emailFocus, value!),
                controller: _idTextController,
                cursorColor: Colors.grey.shade600,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.account_circle,
                    size: 20,
                  ),
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: TextStyle(color: Colors.grey[800], fontSize: 14),
                  hintText: '이메일을 입력하세요.',
                ),
                onSaved: (value) {
                  viewModel.userEmail = value!;
                },
                onChanged: (value) {
                  viewModel.userEmail = value;
                },
              ),
            ),
            const SizedBox(
              height: 13,
            ),

            TextButton(
              onPressed: () async {
                bool isValid = viewModel.tryValidation();
                if (isValid) {
                  try {
                    await viewModel.authentication
                        .sendPasswordResetEmail(email: viewModel.userEmail);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('이메일 전송이 완료되었습니다.'),
                      backgroundColor: Colors.blue,
                    ));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(getFireBaseErrorMessage(e.toString())),
                      backgroundColor: Colors.red,
                    ));
                  }
                  print('Email : ${viewModel.userEmail}');
                  context.pop();
                }
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
                      '이메일 전송',
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
