import 'dart:developer';
import 'package:clinic_core/clinic_core.dart';
import 'package:dio/dio.dart';
import 'package:lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:lab_clinicas_self_service/src/repository/information_form/information_form_repository.dart';

class InformationFormRepositoryImpl implements InformationFormRepository {
  InformationFormRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, Unit>> register(SelfServiceModel model) async {
    try {
      final SelfServiceModel(
        :name!,
        :lastName!,
        patient: PatientModel(id: patientId)!,
        documents: {
          DocumentType.healthInsuranceCard: List(first: healthInsuranceCardDoc),
          DocumentType.medicalOrder: medicalOrderDocs,
        }!
      ) = model;

      await restClient.auth.post('/patientInformationForm', data: {
        "patient_id": patientId,
        "health_insurance_card": healthInsuranceCardDoc,
        "medical_order": medicalOrderDocs,
        "password": '$name $lastName',
        "date_created": DateTime.now().toIso8601String(),
        "status": "Waiting",
        "tests": [],
      });
      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao finalizar auto atendimento', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
