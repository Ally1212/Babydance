# OneSignal iOS 手动配置指南

本文档提供了在 Xcode 中手动完成 OneSignal 集成的剩余步骤。

## 1. 在 Xcode 中打开项目

首先，请确保您的 Flutter 项目的 iOS 工作区已在 Xcode 中打开。您可以通过以下命令执行此操作：

```bash
open flutter_flexible/ios/Runner.xcworkspace
```

## 2. 添加 Notification Service Extension Target

为了能够接收富文本推送通知（例如带有图片或按钮的通知），您需要添加一个 Notification Service Extension。

1.  在 Xcode 的顶部菜单栏中，选择 `File` > `New` > `Target...`。
2.  在弹出的模板选择窗口中，滚动或搜索找到 `Notification Service Extension`，然后点击 `Next`。
3.  在 `Product Name` 字段中输入 `OneSignalNotificationServiceExtension`。
4.  确保 `Language` 设置为 `Swift`。
5.  点击 `Finish`。
6.  Xcode 可能会弹出一个对话框，询问是否要激活 "OneSignalNotificationServiceExtension" scheme。请选择 `Cancel`，以确保您的主应用 `Runner` 仍然是默认的构建和运行目标。

## 3. 配置 Extension Target 文件

现在您需要将自动生成的文件替换为我们已经准备好的文件。

1.  在 Xcode 的左侧项目导航器中，您会看到一个新创建的 `OneSignalNotificationServiceExtension` 文件夹。
2.  **删除** Xcode 在该文件夹中自动生成的 `NotificationService.swift` 和 `Info.plist` 文件。
3.  打开 Finder，找到项目中的 `flutter_flexible/ios/OneSignalNotificationServiceExtension` 目录。
4.  将这个 `OneSignalNotificationServiceExtension` 文件夹从 Finder **拖拽**到 Xcode 的项目导航器中，放置在与 `Runner` 文件夹同级的位置。
5.  在弹出的对话框中，请务必：
    *   勾选 `Copy items if needed`。
    *   在 `Add to targets` 部分，**只勾选 `OneSignalNotificationServiceExtension`**，不要勾选 `Runner`。
    *   点击 `Finish`。

## 4. 设置 App Group (可选)

如果您的应用需要使用 App Group 功能（例如，在通知中共享数据），您需要在两个 Target 中都进行配置。

1.  选择 `Runner` Target，然后进入 `Signing & Capabilities` 标签页。
2.  点击 `+ Capability` 并选择 `App Groups`。
3.  添加一个新的 App Group，通常格式为 `group.your.bundle.identifier`。
4.  选择 `OneSignalNotificationServiceExtension` Target，重复上述步骤，添加**完全相同**的 App Group。

## 5. 安装 Pods

最后一步是更新 CocoaPods 依赖。

1.  打开终端。
2.  导航到项目的 `ios` 目录：
    ```bash
    cd flutter_flexible/ios
    ```
3.  运行 `pod install` 命令来安装新的依赖：
    ```bash
    pod install
    ```

完成以上所有步骤后，您的 Flutter 应用的 iOS 端就已成功集成了 OneSignal。

## 官方文档

如需更多详细信息或遇到问题，请参阅 OneSignal 官方文档：

- [OneSignal Flutter SDK 安装指南](https://documentation.onesignal.com/docs/flutter-sdk-setup)
