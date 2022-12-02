// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:taba/utils/style_config.dart';

import '../../../provider/preferences_provider.dart';

class P3kDetailPage extends StatefulWidget {
  static const routeName = '/p3klist_page/detail';

  String urlDetail;

  P3kDetailPage({
    Key? key,
    required this.urlDetail,
  }) : super(key: key);

  @override
  State<P3kDetailPage> createState() => _P3kDetailPageState();
}

class _P3kDetailPageState extends State<P3kDetailPage> {
  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    webViewController?.loadUrl(
        urlRequest: URLRequest(url: Uri.parse(widget.urlDetail)));
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: ColorSystem.secondary,
        ),
        onRefresh: () async {
          webViewController?.reload();
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('P3K'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest:
                        URLRequest(url: Uri.parse(widget.urlDetail)),
                    initialOptions: InAppWebViewGroupOptions(
                      android: AndroidInAppWebViewOptions(
                          forceDark: Provider.of<PreferencesProvider>(context)
                                  .isDarkTheme
                              ? AndroidForceDark.FORCE_DARK_ON
                              : AndroidForceDark.FORCE_DARK_OFF),
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                      ),
                    ),
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: (controller) async {
                      webViewController = controller;
                    },
                    onLoadStop: (controller, url) async {
                      pullToRefreshController?.endRefreshing();
                    },
                    onProgressChanged: (controller, progress) {
                      if (progress == 100) {
                        pullToRefreshController?.endRefreshing();
                      }
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      var uri = navigationAction.request.url!;

                      if (uri.toString() == widget.urlDetail) {
                        return NavigationActionPolicy.ALLOW;
                      } else {
                        return NavigationActionPolicy.CANCEL;
                      }
                    },
                  ),
                  progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
