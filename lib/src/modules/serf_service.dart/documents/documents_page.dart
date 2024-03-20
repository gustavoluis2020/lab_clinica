import 'package:clinic_core/clinic_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/documents/widgets/documento_box_widgets.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/self_service_controller.dart';
import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/widget/lab_clinicas_self_service_app_bar.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> with MessageViewMixin {
  final selfServiceController = Injector.get<SelfServiceController>();

  @override
  void initState() {
    messageListener(selfServiceController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final documents = selfServiceController.model.documents;
    final healthInsuranceCard = documents?[DocumentType.healthInsuranceCard]?.length ?? 0;
    final medicalOrder = documents?[DocumentType.medicalOrder]?.length ?? 0;

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
            child: Column(
              children: [
                Image.asset('assets/images/folder.png'),
                const SizedBox(height: 24),
                const Text(
                  'Adicionar documentos',
                  style: LabClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Selecione documento que deseja fotografar',
                  style: LabClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 300,
                  width: mediaQuery.size.width * 0.8,
                  child: Row(
                    children: [
                      DocumentoBoxWidget(
                        uploaded: healthInsuranceCard > 0,
                        icon: Image.asset('assets/images/id_card.png'),
                        label: 'Carterinha do convênio',
                        totalFiles: healthInsuranceCard,
                        onTap: () async {
                          final filePath = await Navigator.of(context).pushNamed('/self-service/documents/scan');
                          if (filePath != null && filePath != '') {
                            selfServiceController.registerDocument(
                                DocumentType.healthInsuranceCard, filePath.toString());
                            setState(() {});
                          }
                        },
                      ),
                      const SizedBox(width: 32),
                      DocumentoBoxWidget(
                        uploaded: medicalOrder > 0,
                        icon: Image.asset('assets/images/document.png'),
                        label: 'Pedido médico',
                        totalFiles: medicalOrder,
                        onTap: () async {
                          final filePath = await Navigator.of(context).pushNamed('/self-service/documents/scan');
                          if (filePath != null && filePath != '') {
                            selfServiceController.registerDocument(DocumentType.medicalOrder, filePath.toString());
                            setState(() {});
                          }
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Visibility(
                  visible: healthInsuranceCard > 0 && medicalOrder > 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              fixedSize: const Size.fromHeight(48)),
                          onPressed: () {
                            selfServiceController.clearDocument();
                            setState(() {});
                          },
                          child: const Text('Remover Todas'),
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: LabClinicasTheme.orangeColor, fixedSize: const Size.fromHeight(48)),
                          onPressed: () async {
                            await selfServiceController.finalize();
                          },
                          child: const Text('Finalizar'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
