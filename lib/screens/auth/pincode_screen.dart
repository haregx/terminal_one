import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/widgets/buttons/button3d.dart';
import 'package:terminal_one/widgets/buttons/ghost_button.dart';
import 'package:terminal_one/utils/responsive_layout.dart';
import 'package:terminal_one/widgets/app_logo.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/appbar_aware_safe_area.dart';
import 'package:terminal_one/widgets/responsive_code_input.dart';

class PincodeScreen extends StatefulWidget {
  const PincodeScreen({
    super.key, 
    required this.pubGuid, 
    required this.confirmedIdent
  });

  final String pubGuid;
  final String confirmedIdent;

  @override
  State<PincodeScreen> createState() => _PincodeScreenState();
}

class _PincodeScreenState extends State<PincodeScreen> {
  String _pincode = '';

  @override
  Widget build(BuildContext context) {
    return GlassmorphismScaffold(
      title: Text('home.enter_pin'.tr()),
      body: AppBarAwareSafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: ResponsiveSpacing.large(context),
                    children: [
                      const AppLogo(
                        size: LogoSize.medium,
                        variant: LogoVariant.minimal,
                      ),
                       Text(
                          'Zur Bestätigund Deiner Registrierung gib die PIN ein, die wir Dir an Deine E-Mail-Adresse ${widget.confirmedIdent} gesendet haben.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ResponsiveCodeInput(
                        codeLength: 4,
                        onChanged: (value) {
                          setState(() {
                            _pincode = value;
                          });
                        },
                        onCompleted: (value) {
                          setState(() {
                            _pincode = value;
                          });
                        },
                        onValid: (isValid) {
                          // Optional: handle validity
                        },
                      ),
                      IntrinsicWidth(
                        child: Button3D(
                          label: 'common.submit'.tr(),
                          enabled: _pincode.length == 4,
                          onPressed: _pincode.length == 4
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Pincode entered: $_pincode')),
                                  );
                                }
                              : null,
                        ),
                      ),
                      GhostButton(
                        leading: LucideIcons.x,
                        onPressed: () {
                          
                        }, 
                        label: 'home.clear_code'.tr(),
                      ),
                      SizedBox(height: 16),

                      GhostButton(
                        leading: LucideIcons.recycle,
                        onPressed: () {
                          
                        }, 
                        label: 'Code neu zusenden lassen',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
