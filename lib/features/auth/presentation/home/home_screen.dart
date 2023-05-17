import 'package:base_clean_architecture/core/core.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget{
  final String data;
  const HomePage({super.key, required this.data});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Parent(
      child: Center(child: Text(widget.data)),
    );
  }
}