import 'package:clinic_core/clinic_core.dart';
import 'package:lab_clinicas_self_service/src/model/self_service_model.dart';

abstract interface class InformationFormRepository {
  Future<Either<RepositoryException, Unit>> register(SelfServiceModel model);
}
