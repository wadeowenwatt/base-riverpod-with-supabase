import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_images.dart';

class TodoDetailPage extends StatefulWidget {
  const TodoDetailPage({super.key});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: width,
                  height: height * 0.15,
                  child: Image.asset(
                    AppImages.appBarBackground,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
