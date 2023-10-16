import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sprinf_app/routes/routes.dart';
import 'package:ternav_icons/ternav_icons.dart';

import 'constant.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
                decoration: BoxDecoration(color: HexColor("#0249a7")),
                child: Image.asset(
                  "assets/images/logo-2.png",
                )),
          ),
          DrawerListTile(
            icon: TernavIcons.lightOutline.home_2,
            title: "Dashboard",
            onTap: () {},
          ),
          DrawerListTile(
            icon: TernavIcons.lightOutline.menu,
            title: "Proyectos",
            onTap: () {
              Navigator.pushNamed(context, Routes.projects);
            },
          ),
          DrawerListTile(
            icon: TernavIcons.lightOutline.folder,
            title: "Estudiantes",
            onTap: () {},
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 0,
      leading: Icon(
        icon,
        color: Colors.grey,
        size: 18,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
