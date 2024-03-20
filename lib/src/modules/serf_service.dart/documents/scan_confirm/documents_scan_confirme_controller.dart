import 'dart:typed_data';

import 'package:asyncstate/asyncstate.dart';
import 'package:clinic_core/clinic_core.dart';
import 'package:lab_clinicas_self_service/src/repository/documents/documents_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DocumentsScanConfirmController with MessageStateMixin {
  DocumentsScanConfirmController({required this.documentsRepository});

  final DocumentsRepository documentsRepository;

  final pathRemoteStorage = signal<String?>(null);

  Future<void> uploadImage(Uint8List imageBytes, String fileName) async {
    final result = await documentsRepository.uploadImage(imageBytes, fileName).asyncLoader();

    switch (result) {
      case Left():
        showError('Erro ao enviar a imagem');
      case Right(value: final pathFile):
        pathRemoteStorage.value = pathFile;
    }
  }
}
