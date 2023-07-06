import 'package:flutter/material.dart';

class AppbarCustom extends StatelessWidget implements PreferredSize {
  final String titlePage;

  const AppbarCustom({super.key, required this.titlePage});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titlePage),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.calculate))
      ],
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
