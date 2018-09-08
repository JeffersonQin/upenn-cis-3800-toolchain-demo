# CIS 380 Review Session
---

##Setup
- `sample.c` is compiled into the `samp` executable
    - Depending on an argument it calls different function.
    - 'm' => `myFunction` just adds numbers and prints.
    - 's' => `segf` segfaults.
    - 'f' => `fork_example` forks a child process and then waits on it.
    - 'u' => `useAfterFree` use after free error.
    - 'l' => `leak` creates a memory leak.
- 'samp_san' executable
    - Compilied with clang sanatizers turned on.
    - Use for memory leak and use after free.

## Debugging with `gdb`
- How to use:
    - Use `-g` flag (and `- Wall`)
    - start via `$ gdb <executable>`
    - Begin debugging `(gdb) start <args>`
    - Switch to terminal UI (TUI) via `ctrl-x a`
- Simple usage [use myFunction() `./samp m`]
    - `step` (`s`)
    - `breakpoint` (`b`)
        - `info breakpoints`
        - `d <breakpoint>`
        - `clear` (Deletes all breakpoints)
    - `continue` (`c`)
    - `finish` (`f`)
- How to debug with segfaults [use segf() `./samp s`]:
    - `backtrace` (`bt`)
- How to debugg multi-threaded programs [use fork_example() `./samp f`]
    - `set follow-fork-mode <child/parent>`
- Signal Handling
    - `catch signal <code>`
        - stops `gdb` from passing the signal to program
    -  `handle <signal> <action>`
- Sanitziers
    - Compile options for `clang`/`gcc`
        - Wrap `malloc`, `free`, etc.
        - Maintain metadata, find problems
    - Great for memory leaks, use after free, etc.
    - What do we need?
        - Compile options (see `Makefile`)
        - `llvm-symbolizer`
    - How to debug use after free [useAfterFree() `./samp_san u`]
    - How to debug leak [leak() `./samp_san l`]
- Resources 
    - [Cheat Sheet](https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf)
    - [Tutorial](http://www.brendangregg.com/blog/2016-08-09/gdb-example-ncurses.html)

## `TMUX` (Terminal Multiplexing)
- What does it do?
    - One `ssh` session, multiple terminals
    - Keep session state.
- Basic operation
    - `$ tmux new-session -c ~/path/to/project -s <name>`
    - `tmux attach -t <name>`
        - `tmux a` for most recent
- Once you're in...
    - prefix `ctrl-b` 
        - most commands are prefix then action
    - Panes
        - horizontal split `<prefix> "`
        - vertical split `<prefix> %`
        - switch panes with arrow keys or `h j k l` (vim)
        - delete pane `<prefix> x`
    - Tabs
        - create `<prefix> c`
        - switch `<prefix> <number>`
- Good Config
    - [cis380/gists](https://github.com/cis380/gists)
    - install by copying into `~/.tmux.conf`

## Git
- I'm assuming you have basic git familiarity.
- Collaboration
    - Often we are in a scenario when two people want to push to the same branch.
    - This creates a problem, as only one will be able to do it and the other will need to merge.
    - What we really want is whoever is second to have their changes be on _top_ of first's.
    - `git pull --rebase`
        - Will apply the commits you are pulling *under* your current work.

## Vim
- I'm going to assume you're familiar with basic vim.
- Settings 
    - `jj` escapes normal mode
    - Line numbering on
    - Tabs are 4 spaces
- Extra goodies 
    - `ctrl p` search for files in git repo.
        - `buffer` or `b` ...
            - `d` delete
            - `p` previous
            - `n` next
    - linting
    - auto formatting (with a clangformat file)
    - good syntax highlighting
    - git integration
        - `:GBlame` = see who messed up the code
    - git line status
- Plenty of plugins are there, check them out, look at `~/.vimrc`
    - [Plugin Manager](https://github.com/junegunn/vim-plug)
    - [Install More](https://vimawesome.com/)

## Makefiles
- Most of what `make` is doing is dependancy resolution.
- What comes before the `:` is a target.
    - What comes after are the things it depends on.
- Beneath the target and dependancies is the receipe.
    - This means, given all the dependancies, it will construct the target.
- Essentially, a Makefile defines a graph from your source files/directories to executable binaries.
- Please see the Makefile in the repo for more details.
