import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  String linkUrl;
  WebView({super.key,required this.linkUrl});
  WebViewController controller = WebViewController();


  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Macipie",style: TextStyle(fontFamily: 'MeaCulpa',fontSize: 33,fontWeight: FontWeight.bold),),

      ),
      body: WebViewWidget(controller: widget.controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted,)
        ..loadRequest(Uri.parse(widget.linkUrl))),
    );
  }
}
