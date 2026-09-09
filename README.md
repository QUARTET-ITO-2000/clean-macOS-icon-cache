# clean-macOS-icon-cache

A small macOS utility that clears the system icon cache and restarts Dock and Finder to fix broken, missing, or stale icons.

> ⚠️ This utility deletes system cache files with administrator privileges and restarts Dock and Finder. Your desktop will briefly refresh during the process. Read the [Safety](#safety) section before running it.

## Languages

English is the primary language of this project. The documentation is also available in the following languages:

- English (primary) — `README.md`
- 简体中文 (Chinese) — [README.zh-CN.md](README.zh-CN.md)
- Español (Spanish) — [README.es.md](README.es.md)

## Files

| File | Description |
| --- | --- |
| `clean-icon-cache.js` | JXA script with a confirmation dialog. Requests administrator privileges when run. |
| `clean-icon-cache.sh` | Shell version. Uses `sudo` directly. |
| `build-app.sh` | Builds a double-clickable `.app` from `clean-icon-cache.js`. |

## How it works

1. Deletes the `com.apple.dock.iconcache` and `com.apple.iconservices` caches under each user cache directory in `/private/var/folders/`.
2. Deletes `/Library/Caches/com.apple.iconservices.store`.
3. Restarts Dock and Finder with `killall Dock` and `killall Finder`.

## Usage

### Run from source

JXA version:

```bash
osascript clean-icon-cache.js
```

Shell version:

```bash
chmod +x clean-icon-cache.sh
./clean-icon-cache.sh
```

Both versions request administrator privileges and ask for confirmation before doing anything. To skip the prompt, pass `--yes`; to preview what would be deleted without changing anything, pass `--dry-run`:

```bash
./clean-icon-cache.sh --yes
./clean-icon-cache.sh --dry-run
```

If cleanup fails, Dock and Finder are not restarted.

### Build the app

```bash
./build-app.sh
```

This creates `dist/clean-macOS-icon-cache.app`, which you can double-click. Building locally avoids the Gatekeeper "unidentified developer" warning.

## Code signing & notarization

This project is **not** signed with an Apple Developer ID and is **not** notarized by Apple, because its author is not enrolled in the Apple Developer Program. The `.app` produced by `build-app.sh` has only an ad-hoc signature.

The app runs normally when you build and launch it on your own Mac. However, after downloading a release zip from GitHub, macOS may block the first launch with a "developer cannot be verified" warning.

To open it anyway:

1. Recommended: build from source with `./build-app.sh`, then run the app.
2. Control-click the app and choose **Open** for the first launch.
3. Or remove the quarantine attribute in Terminal:

   ```bash
   xattr -dr com.apple.quarantine /path/to/clean-macOS-icon-cache.app
   ```

This app requests administrator privileges. Review the source before running. Note that the absence of notarization is not a sign of safety — it simply reflects that the author has not paid for an Apple Developer account.

## Safety

- Deletion targets are limited to known macOS icon-cache paths, but the scripts contain `sudo` and `rm -rf`. Read the source before running.
- Dock and Finder will be restarted. Full-screen apps may be exited and desktop icons will reload.
- Requires macOS and administrator privileges.

## License

[MIT](LICENSE)
