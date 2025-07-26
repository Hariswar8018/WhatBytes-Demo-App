import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main_navigation/navigation.dart';
import '../send.dart';
import '../global.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool signup = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Global.globalwhite,
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // Show loading indicator
          } else if (state is Authenticated) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyHomePage(title: '')));
            Send.showMessage(context, signup ? "SignUp Successful" : "SignIn Successful", true);
          } else if (state is AuthError) {
            Send.showMessage(context, state.message, false);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            s(160),
            Center(child: Image.asset("assets/logo (4).png", width: 90)),
            s(12),
            Center(child: Text("Let's get Started", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23))),
            s(16),
            Global.text("     Type your Email"),
            s(7),
            Global.textFieldEditor(controller: email),
            s(10),
            Global.text("     Type your Password"),
            s(7),
            Global.textFieldEditor(controller: password),
            s(18),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Center(
                  child: InkWell(
                    onTap: () {
                      if (email.text.isEmpty || password.text.isEmpty) return;
                      if (signup) {
                        context.read<UserBloc>().add(SignupRequested(email: email.text, password: password.text));
                      } else {
                        context.read<UserBloc>().add(LoginRequested(email: email.text, password: password.text));
                      }
                    },
                    child: Container(
                      width: w * 5 / 8,
                      decoration: BoxDecoration(
                        color: Global.globalcolor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 15),
                        child: Center(child: Text(signup ? "SIGN UP" : "LOGIN", style: TextStyle(color: Colors.white, fontSize: 19))),
                      ),
                    ),
                  ),
                );
              },
            ),
            s(29),
            Center(child: Text(signup ? "or SignUp with Social Login" : "or Login with Social Login", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.grey))),
            s(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                s(1),
                ci("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQazseuQBxxvSQ8M8eGA67yPzsozd9MfoyiEw&s"),
                ci("https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Google_Plus_icon_%282015-2019%29.svg/1200px-Google_Plus_icon_%282015-2019%29.svg.png"),
                ci("https://www.shutterstock.com/shutterstock/videos/1079349806/thumb/1.jpg?ip=x480"),
                s(1)
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {
                setState(() {
                  signup = !signup;
                });
              },
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: signup ? 'Not New here ?  ' : "New Here to the App?  ",
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.grey),
                      ),
                      TextSpan(
                        text: signup ? 'Login Now' : "SignUp Now",
                        style: const TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            s(20),
          ],
        ),
      ),
    );
  }

  Widget ci(String url) => CircleAvatar(backgroundImage: NetworkImage(url), radius: 30);
  Widget s(double w) => SizedBox(height: w);
}
