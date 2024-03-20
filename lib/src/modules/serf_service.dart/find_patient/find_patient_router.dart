import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/find_patient/find_patient_controller.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/find_patient/find_patient_page.dart';

class FindPatientRouter extends FlutterGetItModulePageRouter {
  const FindPatientRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => FindPatientController(patientRepository: i())),
      ];

  @override
  WidgetBuilder get view => (_) => const FindPatientPage();
}
