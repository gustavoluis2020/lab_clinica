import 'dart:developer';

import 'package:clinic_core/clinic_core.dart';
import 'package:dio/dio.dart';
import 'package:lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:lab_clinicas_self_service/src/repository/patients/patient_repository.dart';

class PatientRepositoryImpl implements PatientRepository {
  PatientRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, PatientModel?>> findPatientByDocument(String document) async {
    try {
      final Response(:List data) = await restClient.auth.get('/patients', queryParameters: {'document': document});
      if (data.isEmpty) {
        return Right(null);
      }

      return Right(PatientModel.fromJson(data.first));
    } on DioException catch (e, s) {
      log('Erro ao buscar paciente por cpf', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, Unit>> update(PatientModel patient) async {
    try {
      await restClient.auth.put('/patients/${patient.id}', data: patient.toJson());
      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao atualizar paciente', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, PatientModel>> register(RegisterPatientModel patient) async {
    try {
      final Response(:data) = await restClient.auth.post('/patients', data: {
        'name': patient.name,
        'email': patient.email,
        'document': patient.document,
        'phone_number': patient.phoneNumber,
        'address': {
          'cep': patient.address.cep,
          'street_address': patient.address.streetAddress,
          'number': patient.address.number,
          'address_complement': patient.address.addressComplement,
          'state': patient.address.state,
          'city': patient.address.city,
          'district': patient.address.district,
        },
        'guardian': patient.guardian,
        'guardian_identification_number': patient.guardianIdentificationNumber,
      });
      return Right(PatientModel.fromJson(data));
    } on DioException catch (e, s) {
      log('Erro ao cadastrar paciente', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
