import 'package:clinic_core/clinic_core.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_self_service/src/env.dart';

class LabClinicasApplicationBindings extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton<RestClient>((i) => RestClient(Env.backendBaseUrl)),
      ];
}
