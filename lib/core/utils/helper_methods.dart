import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:navis/core/themes/colors.dart';

Future<void> launchLink(String link) async {
  try {
    await launch(link,
        option: CustomTabsOption(
          toolbarColor: primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          //animation: CustomTabsAnimation.slideIn(),
          extraCustomTabs: const <String>[
            'org.mozilla.firefox',
            'org.mozilla.fenix',
            'com.microsoft.emmx'
          ],
        ));
  } catch (e) {
    // appScaffold.currentState.showSnackBar(const SnackBar(
    //   duration: Duration(seconds: 5),
    //   content: Text('No valid link provided by API'),
    // ));
  }
}
