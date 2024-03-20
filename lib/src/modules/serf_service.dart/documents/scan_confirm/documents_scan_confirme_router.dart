import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/documents/scan_confirm/documents_scan_confirm_page.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/documents/scan_confirm/documents_scan_confirme_controller.dart';
import 'package:lab_clinicas_self_service/src/repository/documents/documents_repository.dart';
import 'package:lab_clinicas_self_service/src/repository/documents/documents_repository_impl.dart';

class DocumentsScanConfirmRouter extends FlutterGetItModulePageRouter {
  const DocumentsScanConfirmRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<DocumentsRepository>(
          (i) => DocumentsRepositoryImpl(
            restClient: i(),
          ),
        ),
        Bind.lazySingleton((i) => DocumentsScanConfirmController(documentsRepository: i())),
      ];

  @override
  WidgetBuilder get view => (_) => DocumentsScanConfirmPage();
}
