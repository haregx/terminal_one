import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:terminal_one/widgets/buttons/button3d.dart';
import 'package:terminal_one/widgets/buttons/ghost_button.dart';
import 'package:easy_localization/easy_localization.dart';
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
      title: Text('navigation.policy'.tr()),
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
              Text(
                'common.last_updated'.tr(namedArgs: {'date': 'January, 2023'}),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              widget.showBottomButtons ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GhostButton(
                    label: 'common.decline'.tr(),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  IntrinsicWidth(
                    child: Button3D(
                      label: 'common.accept'.tr(),
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
  
  // TODO: Replace with actual privacy policy content fetching logic
  void fetchSite() {
    setState(() {
      htmlText = '''
        <h1>Lorem Ipsum</h1>
        <p><strong>Lorem ipsum dolor sit amet</strong>, consectetur adipiscing elit. <em>Etiam euismod</em> tincidunt velit, nec facilisis massa dictum nec.</p>
        <ul>
          <li>Curabitur blandit tempus porttitor.</li>
          <li>Maecenas faucibus mollis interdum.</li>
          <li>Nullam quis risus eget urna mollis ornare vel eu leo.</li>
        </ul>
        <p>Donec ullamcorper nulla non metus auctor fringilla. <a href="#">Learn more</a></p>
      ''';
    });
  }
}
