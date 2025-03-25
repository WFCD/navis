import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/profile/cubit/profile_cubit.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis_ui/navis_ui.dart';

class ProfileWizard extends StatefulWidget {
  const ProfileWizard({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(context: context, builder: (context) => const ProfileWizard());
  }

  @override
  State<ProfileWizard> createState() => _ProfileWizardState();
}

class _ProfileWizardState extends State<ProfileWizard> {
  late final PageController _controller;

  int _currentPage = 0;

  void _onDetect(BarcodeCapture codes) {
    final accoundId = codes.barcodes.first.displayValue!;

    BlocProvider.of<UserSettingsCubit>(context).updateUsername(accoundId);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.syncingInfoText)));

    BlocProvider.of<ProfileCubit>(context).update(accoundId);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(keepPage: false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      height: size.height * .4,
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: [const _InstructionsPage(), _QrScanner(onDetect: _onDetect)],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerRight,
              child:
                  _currentPage != 0
                      ? OutlinedButton(
                        onPressed: () => _controller.previousPage(duration: Durations.medium1, curve: Curves.easeOut),
                        child: const Text('Back'),
                      )
                      : FilledButton(
                        onPressed: () => _controller.nextPage(duration: Durations.medium1, curve: Curves.easeOut),
                        child: const Text('Next'),
                      ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _InstructionsPage extends StatelessWidget {
  const _InstructionsPage();

  @override
  Widget build(BuildContext context) {
    final introStyle = context.textTheme.bodyLarge;
    final stepsStyle = context.textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: RichText(
        text: TextSpan(
          style: introStyle,
          text:
              'Cephalon Navis can use your read-only profile data to help track your arsenal XP and mastery points.\n\n',
          children: [
            TextSpan(
              text: 'Step 1. Go to ',
              style: stepsStyle,
              children: [
                TextSpan(
                  text: 'https://navisqr.minilabs.dev/\n',
                  style: stepsStyle?.copyWith(color: context.theme.colorScheme.secondary),
                  recognizer: TapGestureRecognizer()..onTap = () => 'https://navisqr.minilabs.dev/'.launchLink(context),
                ),
              ],
            ),
            TextSpan(text: 'Step 2. Upload your EE.log or account ID from cookies\n', style: stepsStyle),
            TextSpan(text: 'Step 3. Tap next and scan the generated QR code\n', style: stepsStyle),
            TextSpan(text: 'Step 4. Profit\n', style: stepsStyle),
          ],
        ),
      ),
    );
  }
}

class _QrScanner extends StatefulWidget {
  const _QrScanner({required this.onDetect});

  final void Function(BarcodeCapture) onDetect;

  @override
  State<_QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<_QrScanner> {
  late final MobileScannerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(formats: [BarcodeFormat.qrCode]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 86, vertical: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: MobileScanner(controller: _controller, onDetect: widget.onDetect),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
