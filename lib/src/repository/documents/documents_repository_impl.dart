import 'dart:developer';
import 'dart:typed_data';
import 'package:clinic_core/clinic_core.dart';
import 'package:dio/dio.dart';
import 'package:lab_clinicas_self_service/src/repository/documents/documents_repository.dart';

class DocumentsRepositoryImpl implements DocumentsRepository {
  DocumentsRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, String>> uploadImage(Uint8List file, String fileName) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(file, filename: fileName),
      });
      final Response(data: {'url': pathImage}) = await restClient.auth.post('/uploads', data: formData);
      return Right(pathImage);
    } on DioException catch (e, s) {
      log('Error on uploadImage', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
