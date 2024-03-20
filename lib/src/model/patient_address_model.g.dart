// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientAddressModel _$PatientAddressModelFromJson(Map<String, dynamic> json) =>
    PatientAddressModel(
      cep: json['cep'] as String,
      streetAddress: json['street_address'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
      number: json['number'] as String,
      complement: json['address_complement'] as String? ?? '',
    );

Map<String, dynamic> _$PatientAddressModelToJson(
        PatientAddressModel instance) =>
    <String, dynamic>{
      'cep': instance.cep,
      'street_address': instance.streetAddress,
      'state': instance.state,
      'city': instance.city,
      'district': instance.district,
      'number': instance.number,
      'address_complement': instance.complement,
    };
