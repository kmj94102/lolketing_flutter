import 'package:flutter/material.dart';
import 'package:lolketing_flutter/style/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 23, 24, 29)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 98,
                  width: 188,
                  decoration: const BoxDecoration(color: Colors.cyan),
                ),
                const SizedBox(
                  height: 70,
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: '아이디를 입력해주세요',
                    hintStyle: TextStyle(color: ColorStyle.gray),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorStyle.white), borderRadius: BorderRadius.all(Radius.circular(3))),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorStyle.gray), borderRadius: BorderRadius.all(Radius.circular(3))),

                  ),
                  onChanged: (text) {

                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: '비밀번호를 입력해주세요',
                    hintStyle: TextStyle(color: ColorStyle.gray),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorStyle.white), borderRadius: BorderRadius.all(Radius.circular(3))),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorStyle.gray), borderRadius: BorderRadius.all(Radius.circular(3))),

                  ),
                  onChanged: (text) {

                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        primary: ColorStyle.white,
                        backgroundColor: ColorStyle.mainColor,
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    child: const Text('로그인'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
