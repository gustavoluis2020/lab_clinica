import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/documents/documents_page.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/documents/scan/document_scan_page.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/documents/scan_confirm/documents_scan_confirme_router.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/done/done_page.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/find_patient/find_patient_router.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/patient/patient_router.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/self_service_controller.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/self_service_page.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/who_i_am/who_i_am.page.dart';
import 'package:lab_clinicas_self_service/src/repository/information_form/information_form_repository.dart';
import 'package:lab_clinicas_self_service/src/repository/information_form/information_form_repository_impl.dart';
import 'package:lab_clinicas_self_service/src/repository/patients/patient_repository.dart';
import 'package:lab_clinicas_self_service/src/repository/patients/patient_repository_impl.dart';

class SelfServiceModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<InformationFormRepository>((i) => InformationFormRepositoryImpl(restClient: i())),
        Bind.lazySingleton((i) => SelfServiceController(informationFormRepository: i())),
        Bind.lazySingleton<PatientRepository>((i) => PatientRepositoryImpl(restClient: i())),
      ];

  @override
  String get moduleRouteName => '/self-service';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const SelfServicePage(),
        '/whoIAm': (context) => const WhoIAmPage(),
        '/find-patient': (context) => const FindPatientRouter(),
        '/patient': (context) => const PatientRouter(),
        '/documents': (context) => const DocumentsPage(),
        '/documents/scan': (context) => const DocumentsScanPage(),
        '/documents/scan/confirm': (context) => const DocumentsScanConfirmRouter(),
        '/done': (context) => DonePage(),
      };
}
