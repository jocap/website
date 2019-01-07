
2018-09-24T00:00:00+01:00
# Web browser refresh on save with kqueue(2)
(September, 2018 – updated in October)
en

It's been done a million times -- "how to automatically refresh
browser upon saving file" -- so why not do it again?  Here's my
take on it.

## 1. File watcher

I looked around, and OpenBSD didn't seem to include any command
line utility for watching files.  It does provide the `kqueue(2)`
interface for C programs, though, so I decided to write a simple
command-line tool using that.

I call it `watch`, and [its source] is available on GitHub[^feedback].
It works like this:

[its source]: https://github.com/jocap/kq-watch/blob/master/watch.c

    > watch my-file

For every write to `my-file`, a new line will be written to the
standard output containing the file's name (as provided in `argv`).
If the file is renamed, a warning is issued to `stderr`.  If the
file is deleted, an error is issued and the program terminates.

Those warnings and errors are helpful when dealing with text editors
that do "atomic" or otherwise weird saving, like vim or, in my case,
[vis](https://github.com/martanne/vis/).

## 2. Editor configuration

To disable atomic saving for vis, I've got the following in my `visrc.lua`:

    vis.events.subscribe(vis.events.WIN_OPEN, function(win)
            vis:command('set savemethod inplace')
    end)

## 3. Browser refresh

Upon every file write, I use `xdotool` to send the F5 key to Firefox or Seamonkey:

    watch my-file | while read; do xdotool search --onlyvisible --classname Navigator key F5; done

I put this in a shell script called `refresh`:

    #!/bin/sh
    watch "$1" | while read; do xdotool search --onlyvisible --classname Navigator key F5; done

Personally, I think that's pretty good.

***

[^feedback]: Feedback more than welcome!
