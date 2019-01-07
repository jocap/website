
2018-09-01T00:00:00+01:00
# Have your separation of concerns and eat it too
(September, 2018 – re-written in October)
en

I recently [came across][l] a discussion about functional CSS, and
it made me think about separation of concerns.  See, I realized
that both sides of the conflict are equally right: those who propogate
for functional CSS and those who prefer the traditional method use
the same argument.

In order to explain, I will first try to clarify what I believe each
side's argument to be.

***
* Table of contents
{:toc}
***

[l]: https://lobste.rs/s/fqkodg/defense_functional_css

## Functional CSS

If we begin with functional CSS, I believe that its ultimate goal
is this:

{:.important}

Your CSS should be **reusable**, and your HTML **replaceable**; if
you create a good-looking stylesheet for one page, you should be
able to use it for another page without having to modify the CSS.

The consequence of this argument is that all CSS should be **strictly
presentational** and not depend on any specific semantic organization
of the HTML.

For example, if you wanted to specify a style for buttons, you would
create a CSS rule for `.button`:

    .button { /* looks like a button */ }

Very reasonable!  Now, you just have to add that class to everything
in your HTML structure that should be styled as a button:

    <a href="login" class="button">Log in</a>

With the popularity of CSS frameworks like Bootstrap, it is obvious
that this discipline has met much success and won many hearts.  If
there are a dozen different CSS stylesheets that define `.button`
styles, you could change the appearance of your HTML page by simply
switching out the stylesheet.

## Traditional discipline

Now, let's explore the argument against functional CSS:

{:.important}

Your **HTML** should be reusable, and your **CSS** replaceable; if
you create an HTML document, you should be able to change its
appearance without having to modify the HTML.

As you can see, this is the exact same argument, except it's been
turned on its head.  The consequence of this argument is that all
HTML should be **strictly semantic** and not depend on any specific
stylesheet.

For example, the aforementioned login button should rather be given
a semantic `id`:

    <a href="login" id="login">Log in</a>

And to define its appearance, you should create a CSS rule for
`#login` rather than for `.button`:

    #login { /* looks like a button */ }

This earns us the benefit of not having to change the *semantic*
structure of our document whenever we might want to change its
*presentation*.  If somebody decides that our login link should
look not like a button, but like a normal link, he or she needn't
modify the HTML to achieve this.  This is reasonable: because the
appearance of the link is a *presentational* issue, it belongs in
the CSS, not in the HTML.

## A comparison

The traditinal discipline aligns nicely with the role of HTML as a
semantic definition of a document -- but on the other hand, the
functional CSS perspective respects the role of *CSS* as a
presentational description of a document.

As for "separation of concerns", we must admit it to be the cornerstone
of *both* disciplines; they just approach it from different angles,
and in doing so, each appears to miss the other's point:

In the traditional method, while presentational issues are kept out
of the semantic organization of the HTML, the semantics are bound
to infect the presentational matters of the CSS.  And while functional
CSS keeps semantics out of the presentational description, it fills
the semantic description with tons of presentational concerns.

{:.vital}
The result is that neither discipline enforces separation of concerns.

## A solution

If *genuine* separation of concerns is what we truly desire -- that
is, a strict dividing line between semantics and presentation --
then I think I have a solution:

*Presentational description:*

    @mixin button { /* looks like a button */ }

*Semantic description:*

    <a href="login" id="login">Log in</a>

*Semantic--presentational link:*

    #login { @include button }

In text:

1.  Forbid semantic[^sem] information in the presentational
    description.
2.  Forbid presentational information in the semantic description.
3.  Create a **linking stylesheet** that defines the connection
    between the presentation and the semantics.

This way, you can replace *either* part, as long as you modify the
linking stylesheet accordingly.

I have started to use this discipline -- I guess we can call it
"extreme separation of concerns" -- for my own website, and my
own experience is that it works relatively well.

***

[^sem]: Note that I use the word "semantic" here to refer to the
    *structure of the HTML*.  I don't mean that the presentational
    stylesheet mustn't describe elements like `a` or `code` -- these
    selectors have very little to do with the document's specific
    structure and are likely to be used identically in all HTML
    documents.  I mean that it shouldn't describe things like
    `#login`, `.post-meta time` or `#header .subtitle`.

    Personally, I do try to avoid even `a` and `code` in my
    presentational description, but this isn't necessary for the
    discipline to work.
