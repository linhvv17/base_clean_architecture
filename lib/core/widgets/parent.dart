import 'package:flutter/material.dart';

class Parent extends StatefulWidget{
  final Widget? child;
  final PreferredSize? appBar;
  final Key? scaffoldKey;
  const Parent({
    super.key,
    this.child,
    this.appBar,
    this.scaffoldKey
  });


  @override
  State<StatefulWidget> createState() => _ParentState();

}

class _ParentState extends State<Parent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: widget.child,
      ),
    );
  }
}