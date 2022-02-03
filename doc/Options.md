# Options
FromSratch Apps has some options, but these options are disabled by default.
You can enable the option(s) by explicitly creating a settings.ston file .

The settings.ston file is a simple text file written in STON format like JSON.

For example, if you want to enable the dontClose option, you can create settings.ston a file as follows.

```
{#dontClose:true}
```

The settings.ston file should be placed in the same folder as the Scratch apps image.

Multiple options must be separated by commas like this:

```
{#projectDir:'{documents}/stelo',#useErrorCatcher:false}
```

Once you have created the settings.ston file, you can change the options from the Help-Settings menu.

# Available options
- dontClose
- keepMaximize
- language
- stickyWindow
- useErrorCatcher
- projectDir

## dontClose
The dontClose option disables the window close button.

Possible options are true or false.

## keepMaximize
The keepMaximize option automatically scales the window to fit the application window automatically.

Possible options are true or false.

## language
The language option localizes the texts in the application.

You need to prepare the locale file in the locales folder in advance.

For example, you created a locale file named ja.po, you can specify 'ja' as a language option.

## stickyWindow
The stickyWindow option disables moving the application window.

Possible options are true or false.

## useErrorCatcher
The useErrorCatcher option suppresses the display of debug dialogs.

Possible options are true or false.

## projectDir
The projectDir option specifies the directory name to open/save projects.

Possible option is a string of the directory.
It can be included '{documents}' for system's documents directory.
