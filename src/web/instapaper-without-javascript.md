
2018-10-04T00:00:00+01:00
# Instapaper bookmarklet without JavaScript
(October, 2018)
en

For the most part, I browse the web with JavaScript disabled by
default (via [NoScript][n]).  I also use [Instapaper][i]
to save articles for later.  Unfortunately, the bookmarklet[^b]
provided by Instapaper requires JavaScript to be enabled on the
site to be saved.

For this reason, I cobbled together my own bookmarklet, inspired
by the ones provided by [Pinboard][p] (an even better service):

    javascript:void(open('https://www.instapaper.com/hello2?u='+encodeURIComponent(location.href)+'&t='+(document.title),'Instapaper','toolbar=no,width=500,height=350'))

Here it is as a link that you can drag to your bookmarks:
<a href="javascript:void(open('https://www.instapaper.com/hello2?u='+encodeURIComponent(location.href)+'&t='+(document.title),'Instapaper','toolbar=no,width=500,height=350'))">Add to Instapaper</a>

***

[^b]: "A bookmarklet is a bookmark stored in a web browser that contains JavaScript commands that add new features to the browser." -- [Wikipedia][w]

[n]: https://noscript.net
[i]: https://instapaper.com
[p]: https://pinboard.in
[w]: https://en.wikipedia.org/wiki/Bookmarklet
