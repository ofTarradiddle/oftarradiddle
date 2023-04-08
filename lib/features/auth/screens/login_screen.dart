import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/common/loader.dart';
import 'package:reddit_tutorial/core/common/sign_in_button.dart';
import 'package:reddit_tutorial/core/constants/constants.dart';
import 'package:reddit_tutorial/features/auth/controlller/auth_controller.dart';
import 'package:reddit_tutorial/responsive/responsive.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

  // final _emailC = TextEditingController();
  // final _passwordC = TextEditingController();

  void signInAsGuest(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInAsGuest(context);
  }

  // void signInWithEmail(
  //     WidgetRef ref, BuildContext context, String email, String password) {
  //   ref
  //       .read(authControllerProvider.notifier)
  //       .signInWithEmail(context, email, password);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.logoPath,
          height: 40,
        ),
        actions: [
          TextButton(
            onPressed: () => signInAsGuest(ref, context),
            child: const Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Loader()
          : Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Research your Human-ness',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    Constants.loginEmotePath,
                    height: 400,
                  ),
                ),
                const SizedBox(height: 20),
                const Responsive(child: SignInButton()),

// //
//                 //COPY FROM OTHER
//                 //email  text
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       child: TextField(
//                         controller: _emailC,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Email',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 //paswsword
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       child: TextField(
//                         controller: _passwordC,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Password',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 //sign in button
//                 const SizedBox(height: 10),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 25,
//                   ),
//                   child: TextButton(
//                     onPressed: () => signInWithEmail(
//                         ref, context, _emailC.text, _passwordC.text),
//                     child: const Text(
//                       'Sign In',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),

//                 //not a member? register now
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Not a member?',
//                     ),
//                     GestureDetector(
//                       onTap: () {}, //widget.showRegisterPage,
//                       child: const Text(
//                         ' Register now',
//                       ),
//                     ),
//                   ],
//                 )
              ],
            ),
    );
  }
}

// //Auth
// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   bool showLoginPage = true;

//   void toggleScreens() {
//     setState(() {
//       showLoginPage = !showLoginPage;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showLoginPage) {
//       return LoginScreen(showRegisterPage: toggleScreens);
//     } else {
//       return RegisterPage(showLoginPage: toggleScreens);
//     }
//   }
// }

// //Register
// class RegisterPage extends StatefulWidget {
//   final VoidCallback showLoginPage;
//   const RegisterPage({super.key, required this.showLoginPage});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _passwordConfirmController = TextEditingController();
//   final _firstnameController = TextEditingController();
//   final _lastnameController = TextEditingController();
//   final _ageController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _passwordConfirmController.dispose();
//     _firstnameController.dispose();
//     _lastnameController.dispose();
//     _ageController.dispose();

//     super.dispose();
//   }

//   Future signUp() async {
//     if (passwordConfirmed()) {
//       //create user
//       await _auth.createUserWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//       //Add user details
//       addUserDetails(
//           _firstnameController.text.trim(),
//           _lastnameController.text.trim(),
//           int.parse(_ageController.text.trim()),
//           _emailController.text.trim());
//     }
//   }

//   Future addUserDetails(
//       String firstName, String lastName, int age, String email) async {
//     await _auth.collection('users2').add({
//       'first name': firstName,
//       'last name': lastName,
//       'age': age,
//       'email': email,
//     });
//   }

//   bool passwordConfirmed() {
//     if (_passwordConfirmController.text.trim() ==
//         _passwordController.text.trim()) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 //Hello again
//                 const Text(
//                   'Hello There',
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'Register below with your details!!',
//                 ),
//                 const SizedBox(height: 50),

//                 //first name
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       child: TextField(
//                         controller: _firstnameController,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'First Name',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),

//                 //last name                const SizedBox(height: 10),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       child: TextField(
//                         controller: _lastnameController,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Last name ',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),

//                 //age
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       child: TextField(
//                         controller: _ageController,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Age',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),

//                 //email  text
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       child: TextField(
//                         controller: _emailController,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Email',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 //confirm password
//                 const SizedBox(height: 10),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       child: TextField(
//                         controller: _passwordConfirmController,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Confirm Password',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 //paswsword
//                 const SizedBox(height: 10),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       child: TextField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Password',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 //sign in button
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 25,
//                   ),
//                   child: GestureDetector(
//                     onTap: signUp,
//                     child: Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.purple,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           'Sign Up ',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),

//                 //not a member? register now
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'I am a member!',
//                     ),
//                     GestureDetector(
//                       onTap: widget.showLoginPage,
//                       child: const Text(
//                         ' Login',
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// //forgot password
// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({super.key});

//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final _emailC = TextEditingController();

//   @override
//   void dispose() {
//     _emailC.dispose();
//     super.dispose();
//   }

//   Future passwordReset() async {
//     try {
//       await _auth.sendPasswordResetEmail(
//         email: _emailC.text.trim(),
//       );
//       showDialog(
//         context: context,
//         builder: (context) {
//           return const AlertDialog(
//             content: Text("Password reset link sent, check your email!"),
//           );
//         },
//       );
//     } on FirebaseAuthException catch (e) {
//       print(e);
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             content: Text(e.message.toString()),
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.deepPurple,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 "Enter email and we will send you a password reset link. ",
//                 textAlign: TextAlign.center,
//                 //style: TextStyle(fontSize: 20),
//               ),
//             ),

//             //email  text
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   border: Border.all(color: Colors.white),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20.0),
//                   child: TextField(
//                     controller: _emailC,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Email',
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             //paswsword
//             const SizedBox(height: 10),

//             MaterialButton(
//               onPressed: passwordReset,
//               color: Colors.deepPurple[200],
//               child: const Text('Reset Password'),
//             )
//           ],
//         ));
//   }
// }
