import 'package:base_clean_architecture/core/widgets/parent.dart';
import 'package:flutter/cupertino.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // context.goNamed(Routes.root.name);
    });
  }


  @override
  Widget build(BuildContext context) {
    return const Parent(
      child: ColoredBox(
        color: Color(0xffffffff),
        child: Center(
          child: Text("Splash Screen"),
        ),
      ),
    );
  }
}
