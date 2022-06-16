import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: AppNotifier.themeNotifier,
        builder: (context, themeMode, _) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              themeMode: themeMode ? ThemeMode.light : ThemeMode.dark,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              home: const HomeScreen());
        });
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getDarkTheme();
    super.initState();
  }

  Future<void> getDarkTheme() async {
    bool? p = await AppNotifier.getDarkTheme();
    print(p);
    setState(() => AppNotifier.themeNotifier.value = p!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          ValueListenableBuilder<bool>(
              valueListenable: AppNotifier.themeNotifier,
              builder: (ctx, mode, _) => Switch(
                  value: mode,
                  activeColor: Colors.white,
                  onChanged: (val) async {
                    AppNotifier.themeNotifier.value =
                        mode == false ? true : false;
                    print(val);
                    AppNotifier.saveDarkTheme(val);
                  })),
          ValueListenableBuilder<bool>(
              valueListenable: AppNotifier.themeNotifier,
              builder: (ctx, mode, _) => IconButton(
                  onPressed: () async {
                    final value = AppNotifier.themeNotifier.value =
                        mode == false ? true : false;
                    print(value);
                    AppNotifier.saveDarkTheme(value);
                  },
                  icon: Icon(
                      !mode ? Icons.brightness_low : Icons.brightness_high))),
          ValueListenableBuilder<int>(
              valueListenable: AppNotifier.themeNotifier1,
              builder: (ctx, mode, _) => IconButton(
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (ctx) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              const SizedBox(height: 10),
                              const Text('Select theme',
                                  style: TextStyle(fontSize: 22)),
                              const Divider(thickness: 1.8),
                              Expanded(
                                  child: GridView.builder(
                                      itemCount: 8,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4),
                                      itemBuilder: (ctx, i) {
                                        return const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor: Colors.black,
                                                ),
                                              )),
                                        );
                                      })),
                              MaterialButton(
                                onPressed: () {},
                                child: const Text('Set theme'),
                                height: 60,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey)),
                                minWidth: double.infinity,
                              )
                            ]),
                          )),
                  icon: const Icon(Icons.more_vert)))
        ]),
        body: ListView.separated(
            itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
            separatorBuilder: (ctx, i) => const Divider(),
            itemCount: 30));
  }
}

class AppNotifier {
  static final themeNotifier = ValueNotifier(false);
  static final themeNotifier1 = ValueNotifier(0);
  static String darkTheme = 'darkTheme';

  static Future<bool?> getDarkTheme() async {
    final s = await SharedPreferences.getInstance();
    return s.getBool(darkTheme) ?? false;
  }

  static Future<bool?> saveDarkTheme(bool value) async {
    final s = await SharedPreferences.getInstance();
    return s.setBool(darkTheme, value);
  }
}
