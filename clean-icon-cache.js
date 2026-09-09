const app = Application.currentApplication();
app.includeStandardAdditions = true;

const response = app.displayDialog(
  "这将清除 macOS 的图标缓存，并重启 Dock 与 Finder。\n\n执行期间桌面与 Finder 会短暂刷新。是否继续？",
  {
    withTitle: "清理图标缓存",
    buttons: ["取消", "清理"],
    defaultButton: "清理",
    cancelButton: "取消",
    withIcon: "caution"
  }
);

if (response.buttonReturned === "清理") {
  try {
    app.doShellScript(
      "find /private/var/folders/ \\( -name com.apple.dock.iconcache -or -name com.apple.iconservices \\) -exec rm -rfv {} \\;\n" +
      "rm -rf /Library/Caches/com.apple.iconservices.store\n" +
      "killall Dock\n" +
      "killall Finder",
      { withAdministratorPrivileges: true }
    );
    app.displayDialog("图标缓存已清理完成。", {
      withTitle: "清理图标缓存",
      buttons: ["好"],
      defaultButton: "好",
      withIcon: "note"
    });
  } catch (error) {
    app.displayDialog("未能完成清理：\n" + error, {
      withTitle: "清理图标缓存",
      buttons: ["好"],
      defaultButton: "好",
      withIcon: "stop"
    });
  }
}
