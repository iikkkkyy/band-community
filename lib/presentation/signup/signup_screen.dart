import 'package:band_community/presentation/signup/error_case/firebase_auth_error_code.dart';
import 'package:band_community/presentation/signup/error_case/signup_validation.dart';
import 'package:band_community/presentation/signup/error_case/supabase_auth_error_code.dart';
import 'package:band_community/presentation/signup/phone_number_formatter.dart';
import 'package:band_community/presentation/signup/signup_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameTextController = TextEditingController();
  final _idTextController = TextEditingController();
  final _passWordTextController = TextEditingController();
  final _rePassWordTextController = TextEditingController();
  final _phoneNumberTextController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

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
            // UserName
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                focusNode: _nameFocus,
                keyboardType: TextInputType.text,
                key: const ValueKey(3),
                validator: (value) =>
                    CheckValidate().validateName(_nameFocus, value!),
                controller: _nameTextController,
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
                  hintText: '닉네임을 입력하세요.',
                ),
                onSaved: (value) {
                  viewModel.userName = value!;
                },
                onChanged: (value) {
                  viewModel.userName = value;
                },
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                focusNode: _phoneFocus,
                keyboardType: TextInputType.phone,
                key: const ValueKey(4),
                validator: (value) =>
                    CheckValidate().validatePhone(_emailFocus, value!),
                controller: _phoneNumberTextController,
                cursorColor: Colors.grey.shade600,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.phone,
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
                  hintText: '전화번호를 입력하세요.',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  PhoneNumberFormatter()
                ],
                onSaved: (value) {
                  viewModel.userPhone = value!;
                },
                onChanged: (value) {
                  viewModel.userPhone = value;
                },
              ),
            ),
            const SizedBox(
              height: 13,
            ),
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
                    Icons.email_outlined,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                focusNode: _passwordFocus,
                key: const ValueKey(2),
                validator: (value) =>
                    CheckValidate().validatePassword(_passwordFocus, value!),
                controller: _passWordTextController,
                obscureText: true,
                cursorColor: Colors.grey.shade600,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock,
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
            const SizedBox(
              height: 13,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                key: const ValueKey(2),
                validator: (value) => CheckValidate().validateRePassword(
                    _emailFocus, value!, _passWordTextController.text),
                controller: _rePassWordTextController,
                obscureText: true,
                cursorColor: Colors.grey.shade600,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock,
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
              padding: EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '*영문,특수문자 포함 8~15자',
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
                viewModel.signUp(context);
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
