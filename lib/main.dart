import 'dart:async';
import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:clinic_core/clinic_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_self_service/pages/splash_page.dart';
import 'package:lab_clinicas_self_service/src/bindings/lab_clinicas_application_bindings.dart';
import 'package:lab_clinicas_self_service/src/modules/auth/auth_module.dart';
import 'package:lab_clinicas_self_service/src/modules/home/home_module.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/self_service_module.dart';

late List<CameraDescription> _cameras;

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
    runApp(const LabClinicasSelfServiceApp());
  }, (error, stack) {
    log('Erro não tratado', error: error, stackTrace: stack);
    throw error;
  });
}

class LabClinicasSelfServiceApp extends StatelessWidget {
  const LabClinicasSelfServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicCoreConfig(
      title: 'Clinic One',
      bindings: LabClinicasApplicationBindings(),
      pagesBuilders: [FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/')],
      modules: [AuthModule(), HomeModule(), SelfServiceModule()],
      didStart: () {
        FlutterGetItBindingRegister.registerPermanentBinding(
          'CAMERAS',
          [
            Bind.lazySingleton((i) => _cameras),
          ],
        );
      },
    );
  }
}
