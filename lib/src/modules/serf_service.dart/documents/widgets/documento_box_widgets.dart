import 'package:clinic_core/clinic_core.dart';
import 'package:flutter/material.dart';

class DocumentoBoxWidget extends StatelessWidget {
  const DocumentoBoxWidget({
    super.key,
    required this.uploaded,
    required this.icon,
    required this.label,
    required this.totalFiles,
    this.onTap,
  });
  final bool uploaded;
  final Widget icon;
  final String label;
  final int totalFiles;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final totalFilesLabel = totalFiles > 0 ? totalFiles : '';
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: uploaded ? LabClinicasTheme.lightOrangeColor : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: LabClinicasTheme.orangeColor),
          ),
          child: Column(
            children: [
              Expanded(child: icon),
              Text('$label $totalFilesLabel',
                  style:
                      const TextStyle(color: LabClinicasTheme.orangeColor, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
