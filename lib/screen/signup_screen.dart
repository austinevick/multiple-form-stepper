import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_ui_demo/screen/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey0 = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  final formkey3 = GlobalKey<FormState>();

  final controller = PageController();
  final fnameController = TextEditingController();
  final snameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  int activeIndex = 0;
  bool isVisible = true;
  TextEditingController getTextController() {
    TextEditingController controller = TextEditingController();
    switch (activeIndex) {
      case 0:
        return controller = fnameController;
      case 1:
        return controller = snameController;
      case 2:
        return controller = phoneController;
      case 3:
        return controller = emailController;
    }
    return controller;
  }

  String getHintText() {
    switch (activeIndex) {
      case 0:
        return 'Enter your first name';
      case 1:
        return 'Enter your surname name';
      case 2:
        return 'Enter your phone number';
      case 3:
        return 'Enter your email address';

      default:
        return '';
    }
  }

  GlobalKey<FormState> getFormKey() {
    // GlobalKey<FormState> formkey = GlobalKey<FormState>();
    switch (activeIndex) {
      case 0:
        return formkey0;
      case 1:
        return formkey1;
      case 2:
        return formkey2;
      case 3:
        return formkey3;
    }
    return formkey0;
  }

  String getFormValidation(String value) {
    switch (activeIndex) {
      case 0:
        value.isEmpty ? 'field is required' : null;
        break;
      case 1:
        value.isEmpty ? 'field is required' : null;
        break;
      case 2:
        value.isEmpty ? 'field is required' : null;
        break;
      case 3:
        value.isEmpty ? 'field is required' : null;
        break;
    }
    return value;
  }

  @override
  void initState() {
    controller.addListener(() {
      if (controller.page == 3) {
        isVisible = false;
      } else {
        isVisible = true;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (activeIndex > 0) {
          controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
          child: Scaffold(
              body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          LinearProgressIndicator(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  items.length,
                  (i) => InkWell(
                        onTap: () => setState(() => activeIndex = i),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: activeIndex == i
                              ? const Color(0xff003cc0)
                              : Colors.grey,
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ))),
          const Spacer(),
          Expanded(
              flex: 3,
              child: PageView.builder(
                controller: controller,
                onPageChanged: (value) => setState(() {
                  activeIndex = value;
                }),
                itemCount: items.length,
                itemBuilder: (context, i) {
                  return SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Card(
                      shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Form(
                          key: getFormKey(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getHintText(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              TextFormField(
                                style: const TextStyle(fontSize: 18),
                                controller: getTextController(),
                                onChanged: (value) => setState(() {
                                  print(value);
                                }),
                                cursorWidth: 1,
                                validator: (value) =>
                                    value!.isEmpty ? 'field is required' : null,
                                autofocus: true,
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff003cc0)))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 4,
                    ),
                  );
                },
              )),
          const Spacer(flex: 1),
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Center(
              child: MaterialButton(
                  minWidth: 200,
                  height: 47,
                  color: const Color(0xff003cc0),
                  shape: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Icon(Icons.arrow_forward_ios,
                      size: 28, color: Colors.white),
                  onPressed: () {
                    if (getFormKey().currentState!.validate()) {
                      if (controller.page == 3) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const HomeScreen()));
                      }
                      controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    }
                  }),
            ),
          )
        ]),
      ))),
    );
  }
}

List<Item> items = [
  Item('1'),
  Item('1'),
  Item('1'),
  Item('1'),
];

class Item {
  final String n;

  Item(this.n);
}
