import 'package:flutter/material.dart';
import 'package:movie_ui_demo/screen/signup_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller!);

    controller!.forward();

    controller!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xff003cc0),
          body: Column(
            children: [
              const Spacer(),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Opacity(
                            opacity: animation!.value,
                            child: const Text(
                              'WELCOME',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff003cc0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                          const SizedBox(height: 35),
                          Opacity(
                            opacity: animation!.value,
                            child: const Text(
                              'Please follow the steps to complete your registration.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff003cc0), fontSize: 22),
                            ),
                          ),
                          const Spacer(),
                          Opacity(
                            opacity: animation!.value,
                            child: MaterialButton(
                                minWidth: 60,
                                height: 60,
                                color: const Color(0xff003cc0),
                                shape: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(100)),
                                child: const Icon(Icons.arrow_forward_ios,
                                    size: 30, color: Colors.white),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => SignupScreen()));
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          )),
    );
  }
}
