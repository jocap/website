
2019-01-07T13:42:54+01:00
# How I generate these pages
(January, 2019)
en

This website used to be created with Jekyll, a static site generator
natively supported by GitHub Pages.  While this setup certainly is
capable, I came to realize that it didn't fit my needs:

*   Jekyll gave me very little control over the final directory
    structure of my site.  Whereas what I wanted was a one-to-one
    correlation between the organization of my website and that of
    my local file system, what I got was a one-size-fits-all blog.

*   There were discrepancies between my local installation of Jekyll
    and that used by GitHub Pages – especially with regards to the
    directory structure – which made it hard for me to foretell
    what the finished site would look like after publishing it.

*   Speaking of which – what *is* the benefit of having GitHub Pages
    generate your site, compared with generating it locally (which
    you'd almost always do anyway) and uploading the results?

These weren't unmanageable problems, and I used Jekyll from September
till now.  However, my setup felt unwieldy and fragile, which brings
me to ...

## 2019

Another year, another rewrite.  I started with a single Markdown
document and wrote a shell script, `bin/html-page`, to translate
it into a standalone HTML page:

    #!/bin/sh

    # (1)
    read
    read datetime
    read title
    title=${title#\# }
    read meta
    read lang
    text=$(bin/markdown)

    # (2)
    content=$(cat <<CONTENT
    <article>
    <h1 id="title">$title</h1>
    ${meta:+<p id=\"meta\"><time datetime=\"$datetime\">$meta</time></p>}
    <div id="text">
    $text
    </div>
    </article>
    CONTENT)

    # (3)
    export lang author datetime title meta content
    bin/html-page-tpl

1. All Markdown documents begin with a block of metadata, as specified
in the beginning of this file.  The title can optionally begin with
a hash, as per Markdown syntax.  The text is retrieved from the
program specified in `bin/markdown`, receiving the rest of the text
via the standard input.

2. Then follows the template for a single HTML article, containing
every piece of information specified in the original Markdown file,
but lacking the scaffolding required by a full HTML document.

3. Finally, all variables are exported to be used by the template
specified in `bin/html-page-tpl`.

Apropos, `bin/html-page-tpl` is a very simple file.  It uses `cat`
in combination with "here documents" to create a simple (but capable)
templating engine – no Liquid or ERB needed:

    #!/bin/sh

    cat <<TEMPLATE
    <!doctype html>
    <html lang="$lang">
    <meta charset="utf-8">
    <title>$title</title>
    <meta name="author" content="$author" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="stylesheet" href="$base/style.css" />
    $content
    </html>
    TEMPLATE

To wrap it all up, a simple (GNU)makefile handles the file system
operations, taking Markdown files from `src/` and creating HTML
files in `dst/`:

    dst/%.html: src/%.md bin/html-page bin/html-page-tpl
    	mkdir -p $$(dirname $@)
    	cat $< | bin/html-page > $@

***

That's the basic description of the system.  Of course, it is
incomplete – in addition to standalone pages, I offer an index page,
as well as an Atom feed – but all this other functionality is
implemented similarly to that which I have showed above.

If you're interested in seeing the entire system, check out the
GitHub repository and the `bin/` directory in particular.
