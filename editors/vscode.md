# VSCode settings

## User Settings

```
{
    "workbench.colorTheme": "One Dark Pro",
    "window.zoomLevel": -1,
    "workbench.iconTheme": "vscode-icons",
    "sublimeTextKeymap.promptV3Features": true,
    "editor.multiCursorModifier": "ctrlCmd",
    "editor.snippetSuggestions": "top",
    "editor.formatOnPaste": true,
    "editor.fontSize": 13,
    "terminal.integrated.shell.windows": "C:\\WINDOWS\\System32\\cmd.exe",
    "terminal.integrated.shellArgs.windows": [
        "/K",
        "C:\\Users\\Caz\\Downloads\\cmder_mini\\vscode.bat"
    ]
}

```
```
{
    "editor.tabSize": 2,
    "workbench.colorTheme": "Atom One Dark",

    "editor.tokenColorCustomizations": {
        "strings" : "#d6bc8c",
        "textMateRules": [
        {
            "scope": "punctuation.definition.string.begin",
            "settings": {
                "foreground": "#d6bc8c"
            }
        
        },
        {
            "scope": "punctuation.definition.string.end",
            "settings": {
                "foreground": "#d6bc8c"
            }
        
        }
        ]
        
    }
}

```


## User Snippets

```
{
    "CSS link tag": {
        "prefix": "link",
        "body": [
            "<link rel=\"stylesheet\" type=\"text/css\" href=\"$0\">"
        ],
        "description": "Expand link stylesheet tag"
    },

    "Meta tag": {
        "prefix": "meta",
        "body": [
            "<meta charset=\"utf-8\">",
            "<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">",
            "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">",
            "<meta name=\"description\" content=\"\">",
            "<meta name=\"author\" content=\"\">",
            "$0"
        ],
        "description": "Insert meta tags"
    }

}

```

## C# using VSCode

Make sure the configuration file is changed to `"console": "externalTerminal"` to allow input when running in debug

```
"configurations": [
        {
            "name": ".NET Core Launch (console)",
            ...
            "console": "externalTerminal",
            ...
```
