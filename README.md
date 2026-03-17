# LocalAnimations for AWTRIX 2.0

`LocalAnimations` is a custom app for the AWTRIX 2.0 system. It replaces the default `Animations` app to allow you to load and display animations directly from a local JSON file, eliminating the need for HTTP downloads and ensuring instantaneous, offline rendering.

`LocalAnimations` 是 AWTRIX 2.0 系统的自定义应用。它替代了默认的 `Animations` 应用，允许您直接从本地的 JSON 文件加载和显示动画，从而消除了 HTTP 下载的需求，确保了即时、离线的渲染体验。

## Installation & Usage (安装与使用)

1. **Deploy the App (部署应用):**
   Place the compiled `LocalAnimations.jar` into your AWTRIX Server's `Apps` folder.
   将编译好的 `LocalAnimations.jar` 放入您 AWTRIX 服务器的 `Apps` 文件夹中。

2. **Add the Animation Data (添加动画数据):**
   * In the root directory of your AWTRIX Server (the same folder where your `.jar` or execution script is located), create a new folder named `LocalAnimations`.
   * Place your full animation JSON file into this folder and name it exactly `Animations.json`.
   * The final path should look like: `.../awtrix_server_directory/LocalAnimations/Animations.json`
   * 在您的 AWTRIX 服务器的**根目录**下（即存放服务端执行文件或 jar 包的地方），新建一个名为 `LocalAnimations` 的文件夹。
   * 将完整的动画 JSON 文件放入此文件夹，并将其重命名为准确的 `Animations.json`。
   * 最终的路径结构应为：`.../awtrix_server_directory/LocalAnimations/Animations.json`

3. **Restart & Enable (重启与启用):**
   * Restart your AWTRIX Server.
   * Open the AWTRIX Web Interface.
   * Navigate to your Apps section, find `LocalAnimations`, and enable it. You can select which specific animations to display from the app's settings.
   * 重启您的 AWTRIX 服务器。
   * 打开 AWTRIX Web 控制台。
   * 导航至您的 Apps 列表，找到 `LocalAnimations` 并启用它。您可以在应用的设置中勾选希望显示的特定动画。

## Acknowledgements (致谢)

A massive thank you to **Blueforcer** for creating the amazing AWTRIX project, and for generously hosting and providing the comprehensive `animations_map.json` data that makes this local implementation possible. Your work brings our matrix displays to life!

由衷感谢 **Blueforcer** 创造了令人惊叹的 AWTRIX 项目！更要感谢他慷慨地托管并提供了详尽的动画 JSON 数据，正是这些无私分享的数据支撑了这个本地版本的实现，让我们的矩阵屏幕焕发生机！