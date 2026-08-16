# 蛋神 DanShen

**蛋神**是一款基于
[Boring Notch](https://github.com/TheBoredTeam/boring.notch) 开发的 macOS
刘海屏效率助手，把媒体、天气、日历、专注工具、蓝牙设备电量和可选 AI
智能体集中到一个紧凑的桌面界面中。

[English](README.md)

## 下载

请从 [GitHub Releases](https://github.com/YL-SSSSu/DanShen/releases/latest)
下载最新的通用版本。它同时支持 Apple Silicon 和 Intel Mac，需要 macOS 14
或更高版本。

当前预览包没有经过 Apple 公证。首次启动若被系统拦截，请前往“系统设置 >
隐私与安全性”并选择“仍要打开”。蛋神目前沿用了部分上游应用标识，请不要与
Boring Notch 同时运行。

## 主要功能

- **AI 智能体：**兼容 OpenAI Chat Completions 接口，支持多会话、Markdown、
  本地记忆、可编辑知识库、内置插件与 Skills、执行轨迹、文件/PDF/图片上下文和
  可选联网搜索。
- **权限可控：**只有开启对应设置后才读取日历；写入日程还需要用户明确提出要求。
- **天气：**Open-Meteo 当前天气、小时预报、降雨提示、自动定位或手动城市，以及
  公制/英制单位。
- **番茄钟：**可调整工作、短休息和长休息时长，并保存运行状态。
- **Home 面板：**媒体控制与歌词、天气、日历、Quick Launch，以及受支持的已连接
  蓝牙设备电量。
- **自定义布局：**控制 Home 卡片和蓝牙设备的显示、顺序，并调整主面板、记忆与
  知识库窗口大小。
- **macOS 集成：**日历、提醒事项、定位、辅助功能、媒体控制、HUD、文件架和
  Keychain 凭据存储。

## AI 设置

1. 打开“设置 > AI”。
2. 启用 AI 智能体。
3. 填写兼容接口的 Base URL、模型名称和你自己的 API Key。
4. 仅在需要时启用日历、文件工具或联网搜索。

仓库和发布包均不包含开发者 API Key。蛋神会把你填写的 API Key 存入 macOS
Keychain；会话、记忆和知识库资料保存在本机。

## 从源码构建

开发环境需要 macOS 15.6 或更高版本以及 Xcode 26 或更高版本。

```bash
git clone https://github.com/YL-SSSSu/DanShen.git
cd DanShen
./script/build_and_run.sh --verify
```

也可以直接用 Xcode 打开 `boringNotch.xcodeproj` 并运行 `boringNotch` scheme。

## 隐私

- 仓库和发布包不包含 API Key、密码、账号数据、聊天记录、日历内容、本地文件或
  私人知识库。
- AI 请求只会发送到用户自己配置的服务商。
- 天气使用 Open-Meteo，自动定位可以关闭。
- 日历、提醒事项、定位、辅助功能和输入监控权限都由 macOS 控制。

## 上游与许可证

蛋神是 [TheBoredTeam/boring.notch](https://github.com/TheBoredTeam/boring.notch)
的独立衍生项目，不是 Boring Notch 官方版本，也不代表 The Boring Team。
原始工作的署名归上游项目及其贡献者所有，第三方声明见
[THIRD_PARTY_LICENSES](THIRD_PARTY_LICENSES)。本项目继续采用
[GNU GPL v3](LICENSE)。
