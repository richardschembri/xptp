# xptp: Crossplatform Plain Text Presentation

<img src="https://img.shields.io/badge/ver-0.1.0--alpha-blue.svg"></img>

A cross platform implementation of [sent](https://tools.suckless.org/sent/)
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
* Dark mode/Light mode

## Todo
* Improve text resizing
* Rewite in GDNative/c++
* Accept command line parameters
* Toggle progress
* Config file?

## Controls

* _Arrow Keys / Vim navigation keys_: Navigation
* <kbd>space</kbd>: Next slide
* <kbd>o</kbd>: Open file dialogue
* <kbd>t</kbd>: Toggle dark mode
* <kbd>q</kbd>: Quit
* <kbd>Esc</kbd>: Back to main menu

## License

This project is licensed under the GPLv3 License - see the [LICENSE.md](LICENSE.md) file for details

## Third Party Assets
* [SF UI Text Regular font](https://fontlibrary.org/en/font/sf-ui-text-regular-)
* [Symbola](https://fonts2u.com/symbola.font)
