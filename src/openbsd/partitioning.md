
2018-10-01T00:00:00+01:00
# How I partition OpenBSD
(October, 2018)
en

For the search engines, here are a couple of keywords: **how to
easily install OpenBSD on an existing partition**.

OpenBSD lacks a graphical installer.  Luckily, the text-based
installer is one of the best I've used.  However -- as always, when
it comes to disk partitioning, you need to be sure about what you're
doing, and when I first tried to install OpenBSD, I just couldn't
wrap my head around the version of `fdisk` provided by OpenBSD.
Here's what I did instead:

1. Booted back into Debian
2. Used Debian's `fdisk` to create an OpenBSD partition (A6)
3. Resumed the installation process

At this point, you're asked if you want to install the system onto
the already existing OpenBSD partition -- no further partitioning needed!

***

I ended up with the following partitions:

    Filesystem     Size    Used   Avail Capacity  Mounted on
    /dev/sd0a     1005M    128M    826M    13%    /
    /dev/sd0o     46.6G    3.8G   40.5G     9%    /home
    /dev/sd0d      3.9G    2.3M    3.7G     0%    /tmp
    /dev/sd0f      2.0G    1.4G    472M    75%    /usr
    /dev/sd0g     1005M    193M    761M    20%    /usr/X11R6
    /dev/sd0h      9.8G    4.9G    4.4G    53%    /usr/local
    /dev/sd0n      5.9G    6.0K    5.6G     0%    /usr/obj
    /dev/sd0m      2.0G    504M    1.4G    26%    /usr/src
    /dev/sd0e     11.0G    102M   10.3G     1%    /var

As you can see, a huge `/home` partition, but a rather small `/usr`
partition.  Normally, this shouldn't be a problem, but as I was
compiling a port of the music player [strawberry], I ran out of
space!

[strawberry]: https://strawbs.org/

As it turns out, the compilation process in `/usr/ports` was putting
tons of object and source files in directories under `/usr`, but
not in those designated for them: `/usr/obj` and `/usr/src`.  I
solved this by adding the following to my `/etc/mk.conf`:

    WRKOBJDIR=/usr/obj
    DISTDIR=/usr/src

As such, have a few search engine keywords: **how to avoid running out of space in /usr on OpenBSD.**
