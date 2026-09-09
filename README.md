# clean-macOS-icon-cache

清理 macOS 图标缓存的小工具，用于修复图标错乱、Dock 图标显示异常等问题。

> ⚠️ 本工具会以管理员权限删除系统缓存并重启 Dock 与 Finder，执行期间桌面会短暂刷新。使用前请阅读[安全说明](#安全说明)。

## 包含内容

| 文件 | 说明 |
| --- | --- |
| `clean-icon-cache.js` | JXA 版本，带确认弹窗，运行时请求管理员权限 |
| `clean-icon-cache.sh` | Shell 版本，直接以 `sudo` 执行 |
| `build-app.sh` | 将 `clean-icon-cache.js` 打包成可双击运行的 `.app` |

## 工作原理

1. 删除 `/private/var/folders/` 下各用户缓存目录中的 `com.apple.dock.iconcache` 与 `com.apple.iconservices`；
2. 删除 `/Library/Caches/com.apple.iconservices.store`；
3. 重启 Dock 与 Finder（`killall Dock` / `killall Finder`）。

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

两者都会请求管理员密码。JXA 版本会先弹窗确认；Shell 版本没有确认步骤，运行前请确保没有需要保留的进行中操作。

### 打包成 App

```bash
./build-app.sh
```

生成 `dist/清理图标缓存.app`，可直接双击运行。在本地打包的应用不会触发 Gatekeeper 的“无法验证开发者”提示。

## 安全说明

- 删除目标均限定为 macOS 图标缓存相关路径，但代码包含 `sudo` 与 `rm -rf`，运行前建议通读源码；
- 删除后会重启 Dock 和 Finder，全屏应用可能被退出到窗口模式，桌面图标会重新加载；
- 仅适用于 macOS，且需要管理员权限。

## License

[MIT](LICENSE)
