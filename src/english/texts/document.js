/**
 *
 * @licstart  The following is the entire license notice for the
 *  JavaScript code in this page.
 *
 * Copyright (C) 2017 John Ankarström
 *
 *
 * The JavaScript code in this page is free software: you can
 * redistribute it and/or modify it under the terms of the GNU
 * General Public License (GNU GPL) as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option)
 * any later version.  The code is distributed WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU GPL for more details.
 *
 * As additional permission under GNU GPL version 3 section 7, you
 * may distribute non-source (e.g., minimized or compacted) forms of
 * that code without the copy of the GNU GPL normally required by
 * section 4, provided you include this license notice and a URL
 * through which recipients can access the Corresponding Source.
 *
 * @licend  The above is the entire license notice
 * for the JavaScript code in this page.
 *
 */

document.addEventListener("DOMContentLoaded", function(event) {
    window.addEventListener('scroll', function(event) {
        var links = document.querySelectorAll('#text-table-of-contents a')
        links.forEach(function(link, i) {
            var anchor = link.getAttribute('href')
            var section = document.querySelector(anchor)
            var sectionTop = section.getBoundingClientRect().top

            if (sectionTop - 10 <= 0) {
                if (i > 0) links[i-1].classList.remove('active')
                link.classList.add('active')
            } else {
                link.classList.remove('active')
            }
        })
    })

    // TODO: on resize, add overflow-y: scroll; to ToC if its height is greater
    //       than the window height
})
