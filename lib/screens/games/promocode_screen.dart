import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/components/buttons/ghost_button.dart';
import 'package:terminal_one/components/snackbars/fancy_success_snackbar.dart';
import 'package:terminal_one/utils/responsive_layout.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/inputs/input_code_group.dart';
import '../../utils/platform_utils.dart';
import '../../widgets/responsive_code_input.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/appbar_aware_safe_area.dart';

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
      title: const Text('What is a Promo Code?'),
      content: const Text(
        'Promo codes are special codes that give you access to exclusive content, bonuses, or rewards. Enter the code exactly as provided to unlock your benefits.',
        style: TextStyle(fontSize: 14.0),
      ),
      actions: [
        PlatformDialogAction(
          isDefault: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Got it!'),
        ),
      ],
    );
  }

  Future<void> _redeemPromoCode() async {
    if (!_isCodeComplete || _isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final code = _codeInputKey.currentState?.code ?? '';
      debugPrint('🎁 Redeeming promo code: $code');
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate different responses based on code
      if (code.toUpperCase() == 'WELCOME1' || 
          code.toUpperCase() == 'BONUS123' || 
          code.toUpperCase() == 'SPECIAL1') {
        // Success
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          FancySuccessSnackbar.build('🎉 Promo code redeemed successfully!'),
        );
        
        // Clear the code
        _codeInputKey.currentState?.clearAll();
        setState(() {
          _isCodeComplete = false;
        });
      } else {
        // Invalid code
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(LucideIcons.xCircle, color: Colors.white, size: 20),
                SizedBox(width: 12),
                Text('Invalid promo code. Please check and try again.'),
              ],
            ),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(LucideIcons.alertCircle, color: Colors.white, size: 20),
              SizedBox(width: 12),
              Text('Failed to redeem code. Please try again later.'),
            ],
          ),
          backgroundColor: Colors.orange.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return GlassmorphismScaffold(
      title: const Text('Promo Code'),
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
                              '🎁 Enter Promo Code',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Enter your promotional code to unlock exclusive rewards and bonuses.',
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            GhostButton(
                              leading: LucideIcons.helpCircle,
                              label: 'What is a Promo Code?',
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
                            PrimaryButton(
                              label: _isProcessing ? 'Redeeming...' : 'Redeem Code',
                              enabled: _isCodeComplete && !_isProcessing,
                              leading: _isProcessing ? null : LucideIcons.gift,
                              onPressed: _isCodeComplete && !_isProcessing ? _redeemPromoCode : null,
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
                              label: 'Clear Code',
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
