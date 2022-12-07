// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:taba/utils/style_config.dart';

import '../../provider/preferences_provider.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail';

  String urlDetail;

  DetailPage({
    Key? key,
    required this.urlDetail,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
          title: const Text('Artikel'),
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
                    onLoadStart: (controller, url) {
                      pullToRefreshController?.beginRefreshing();
                    },
                    onLoadError: (controller, url, code, message) {
                      pullToRefreshController?.endRefreshing();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$code : $message ')),
                      );
                    },
                    onLoadHttpError: (controller, url, statusCode, description) {
                      pullToRefreshController?.endRefreshing();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$statusCode : $description ')),
                      );
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
                      ? CircularProgressIndicator(value: progress)
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
