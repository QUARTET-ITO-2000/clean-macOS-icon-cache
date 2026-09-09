const app = Application.currentApplication();
app.includeStandardAdditions = true;

const appName = "Clean macOS Icon Cache";

const response = app.displayDialog(
  "This will clear the macOS icon cache and restart Dock and Finder.\n\n" +
  "Your desktop and Finder will briefly refresh. Continue?",
  {
    withTitle: appName,
    buttons: ["Cancel", "Clear"],
    defaultButton: "Clear",
    cancelButton: "Cancel",
    withIcon: "caution"
  }
);

if (response.buttonReturned === "Clear") {
  try {
    app.doShellScript(
      "find /private/var/folders/ \\( -name com.apple.dock.iconcache -or -name com.apple.iconservices \\) -exec rm -rfv {} \\;\n" +
      "rm -rf /Library/Caches/com.apple.iconservices.store\n" +
      "killall Dock\n" +
      "killall Finder",
      { withAdministratorPrivileges: true }
    );
    app.displayDialog("Icon cache cleared successfully.", {
      withTitle: appName,
      buttons: ["OK"],
      defaultButton: "OK",
      withIcon: "note"
    });
  } catch (error) {
    app.displayDialog("Unable to clear the icon cache:\n" + error, {
      withTitle: appName,
      buttons: ["OK"],
      defaultButton: "OK",
      withIcon: "stop"
    });
  }
}
