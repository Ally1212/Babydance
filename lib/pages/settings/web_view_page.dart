import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String assetPath;

  const WebViewPage({
    super.key,
    required this.title,
    required this.assetPath,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      );

    _loadHtmlFromAssets();
  }

  Future<void> _loadHtmlFromAssets() async {
    try {
      String htmlContent = await rootBundle.loadString(widget.assetPath);
      await _controller.loadHtmlString(htmlContent);
    } catch (e) {
      // 如果加载失败，显示错误信息
      String errorHtml = '''
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Error</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    padding: 20px;
                    text-align: center;
                    background-color: #f5f5f5;
                }
                .error-container {
                    background: white;
                    padding: 40px;
                    border-radius: 8px;
                    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                    margin: 20px auto;
                    max-width: 400px;
                }
                .error-icon {
                    font-size: 48px;
                    color: #ff6b6b;
                    margin-bottom: 20px;
                }
                .error-title {
                    font-size: 24px;
                    color: #333;
                    margin-bottom: 10px;
                }
                .error-message {
                    color: #666;
                    line-height: 1.5;
                }
            </style>
        </head>
        <body>
            <div class="error-container">
                <div class="error-icon">⚠️</div>
                <div class="error-title">加载失败</div>
                <div class="error-message">无法加载内容，请稍后重试。</div>
            </div>
        </body>
        </html>
      ''';
      await _controller.loadHtmlString(errorHtml);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      '加载中...',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
