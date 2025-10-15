import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/widgets/buttons/button3d_primary.dart';
import 'package:terminal_one/widgets/buttons/ghost_button.dart';
import 'package:terminal_one/screens/games/game_details_screen.dart';
import 'package:terminal_one/utils/responsive_layout.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/input_code_group.dart';
import '../../utils/platform_utils.dart';
import '../../widgets/responsive_code_input.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/appbar_aware_safe_area.dart';
import 'package:easy_localization/easy_localization.dart';

/// PromoCode Screen - Allows users to enter promotional codes
/// 
/// Features promo code input with validation, help dialog, and 
/// navigation to more games or back to previous screen
class PromoCodeScreen extends StatefulWidget {
  final int codeLength;
  const PromoCodeScreen({
    super.key,
    this.codeLength = 6, // Promo codes are typically longer
  });

  @override
  State<PromoCodeScreen> createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  bool _isCodeComplete = false;
  bool _isProcessing = false;
  final GlobalKey<InputCodeGroupState> _codeInputKey = GlobalKey<InputCodeGroupState>();

  void _showPromoCodeInfo(BuildContext context) {
    PlatformUtils.showPlatformDialog(
      context: context,
      title: Text('home.what_is_promo_code'.tr()),
      content: Text(
        'home.promo_code_explanation'.tr(),
        style: const TextStyle(fontSize: 14.0),
      ),
      actions: [
        PlatformDialogAction(
          isDefault: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('home.understood'.tr()),
        ),
      ],
    );
  }

 
  @override
  Widget build(BuildContext context) {
    
    return GlassmorphismScaffold(
      title: Text('navigation.promocode'.tr()),
      body: AppBarAwareSafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: ResponsiveSpacing.large(context),
                          children: [
                            SizedBox(height: ResponsiveSpacing.large(context)),
                            const AppLogo(
                              size: LogoSize.large,
                              variant: LogoVariant.minimal,
                            ),
                           
                            Text(
                              'home.enter_access_code'.tr(),
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            GhostButton(
                              leading: LucideIcons.helpCircle,
                              label: 'home.what_is_promo_code'.tr(),
                              onPressed: () {
                                _showPromoCodeInfo(context);
                              },
                            ),
                            ResponsiveCodeInput(
                              codeInputKey: _codeInputKey,
                              codeLength: widget.codeLength,
                              onChanged: (value) {
                                setState(() {
                                  _isCodeComplete = false;
                                });
                                debugPrint('Promo code input: $value');
                              },
                              onCompleted: (value) {
                                setState(() {
                                  _isCodeComplete = value.length == widget.codeLength && value.isNotEmpty;
                                });
                                debugPrint('Promo code completed: $value (${widget.codeLength} characters)');
                              },
                              onValid: (isValid) {
                                setState(() {
                                  _isCodeComplete = isValid;
                                });
                                debugPrint('Promo code validity changed: $isValid');
                              },
                            ),
                            IntrinsicWidth(
                              child: PrimaryButton3D(
                                label: _isProcessing ? 'common.loading'.tr() : 'promocode.redeem'.tr(),
                                enabled: _isCodeComplete && !_isProcessing,
                                leadingIcon: _isProcessing ? null : LucideIcons.gift,
                                onPressed: _isCodeComplete && !_isProcessing 
                                  ? () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const GameDetailsScreen(),
                                        ),
                                      );
                                    }
                                  : null,
                              ),
                            ),
                            GhostButton(
                              leading: LucideIcons.x,
                              onPressed: _isProcessing ? null : () {
                                _codeInputKey.currentState?.clearAll();
                                setState(() {
                                  _isCodeComplete = false;
                                });
                                debugPrint('Promo code cleared');
                              },
                              label: 'home.clear_code'.tr(),
                            ),
                          ],
                        ),
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
