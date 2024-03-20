import 'package:clinic_core/clinic_core.dart';
import 'package:lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:lab_clinicas_self_service/src/repository/patients/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PatientController with MessageStateMixin {
  PatientController({required PatientRepository patientRepository}) : _patientRepository = patientRepository;

  final PatientRepository _patientRepository;

  PatientModel? patient;

  final _nextStep = signal<bool>(false);
  bool get nextStep => _nextStep.value;

  void goNextStep() {
    _nextStep.value = true;
  }

  Future<void> updateAndNext(PatientModel model) async {
    final updateResult = await _patientRepository.update(model);

    switch (updateResult) {
      case Left():
        showError('Erro ao atualizar paciente');
      case Right():
        showInfo('Paciente atualizado com sucesso');
        patient = model;
        goNextStep();
    }
  }

  Future<void> saveAndNext(RegisterPatientModel resgisterPatientModel) async {
    final result = await _patientRepository.register(resgisterPatientModel);
    switch (result) {
      case Left():
        showError('Erro ao cadastrar paciente');
      case Right(value: final patientModel):
        showInfo('Paciente cadastrado com sucesso');
        patient = patientModel;
        goNextStep();
    }
  }
}
