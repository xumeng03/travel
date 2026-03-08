import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundpage extends StatelessWidget {
  const NotFoundpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Not Found!"),
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: Text("返回"),
          ),
        ],
      ),
    );
  }
}
