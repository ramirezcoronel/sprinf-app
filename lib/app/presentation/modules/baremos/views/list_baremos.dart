import 'package:flutter/material.dart';
import 'package:sprinf_app/routes/routes.dart';
import 'package:ternav_icons/ternav_icons.dart';

class ListBaremosScreen extends StatelessWidget {
  const ListBaremosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Baremos'),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(0.0),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(TernavIcons.lightOutline.grid),
                ),
                title: const Text('Baremos - Trayecto I'),
                subtitle: const Text('Fase 1 y 2'),
                trailing: Icon(TernavIcons.lightOutline.arrow_right_1),
                onTap: () => Navigator.pushNamed(context, Routes.baremosDetails,
                    arguments: 'TR1'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              margin: const EdgeInsets.all(0.0),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(TernavIcons.lightOutline.grid),
                ),
                title: const Text('Baremos - Trayecto II'),
                subtitle: const Text('Fase 1 y 2'),
                trailing: Icon(TernavIcons.lightOutline.arrow_right_1),
                onTap: () => Navigator.pushNamed(context, Routes.baremosDetails,
                    arguments: 'TR2'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              margin: const EdgeInsets.all(0.0),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(TernavIcons.lightOutline.grid),
                ),
                title: const Text('Baremos - Trayecto III'),
                subtitle: const Text('Fase 1 y 2'),
                trailing: Icon(TernavIcons.lightOutline.arrow_right_1),
                onTap: () => Navigator.pushNamed(context, Routes.baremosDetails,
                    arguments: 'TR3'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              margin: const EdgeInsets.all(0.0),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(TernavIcons.lightOutline.grid),
                ),
                title: const Text('Baremos - Trayecto IV'),
                subtitle: const Text('Fase 1 y 2'),
                trailing: Icon(TernavIcons.lightOutline.arrow_right_1),
                onTap: () => Navigator.pushNamed(context, Routes.baremosDetails,
                    arguments: 'TR4'),
              ),
            ),
          ],
        ));
  }
}
