# Settings
FromSratch App has some settings, but these settings are disabled by default.
You can enable the setting(s) by explicitly creating a settings.ston file .

The settings.ston file is a simple text file written in STON format like JSON.

For example, if you want to enable the dontClose setting, you can create settings.ston file as follows.

```
{#dontClose:true}
```

The settings.ston file should be placed in the same folder as the Pharo image file.

Multiple settings must be separated by commas like this:

```
{#projectDir:'{documents}/stelo',#useErrorCatcher:false}
```

Once you have created the settings.ston file, you can change the settings from the Help-Settings menu.

# Available settings
- dontClose
- keepMaximize
- language
- stickyWindow
- useErrorCatcher
- projectDir
- hideDebugMenu
- resizable
- fullscreen

## dontClose
The dontClose setting disables the window close button.

Possible options are true or false.

## keepMaximize
The keepMaximize setting automatically scales the window to fit the application window automatically.

Possible options are true or false.

## language
The language setting localizes the texts in the application.

You need to prepare the locale file in the locales folder in advance.

For example, you created a locale file named ja.po, you can specify 'ja' as a language setting.

## stickyWindow
The stickyWindow setting disables moving the application window.

Possible options are true or false.

## useErrorCatcher
The useErrorCatcher setting suppresses the display of debug dialogs.

Possible options are true or false.

## projectDir
The projectDir setting specifies the directory name to open/save projects.

Possible option is a string of the directory.
It can be included '{documents}' for system's documents directory.

## hideDebugMenu
The hideDebugMenu setting disables Help-Inspect and Help-Settings menu items.

Possible options are true or false.

## resizable
The resizable setting specifies whether the application's window can be resized.
If the resizable setting is true, window decorations will not be displayed.

Possible options are true or false.

## fullscreen
The fullscreen setting maximizes the application's screen in the host's windowing environment.
Note that it may not work depending on the host window environment.

Possible options are true or false.
