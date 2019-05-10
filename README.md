![logo](doc/logo.png "xptp")

# xptp: Crossplatform Plain Text Presentation

<img src="https://img.shields.io/badge/ver-0.6.0--beta-blue.svg"></img>

A minimilistic presentation application that makes use of a plain text
file. Every paragraph or image filepath represents a slide in the presentation.

It is essentially a cross platform implementation of [sent](https://tools.suckless.org/sent/)
using the [Godot engine](https://godotengine.org/)

## (Non-)Features

* A presentation is just a simple text file.
* Each paragraph represents one slide.
* Content is automatically scaled to fit the screen.
* UTF-8 is supported.
* Images can be displayed (no text on the same slide).
* No different font styles (bold, italic, underline)
* No fancy layout options (different font sizes, different colors, …)
* No animations
* No support for automatic layouting paragraphs
* Slides with exuberant amount of lines or characters produce rendering
will not fit in the slide preventing you from holding bad presentations.

## Features
* Simple GUI
* Dark mode / Light mode

## Todo
* ~~Improve text resizing~~
* Rewite in `GDNative` / `c++`
* Accept command line parameters
* ~~Toggle slide number~~
* Config file?
* Custom Font support?

## Controls

* _Arrow Keys / Vim navigation keys / Swipe left or right_: Navigation
* <kbd>space</kbd>: Next slide
* <kbd>o</kbd>: Open file dialogue
* <kbd>t</kbd>: Toggle dark mode
* <kbd>n</kbd> / _Swipe down_: Toggle slide number
* <kbd>w</kbd>: Toggle window mode (windowed/fullscreen)
* <kbd>u</kbd>: Unload presentation
* <kbd>q</kbd>: Quit
* <kbd>Esc</kbd> / _Swipe up_: Toggle main menu

## License

This project is licensed under the GPLv3 License - see the [LICENSE.md](LICENSE.md) file for details

## Third Party Assets
* [code2003 Font](https://www.fontspace.com/st-gigafont-typefaces/code2003)
