# DrRacket: The Racket Programming Environment
* https://docs.racket-lang.org/drracket/index.html

DrRacket is a graphical environment for developing programs using the Racket programming languages.

# 1 Interface Essentials
## 1.1 Buttons
## 1.2 Choosing a Language
## 1.3 Editing with Parentheses
## 1.4 Searching
## 1.5 Tabbed Editing
## 1.6 The Interactions Window
- Errors
- Input and Output
```racket
write
display

read
read-char
```

## 1.7 Graphical Syntax
- Images
- XML Boxes and Racket Boxes
## 1.8 Graphical Debugging Interface
- Debugger Buttons
- Definitions Window Actions
- Stack View Pane
- Debugging Multiple Files
## 1.9 The Module Browser
## 1.10 Color Schemes
## 1.11 Creating Executables
## 1.12 Following Log Messages

# 2 Languages
## 2.1 Language Declared in Source
- Initial Environment
- Details Pane of Language Dialog
## 2.2 Legacy Languages
## 2.3 How to Design Programs Teaching Languages
## 2.4 Other Experimental Languages
## 2.5 Output Printing Styles

# 3 Interface Reference
## 3.1 Menus
- File
- Edit
- View
- Language
- Racket
- Insert
- Windows
- Help
- Popup menu
## 3.2 Preferences
- Font
- Colors
- Editing
- Warnings
- General
- Profiling
- Browser
- Tools
## 3.3 Keyboard Shortcuts
- Moving Around
- Editing Operations
- File Operations
- Search
- Evaluation
- Documentation
- Interactions
- LaTeX and TeX inspired keybindings
- Defining Custom Shortcuts
- Sending Program Fragments to the REPL
## 3.4 Status Information


## 3.5 DrRacket Files

- Program Files
The standard file extension for a Racket program file is `.rkt`. The extensions `.ss`, `.scm`, and `.sch` are also historically popular.

- Backup and First Change Files
Every 30 seconds, DrRacket checks each open file. If any file is modified and not saved, DrRacket saves the contents of the file in a backup file.

- Preference Files: On start-up, DrRacket reads configuration information from a preferences file.
  - UNIX: `~/.racket/racket-prefs.rktd`
  - Windows: `~/AppData/Roaming/Racket/racket-prefs.rktd`

# 4 Extending DrRacket
## 4.1 Teachpacks
- Adding Your Own Teachpacks to the Teachpack Dialog
- Extending Help Desk Search Context
## 4.2 Environment Variables

# See Also
* [drcomplete](https://github.com/yjqww6/drcomplete): DrRacket plugins for better autocompletion.
