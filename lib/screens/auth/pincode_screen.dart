import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/components/buttons/ghost_button.dart';
import 'package:terminal_one/components/buttons/primary_button.dart';
import 'package:terminal_one/l10n/app_localizations.dart';
import 'package:terminal_one/utils/responsive_layout.dart';
import 'package:terminal_one/widgets/app_logo.dart';
import 'package:terminal_one/widgets/glassmorphism_scaffold.dart';
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
    final localizations = AppLocalizations.of(context)!;
    return GlassmorphismScaffold(
      title: Text(localizations.enterPin),
      body: SafeArea(
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
                      PrimaryButton(
                        label: localizations.submit,
                        enabled: _pincode.length == 4,
                        onPressed: _pincode.length == 4
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Pincode entered: $_pincode')),
                                );
                              }
                            : null,
                      ),
                      GhostButton(
                        leading: LucideIcons.x,
                        onPressed: () {
                          
                        }, 
                        label: AppLocalizations.of(context)!.clearCode,
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
