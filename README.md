# NovaStelo
NovaStelo is a block-style programming environment for multi agent system, based on MIT Scratch.

![Entire Screen](https://raw.githubusercontent.com/EiichiroIto/NovaStelo/master/misc/images/NovaStelo.png)

[![Build Status](https://travis-ci.com/EiichiroIto/NovaStelo.svg?branch=master)](https://travis-ci.com/EiichiroIto/NovaStelo)

NovaStelo is inspired from StarLogo and Scratch, more precisely
StarLogo on the book "Turtles, Termites, and Traffic Jams" and Scratch 1.4.
Both are of Resnick's great works.

NovaStelo is now built on Pharo Smalltalk 10.0. Almost all Model and UI are rewritten using Spec2.

## Install and Play on Windows
1. Go to [release page](https://github.com/EiichiroIto/NovaStelo/releases), and download a latest release file.
2. Extract the zipped release file.
3. Start Pharo.exe application.
4. Click NovaStelo on a menu bar to start NovaStelo.

## Install repository on Pharo
NovaStelo sources available on github (https://github.com/EiichiroIto/NovaStelo/).
```
Metacello new
    baseline: 'NovaStelo';
    repository: 'github://EiichiroIto/NovaStelo/src';
    load.
```

## [Beware] Before update
* You need keep script files before update, because project files are incompatible with any previous versions.
* To keep script files, select "File - Export - Export Scripts in S-EXP".
* To recovery the file, select "File - Import - Import Scripts"

## Examples
1. Select Open from File menu.
2. Click Examples button on the file open dialog.
3. Select file and press OK.
4. Click Setup button on right side pane to setup the program.
5. Click Loop button to start.

## License
MIT License

## Screenshots
### Conway's Life Game
![01-lifegame](https://raw.githubusercontent.com/EiichiroIto/NovaStelo/master/misc/images/01-lifegame.png)

### Resnick's Turtle Ecology
![02-ecosystem](https://raw.githubusercontent.com/EiichiroIto/NovaStelo/master/misc/images/02-ecosystem.png)

### Resnick's Termites
![03-termites](https://raw.githubusercontent.com/EiichiroIto/NovaStelo/master/misc/images/03-termites.png)

### Resnick's Slime Mold
![04-slimemolds](https://raw.githubusercontent.com/EiichiroIto/NovaStelo/master/misc/images/04-slimemolds.png)

### Gray-Scott's model (amrophous f=0.04, k=0.06)
![09-grayscott](https://raw.githubusercontent.com/EiichiroIto/NovaStelo/master/misc/images/09-grayscott.png)


## Animations
![03-termites](https://raw.githubusercontent.com/EiichiroIto/NovaStelo/master/misc/images/03-termites.gif)

