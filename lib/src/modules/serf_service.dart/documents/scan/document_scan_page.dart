import 'package:asyncstate/asyncstate.dart';
import 'package:camera/camera.dart';
import 'package:clinic_core/clinic_core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'package:lab_clinicas_self_service/src/modules/serf_service.dart/widget/lab_clinicas_self_service_app_bar.dart';

class DocumentsScanPage extends StatefulWidget {
  const DocumentsScanPage({super.key});

  @override
  State<DocumentsScanPage> createState() => _DocumentsScanPageState();
}

class _DocumentsScanPageState extends State<DocumentsScanPage> {
  late CameraController cameraController;

  @override
  void initState() {
    cameraController = CameraController(
      Injector.get<List<CameraDescription>>()[0],
      ResolutionPreset.medium,
    );

    super.initState();
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
            child: Column(
              children: [
                Image.asset('assets/images/cam_icon.png'),
                const SizedBox(height: 24),
                const Text(
                  'Tirar a foto agora',
                  style: LabClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Posicione o documento dentro do quadrado abaixo e aperte o botão para tirar a foto.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: LabClinicasTheme.blueColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                FutureBuilder(
                    future: cameraController.initialize(),
                    builder: (context, snapshot) {
                      switch (snapshot) {
                        case AsyncSnapshot(
                            connectionState: ConnectionState.waiting || ConnectionState.active,
                          ):
                          return const Center(child: CircularProgressIndicator());
                        case AsyncSnapshot(connectionState: ConnectionState.done):
                          if (cameraController.value.isInitialized) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                width: mediaQuery.size.width * 0.5,
                                child: CameraPreview(
                                  cameraController,
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    strokeWidth: 4,
                                    color: LabClinicasTheme.orangeColor,
                                    strokeCap: StrokeCap.square,
                                    dashPattern: const [1, 10, 1, 3],
                                    radius: const Radius.circular(16),
                                    child: const SizedBox.expand(),
                                  ),
                                ),
                              ),
                            );
                          }
                      }
                      return const Center(
                        child: Text('Erro ao carregar a camera'),
                      );
                    }),
                const SizedBox(height: 24),
                SizedBox(
                  width: mediaQuery.size.width * 0.8,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      final nav = Navigator.of(context);
                      final foto = await cameraController.takePicture().asyncLoader();
                      nav.pushNamed('/self-service/documents/scan/confirm', arguments: foto);
                    },
                    child: const Text('Tirar foto'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
