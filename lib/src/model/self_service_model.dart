import 'package:flutter/material.dart';
import 'package:lab_clinicas_self_service/src/model/patient_model.dart';

enum DocumentType {
  healthInsuranceCard,
  medicalOrder,
}

final class SelfServiceModel {
  final String? name;
  final String? lastName;
  final PatientModel? patient;
  final Map<DocumentType, List<String>>? documents;

  const SelfServiceModel({
    this.name,
    this.lastName,
    this.patient,
    this.documents,
  });

  SelfServiceModel clear() {
    return copyWith(
      name: () => null,
      lastName: () => null,
      patient: () => null,
      documents: () => null,
    );
  }

  SelfServiceModel copyWith({
    ValueGetter<String?>? name,
    ValueGetter<String?>? lastName,
    ValueGetter<PatientModel?>? patient,
    ValueGetter<Map<DocumentType, List<String>>?>? documents,
  }) {
    return SelfServiceModel(
      name: name != null ? name() : this.name,
      lastName: lastName != null ? lastName() : this.lastName,
      patient: patient != null ? patient() : this.patient,
      documents: documents != null ? documents() : this.documents,
    );
  }
}
