import 'package:clinic_core/clinic_core.dart';
import 'package:lab_clinicas_self_service/src/model/patient_model.dart';

typedef RegisterPatientAdderessModel = ({
  String cep,
  String streetAddress,
  String number,
  String addressComplement,
  String state,
  String city,
  String district,
});

typedef RegisterPatientModel = ({
  String name,
  String email,
  String phoneNumber,
  String document,
  String guardian,
  String guardianIdentificationNumber,
  RegisterPatientAdderessModel address,
});

abstract interface class PatientRepository {
  Future<Either<RepositoryException, PatientModel?>> findPatientByDocument(String document);

  Future<Either<RepositoryException, Unit>> update(PatientModel patient);

  Future<Either<RepositoryException, PatientModel>> register(RegisterPatientModel patient);
}
