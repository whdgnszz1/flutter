import 'dart:typed_data';
import 'package:firebase_instagram/resources/auth_methods.dart';
import 'package:firebase_instagram/screens/login_screen.dart';
import 'package:firebase_instagram/utils/colors.dart';
import 'package:firebase_instagram/utils/utils.dart';
import 'package:firebase_instagram/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    if (im != null) {
      setState(() {
        _image = im;
      });
    }
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    print(res);

    setState(() {
      _isLoading = false;
    });

    if(res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SignupScreen(),
          )
      );
    }
  }

  void navigateToLogin(){
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        )
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 1,),
              // svg image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              // cicular widget to accept and show our selected file
              Stack(
                children: [
                  _image != null ?
                   CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  ) :
                  const CircleAvatar(
                    radius: 64,
                    backgroundImage: AssetImage('assets/placeholder.png'),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                        Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              // text field input for username
              TextFieldInput(
                hintText: "이름을 입력해주세요.",
                textEditingController: _usernameController,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              // text field input for email
              TextFieldInput(
                hintText: "Email을 입력해주세요.",
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              // text field input for password
              TextFieldInput(
                hintText: "비밀번호를 입력해주세요.",
                textEditingController: _passwordController,
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              // text field input for bio
              TextFieldInput(
                hintText: "직업을 입력해주세요.",
                textEditingController: _bioController,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              // button signup
              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: _isLoading ?
                    const Center(child: CircularProgressIndicator(
                      color: primaryColor,
                    ),) :
                    const Text("회원가입")  ,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(child: Container(), flex: 2,),
              // Transitioning to signing up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("이미 가입된 계정이 있으신가요? "),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text("로그인", style: TextStyle(fontWeight: FontWeight.bold),),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
