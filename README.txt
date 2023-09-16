README
------

volume v.0.1.0
By Sriranga Veeraraghavan <ranga@calalum.org>

volume is a script to set / get the volume on MacOSX. It
relies on osascript(1).

Homepage:

   https://github.com/srirangav/volume.sh

Usage:

    $ volume [mute|max|0-7]

    If no arguments are provided, volume.sh will print out
    the current volume.

    If 'mute' is provided as an argument the volume will be set to 0.

    If 'max' is provided as an argument, the volume will be set to the
    max (7).

    If any other argument is provided, it is passed to osascript.

    If volume is invoke using the name 'mute', the volume will be set
    to 0.

Install:

    $ make install

    By default, volume is installed in /usr/local/bin.  To install
    it in a different location, the alternate installation prefix
    can be supplied to configure:

        $ make PREFIX="<prefix>" install

    For example, the following will install volume in /opt/local:

        $ make PREFIX=/opt/local install

    A DESTDIR can also be specified for staging purposes (with or
    without an alternate prefix):

        $ make DESTDIR="<destdir>" [PREFIX="<prefix>"] install

History:

    v.0.1.0  Initial release

License:

    See LICENSE.txt

