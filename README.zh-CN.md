# clean-macOS-icon-cache

一个用于清理 macOS 系统图标缓存的小工具，可修复 Dock 与 Finder 中图标错乱、缺失或显示过旧的问题。

> ⚠️ 本工具会以管理员权限删除系统缓存文件，并重启 Dock 与 Finder。执行期间桌面会短暂刷新。使用前请阅读[安全说明](#安全说明)。

## 语言 / Languages

本工程以英语为主要语言。文档同时提供以下语言版本：

- English（主要语言）— [README.md](README.md)
- 简体中文 — 本文档
- Español（西班牙语）— [README.es.md](README.es.md)

## 文件说明

| 文件 | 说明 |
| --- | --- |
| `clean-icon-cache.js` | JXA 脚本，带确认弹窗，运行时请求管理员权限。 |
| `clean-icon-cache.sh` | Shell 版本，直接使用 `sudo`。 |
| `build-app.sh` | 从 `clean-icon-cache.js` 打包出可双击运行的 `.app`。 |

## 工作原理

1. 删除 `/private/var/folders/` 下各用户缓存目录中的 `com.apple.dock.iconcache` 与 `com.apple.iconservices` 缓存。
2. 删除 `/Library/Caches/com.apple.iconservices.store`。
3. 使用 `killall Dock` 与 `killall Finder` 重启 Dock 和 Finder。

## 使用方法

### 直接运行源码

JXA 版本：

```bash
osascript clean-icon-cache.js
```

Shell 版本：

```bash
chmod +x clean-icon-cache.sh
./clean-icon-cache.sh
```

两个版本都会请求管理员权限，并在执行前要求确认。需要跳过确认时传入 `--yes`；只想预览将删除的内容而不做任何修改时，传入 `--dry-run`：

```bash
./clean-icon-cache.sh --yes
./clean-icon-cache.sh --dry-run
```

如果清理失败，不会重启 Dock 与 Finder。

### 打包成 App

```bash
./build-app.sh
```

生成 `dist/clean-macOS-icon-cache.app`，可直接双击运行。在本地打包的应用不会触发 Gatekeeper 的“无法验证开发者”提示。

## 安全说明

- 删除目标仅限 macOS 已知的图标缓存路径，但脚本中包含 `sudo` 与 `rm -rf`，运行前建议通读源码。
- Dock 和 Finder 会被重启；全屏应用可能退出到窗口模式，桌面图标会重新加载。
- 仅适用于 macOS，需要管理员权限。

## License

[MIT](LICENSE)
