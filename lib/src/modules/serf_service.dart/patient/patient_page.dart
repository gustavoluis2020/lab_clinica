import 'package:brasil_fields/brasil_fields.dart';
import 'package:clinic_core/clinic_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/patient/patient_controller.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/patient/patient_form_controller.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/self_service_controller.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/widget/lab_clinicas_self_service_app_bar.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> with PatientFormController, MessageViewMixin {
  final PatientController controller = Injector.get<PatientController>();

  final formKey = GlobalKey<FormState>();

  final selfServiceController = Injector.get<SelfServiceController>();

  late bool patientFound;

  late bool enableForm;

  @override
  void initState() {
    messageListener(controller);
    final SelfServiceModel(:patient) = selfServiceController.model;
    super.initState();

    patientFound = patient != null;
    enableForm = !patientFound;
    initializeForm(patient);
    effect(() {
      if (controller.nextStep) {
        selfServiceController.updatePatientAndGoDocument(controller.patient);
      }
    });
  }

  @override
  void dispose() {
    // disposeForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: LabClinicasSelfServiceAppBar(),
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              width: mediaQuery.size.width * 0.85,
              margin: const EdgeInsets.only(top: 18),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: LabClinicasTheme.orangeColor),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Visibility(
                        visible: patientFound,
                        replacement: Image.asset('assets/images/lupa_icon.png'),
                        child: Image.asset('assets/images/check_icon.png')),
                    const SizedBox(height: 24),
                    Visibility(
                      visible: patientFound,
                      replacement: const Text('Cadastro não encontrado', style: LabClinicasTheme.titleSmallStyle),
                      child: const Text(
                        'Cadastro encontrado',
                        style: LabClinicasTheme.titleSmallStyle,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Visibility(
                      visible: patientFound,
                      replacement: const Text(
                        'Prrencha o formulário abaixo para fazer o seu cadastro',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: LabClinicasTheme.blueColor,
                        ),
                      ),
                      child: const Text(
                        'Confirmar os dados do seu cadastro',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: LabClinicasTheme.blueColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      readOnly: !enableForm,
                      validator: Validatorless.required('Nome obrigatório'),
                      controller: nameEC,
                      decoration: const InputDecoration(
                        label: Text('Nome do paciente'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      readOnly: !enableForm,
                      validator: Validatorless.multiple([
                        Validatorless.required('Email obrigatório'),
                        Validatorless.email('Email inválido'),
                      ]),
                      controller: emailEC,
                      decoration: const InputDecoration(
                        label: Text('Email'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      readOnly: !enableForm,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, TelefoneInputFormatter()],
                      validator: Validatorless.required('Telefone obrigatório'),
                      controller: phoneEC,
                      decoration: const InputDecoration(
                        label: Text('Telefone de contato'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      readOnly: !enableForm,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, CpfInputFormatter()],
                      validator: Validatorless.required('Cpf obrigatório'),
                      controller: documentEC,
                      decoration: const InputDecoration(
                        label: Text('Digite seu cpf'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      readOnly: !enableForm,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, CepInputFormatter()],
                      validator: Validatorless.required('Cep obrigatório'),
                      controller: cepEC,
                      decoration: const InputDecoration(
                        label: Text('Cep'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: TextFormField(
                            readOnly: !enableForm,
                            validator: Validatorless.required('Endereço obrigatório'),
                            controller: streetEC,
                            decoration: const InputDecoration(
                              label: Text('Endereço'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            readOnly: !enableForm,
                            validator: Validatorless.required('Numero obrigatório'),
                            controller: numberEC,
                            decoration: const InputDecoration(
                              label: Text('Numero'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: !enableForm,
                            controller: complementEC,
                            decoration: const InputDecoration(
                              label: Text('Complemento'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            readOnly: !enableForm,
                            validator: Validatorless.required('Estado obrigatório'),
                            controller: stateEC,
                            decoration: const InputDecoration(
                              label: Text('Estado'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: !enableForm,
                            validator: Validatorless.required('Cidade obrigatório'),
                            controller: cityEC,
                            decoration: const InputDecoration(
                              label: Text('Cidade'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            readOnly: !enableForm,
                            validator: Validatorless.required('Bairro obrigatório'),
                            controller: districtEC,
                            decoration: const InputDecoration(
                              label: Text('Bairro'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      readOnly: !enableForm,
                      controller: guardianEC,
                      decoration: const InputDecoration(
                        label: Text('Responsavel'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      readOnly: !enableForm,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, CpfInputFormatter()],
                      controller: guardianIndentificationNumberEC,
                      decoration: const InputDecoration(
                        label: Text('Responsável identificação'),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Visibility(
                      visible: !enableForm,
                      replacement: SizedBox(
                        width: mediaQuery.size.width * 0.8,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            final valid = formKey.currentState?.validate() ?? false;
                            if (valid) {
                              if (patientFound) {
                                controller.updateAndNext(updatePatient(selfServiceController.model.patient!));
                              } else {
                                controller.saveAndNext(createPatientRegister());
                              }
                            }
                          },
                          child: Visibility(
                              visible: !patientFound,
                              replacement: const Text('Salvar e continuar'),
                              child: const Text('Cadastrar')),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    enableForm = true;
                                  });
                                },
                                child: const Text('Editar'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 17),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.patient = selfServiceController.model.patient!;
                                  controller.goNextStep();
                                },
                                child: const Text('Continuar'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
