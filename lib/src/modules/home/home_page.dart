import 'package:clinic_core/clinic_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: LabClinicasAppBar(
          actions: [
            PopupMenuButton<int>(
                child: const IconPopupMenuWidget(),
                itemBuilder: (context) {
                  return <PopupMenuEntry<int>>[
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text('Iniciar Terminal'),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text('Finalizar Terminal'),
                    ),
                  ];
                })
          ],
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.all(40),
            margin: const EdgeInsets.only(top: 112),
            width: sizeOf.width * .8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: LabClinicasTheme.orangeColor,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Bem Vindo!',
                  style: LabClinicasTheme.titleStyle,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: sizeOf.width * 0.8,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/self-service');
                    },
                    child: const Text('INICIAR TERMINAL'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
