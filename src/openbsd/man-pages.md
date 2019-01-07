
2018-10-01T01:00:00+01:00
# Viewing man pages as HTML and PDF
(October, 2018)
en

If you've read about OpenBSD before, you've probably been advised
to read the man pages.  I'll echo this advice, because the man pages
are usually very good.

However, reading man pages through `less` leaves a lot to be desired,
both in terms of readability and navigation.  Fortunately, you can
easily convert man pages to PDF or HTML (insert your favorite PDF
reader or WWW browser):

    MANPAGER=mupdf man -T pdf intro
    MANPAGER=seamonkey man -T html intro

The PDF pages are much easier to read thanks to the typography,
while the HTML pages are much easier to browse thanks to the
hyperlinks.  (They would be improved even further by a script that
generates tables of contents.)

***

If you use Chromium, you might find that the line above doesn't
quite work: Chromium seems to interpret and display the temporary
file, lacking a `.html` extension, as a plain text file.

The following script fixes that and should work with any `$BROWSER`:

    #!/bin/sh

    # open man page as HTML document
    # (with .html to make sure Chrome displays it correctly)

    file=$(mktemp /tmp/man.XXXXXX) || exit 1
    mv $file $file.html
    MANPAGER=cat man -T html $@ > $file.html
    $BROWSER $file.html
    rm $file.html
