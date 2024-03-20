import 'dart:typed_data';

import 'package:clinic_core/clinic_core.dart';

abstract interface class DocumentsRepository {
  Future<Either<RepositoryException, String>> uploadImage(
    Uint8List file,
    String fileName,
  );
}
