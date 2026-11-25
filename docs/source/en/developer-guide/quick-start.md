# Development setup

## Python and uv

Use Python 3.10–3.12. The maintained dependency list is in [pyproject.toml](../../../../pyproject.toml).

```bash
git clone https://github.com/4beru/mymusic-qt5.git
cd mymusic-qt5
uv sync
uv run python app/Groove.py
```

Install a working multimedia backend: GStreamer and its plugins on Linux, LAV Filters if needed on Windows, or a compatible Qt backend on macOS.

## Reproducible Linux development

The [devenv configuration](../../../../devenv.nix) supplies Python 3.11, uv synchronization, Qt/X11 runtime libraries and GStreamer plugins.

```bash
devenv shell
run-app
```

The entry point is `app/Groove.py`. The Nix configuration targets Linux/X11.

## Visual Studio Code

Select the Python interpreter created by uv (`.venv`) in VS Code. On Nix, launch the editor from the configured development environment if it needs the runtime libraries. An example `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug current file",
      "type": "debugpy",
      "request": "launch",
      "program": "${file}",
      "console": "integratedTerminal",
      "justMyCode": true,
      "cwd": "${fileDirname}"
    },
    {
      "name": "Debug MyMusic",
      "type": "debugpy",
      "request": "launch",
      "program": "${workspaceFolder}/app/Groove.py",
      "console": "integratedTerminal",
      "justMyCode": true,
      "cwd": "${workspaceFolder}/app"
    }
  ]
}
```

The following portable task configuration replaces the historical machine-specific Conda paths. Save it as `.vscode/tasks.json` if useful.

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run MyMusic",
      "type": "shell",
      "command": "uv",
      "args": ["run", "python", "app/Groove.py"],
      "problemMatcher": []
    },
    {
      "label": "Compile qrc",
      "type": "shell",
      "command": "uv",
      "args": ["run", "pyrcc5", "app/resource/resource.qrc", "-o", "app/common/resource.py"],
      "problemMatcher": []
    },
    {
      "label": "Compile qrc and run MyMusic",
      "dependsOrder": "sequence",
      "dependsOn": ["Compile qrc", "Run MyMusic"],
      "problemMatcher": []
    }
  ]
}
```

## Qt resources

After editing `app/resource/resource.qrc` or changing its referenced assets, regenerate the Python resource module:

```bash
uv run pyrcc5 app/resource/resource.qrc -o app/common/resource.py
```

Review the [development conventions](development-standard.md) and [architecture](architecture.md) before making changes.
