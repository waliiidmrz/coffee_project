import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => Container(
            margin: const EdgeInsets.only(left: 15.0),
            child: Image.asset(
              'assets/images/bisou.jpg',
              width: 150,
              height: 150,
            )),
      ),
      title: Center(
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montez-Regular'),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 254, 254, 254),
      elevation: 0,
      actions: [
        Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
