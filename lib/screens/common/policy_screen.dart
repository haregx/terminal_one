import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:terminal_one/widgets/buttons/button3d_primary.dart';
import 'package:terminal_one/widgets/buttons/ghost_button.dart';
import 'package:terminal_one/widgets/buttons/primary_button.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/appbar_aware_safe_area.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({
    super.key,
    required this.showBottomButtons,
  });

  final bool showBottomButtons;

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {

  @override
  void initState() {
    super.initState();
    fetchSite();
  }


  late String htmlText = '';
  late String title = '';

  @override
  Widget build(BuildContext context) {
    return GlassmorphismScaffold(
      title: const Text('Policy'),
      body: AppBarAwareSafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Html(data: htmlText),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Last updated: January 1, 2023',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              widget.showBottomButtons ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GhostButton(
                    label: 'Ablehnen',
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  IntrinsicWidth(
                    child: PrimaryButton3D(
                      label: 'Akzeptieren',
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      enabled: true,
                    ),
                  ),
                ],
              )
              : const SizedBox.shrink(),
              const SizedBox(height: 16),
            ],
          ),
        ),  
      ),
    );
  }
  
  void fetchSite() {
    setState(() {
      htmlText = '<h1>Policy</h1><p>404</p>';
    });
  }
}
