#!/bin/bash 

echo '

convert -verbose  label:foobar  foobar.gif'
convert -verbose  label:foobar  foobar.gif
echo '

convert -verbose  label:foobar -extent 200x200  foobar200x200.gif'
convert -verbose  label:foobar -extent 200x200  foobar200x200.gif
echo '

convert -verbose  label:foobar -extent 200x800  foobar200x800.gif'
convert -verbose  label:foobar -extent 200x800  foobar200x800.gif
echo '

convert -verbose  label:foobar -extent 800x200  foobar800x200.gif'
convert -verbose  label:foobar -extent 800x200  foobar800x200.gif
echo '

convert -verbose  label:foobar -rotate 0  foobar0.gif'
convert -verbose  label:foobar -rotate 0  foobar0.gif
echo '

convert -verbose  label:foobar -rotate 0 -extent 200x200  foobar0200x200.gif'
convert -verbose  label:foobar -rotate 0 -extent 200x200  foobar0200x200.gif
echo '

convert -verbose  label:foobar -rotate 0 -extent 200x800  foobar0200x800.gif'
convert -verbose  label:foobar -rotate 0 -extent 200x800  foobar0200x800.gif
echo '

convert -verbose  label:foobar -rotate 0 -extent 800x200  foobar0800x200.gif'
convert -verbose  label:foobar -rotate 0 -extent 800x200  foobar0800x200.gif
echo '

convert -verbose  label:foobar -rotate 90  foobar90.gif'
convert -verbose  label:foobar -rotate 90  foobar90.gif
echo '

convert -verbose  label:foobar -rotate 90 -extent 200x200  foobar90200x200.gif'
convert -verbose  label:foobar -rotate 90 -extent 200x200  foobar90200x200.gif
echo '

convert -verbose  label:foobar -rotate 90 -extent 200x800  foobar90200x800.gif'
convert -verbose  label:foobar -rotate 90 -extent 200x800  foobar90200x800.gif
echo '

convert -verbose  label:foobar -rotate 90 -extent 800x200  foobar90800x200.gif'
convert -verbose  label:foobar -rotate 90 -extent 800x200  foobar90800x200.gif
echo '

convert -verbose  label:foobar -rotate 270  foobar270.gif'
convert -verbose  label:foobar -rotate 270  foobar270.gif
echo '

convert -verbose  label:foobar -rotate 270 -extent 200x200  foobar270200x200.gif'
convert -verbose  label:foobar -rotate 270 -extent 200x200  foobar270200x200.gif
echo '

convert -verbose  label:foobar -rotate 270 -extent 200x800  foobar270200x800.gif'
convert -verbose  label:foobar -rotate 270 -extent 200x800  foobar270200x800.gif
echo '

convert -verbose  label:foobar -rotate 270 -extent 800x200  foobar270800x200.gif'
convert -verbose  label:foobar -rotate 270 -extent 800x200  foobar270800x200.gif
echo '

convert -verbose  label:barfoo  barfoo.gif'
convert -verbose  label:barfoo  barfoo.gif
echo '

convert -verbose  label:barfoo -extent 200x200  barfoo200x200.gif'
convert -verbose  label:barfoo -extent 200x200  barfoo200x200.gif
echo '

convert -verbose  label:barfoo -extent 200x800  barfoo200x800.gif'
convert -verbose  label:barfoo -extent 200x800  barfoo200x800.gif
echo '

convert -verbose  label:barfoo -extent 800x200  barfoo800x200.gif'
convert -verbose  label:barfoo -extent 800x200  barfoo800x200.gif
echo '

convert -verbose  label:barfoo -rotate 0  barfoo0.gif'
convert -verbose  label:barfoo -rotate 0  barfoo0.gif
echo '

convert -verbose  label:barfoo -rotate 0 -extent 200x200  barfoo0200x200.gif'
convert -verbose  label:barfoo -rotate 0 -extent 200x200  barfoo0200x200.gif
echo '

convert -verbose  label:barfoo -rotate 0 -extent 200x800  barfoo0200x800.gif'
convert -verbose  label:barfoo -rotate 0 -extent 200x800  barfoo0200x800.gif
echo '

convert -verbose  label:barfoo -rotate 0 -extent 800x200  barfoo0800x200.gif'
convert -verbose  label:barfoo -rotate 0 -extent 800x200  barfoo0800x200.gif
echo '

convert -verbose  label:barfoo -rotate 90  barfoo90.gif'
convert -verbose  label:barfoo -rotate 90  barfoo90.gif
echo '

convert -verbose  label:barfoo -rotate 90 -extent 200x200  barfoo90200x200.gif'
convert -verbose  label:barfoo -rotate 90 -extent 200x200  barfoo90200x200.gif
echo '

convert -verbose  label:barfoo -rotate 90 -extent 200x800  barfoo90200x800.gif'
convert -verbose  label:barfoo -rotate 90 -extent 200x800  barfoo90200x800.gif
echo '

convert -verbose  label:barfoo -rotate 90 -extent 800x200  barfoo90800x200.gif'
convert -verbose  label:barfoo -rotate 90 -extent 800x200  barfoo90800x200.gif
echo '

convert -verbose  label:barfoo -rotate 270  barfoo270.gif'
convert -verbose  label:barfoo -rotate 270  barfoo270.gif
echo '

convert -verbose  label:barfoo -rotate 270 -extent 200x200  barfoo270200x200.gif'
convert -verbose  label:barfoo -rotate 270 -extent 200x200  barfoo270200x200.gif
echo '

convert -verbose  label:barfoo -rotate 270 -extent 200x800  barfoo270200x800.gif'
convert -verbose  label:barfoo -rotate 270 -extent 200x800  barfoo270200x800.gif
echo '

convert -verbose  label:barfoo -rotate 270 -extent 800x200  barfoo270800x200.gif'
convert -verbose  label:barfoo -rotate 270 -extent 800x200  barfoo270800x200.gif
echo '

convert -verbose -font Arial  label:foobar  Arialfoobar.gif'
convert -verbose -font Arial  label:foobar  Arialfoobar.gif
echo '

convert -verbose -font Arial  label:foobar -extent 200x200  Arialfoobar200x200.gif'
convert -verbose -font Arial  label:foobar -extent 200x200  Arialfoobar200x200.gif
echo '

convert -verbose -font Arial  label:foobar -extent 200x800  Arialfoobar200x800.gif'
convert -verbose -font Arial  label:foobar -extent 200x800  Arialfoobar200x800.gif
echo '

convert -verbose -font Arial  label:foobar -extent 800x200  Arialfoobar800x200.gif'
convert -verbose -font Arial  label:foobar -extent 800x200  Arialfoobar800x200.gif
echo '

convert -verbose -font Arial  label:foobar -rotate 0  Arialfoobar0.gif'
convert -verbose -font Arial  label:foobar -rotate 0  Arialfoobar0.gif
echo '

convert -verbose -font Arial  label:foobar -rotate 0 -extent 200x200  Arialfoobar0200x200.gif'
convert -verbose -font Arial  label:foobar -rotate 0 -extent 200x200  Arialfoobar0200x200.gif
echo '

convert -verbose -font Arial  label:foobar -rotate 0 -extent 200x800  Arialfoobar0200x800.gif'
convert -verbose -font Arial  label:foobar -rotate 0 -extent 200x800  Arialfoobar0200x800.gif
echo '

convert -verbose -font Arial  label:foobar -rotate 0 -extent 800x200  Arialfoobar0800x200.gif'
convert -verbose -font Arial  label:foobar -rotate 0 -extent 800x200  Arialfoobar0800x200.gif
echo '

convert -verbose -font Arial  label:foobar -rotate 90  Arialfoobar90.gif'
convert -verbose -font Arial  label:foobar -rotate 90  Arialfoobar90.gif
echo '

convert -verbose -font Arial  label:foobar -rotate 90 -extent 200x200  Arialfoobar90200x200.gif'
convert -verbose -font Arial  label:foobar -rotate 90 -extent 200x200  Arialfoobar90200x200.gif
echo '

convert -verbose -font Arial  label:foobar -rotate 90 -extent 200x800  Arialfoobar90200x800.gif'
convert -verbose -font Arial  label:foobar -rotate 90 -extent 200x800  Arialfoobar90200x800.gif
echo '

convert -verbose -font Arial  label:foobar -rotate 90 -extent 800x200  Arialfoobar90800x200.gif'
convert -verbose -font Arial  label:foobar -rotate 90 -extent 800x200  Arialfoobar90800x200.gif
echo '

convert -verbose -font Arial  label:foobar -rotate 270  Arialfoobar270.gif'
convert -verbose -font Arial  label:foobar -rotate 270  Arialfoobar270.gif
echo '

convert -verbose -font Arial  label:foobar -rotate 270 -extent 200x200  Arialfoobar270200x200.gif'
convert -verbose -font Arial  label:foobar -rotate 270 -extent 200x200  Arialfoobar270200x200.gif
echo '

convert -verbose -font Arial  label:foobar -rotate 270 -extent 200x800  Arialfoobar270200x800.gif'
convert -verbose -font Arial  label:foobar -rotate 270 -extent 200x800  Arialfoobar270200x800.gif
echo '

convert -verbose -font Arial  label:foobar -rotate 270 -extent 800x200  Arialfoobar270800x200.gif'
convert -verbose -font Arial  label:foobar -rotate 270 -extent 800x200  Arialfoobar270800x200.gif
echo '

convert -verbose -font Arial  label:barfoo  Arialbarfoo.gif'
convert -verbose -font Arial  label:barfoo  Arialbarfoo.gif
echo '

convert -verbose -font Arial  label:barfoo -extent 200x200  Arialbarfoo200x200.gif'
convert -verbose -font Arial  label:barfoo -extent 200x200  Arialbarfoo200x200.gif
echo '

convert -verbose -font Arial  label:barfoo -extent 200x800  Arialbarfoo200x800.gif'
convert -verbose -font Arial  label:barfoo -extent 200x800  Arialbarfoo200x800.gif
echo '

convert -verbose -font Arial  label:barfoo -extent 800x200  Arialbarfoo800x200.gif'
convert -verbose -font Arial  label:barfoo -extent 800x200  Arialbarfoo800x200.gif
echo '

convert -verbose -font Arial  label:barfoo -rotate 0  Arialbarfoo0.gif'
convert -verbose -font Arial  label:barfoo -rotate 0  Arialbarfoo0.gif
echo '

convert -verbose -font Arial  label:barfoo -rotate 0 -extent 200x200  Arialbarfoo0200x200.gif'
convert -verbose -font Arial  label:barfoo -rotate 0 -extent 200x200  Arialbarfoo0200x200.gif
echo '

convert -verbose -font Arial  label:barfoo -rotate 0 -extent 200x800  Arialbarfoo0200x800.gif'
convert -verbose -font Arial  label:barfoo -rotate 0 -extent 200x800  Arialbarfoo0200x800.gif
echo '

convert -verbose -font Arial  label:barfoo -rotate 0 -extent 800x200  Arialbarfoo0800x200.gif'
convert -verbose -font Arial  label:barfoo -rotate 0 -extent 800x200  Arialbarfoo0800x200.gif
echo '

convert -verbose -font Arial  label:barfoo -rotate 90  Arialbarfoo90.gif'
convert -verbose -font Arial  label:barfoo -rotate 90  Arialbarfoo90.gif
echo '

convert -verbose -font Arial  label:barfoo -rotate 90 -extent 200x200  Arialbarfoo90200x200.gif'
convert -verbose -font Arial  label:barfoo -rotate 90 -extent 200x200  Arialbarfoo90200x200.gif
echo '

convert -verbose -font Arial  label:barfoo -rotate 90 -extent 200x800  Arialbarfoo90200x800.gif'
convert -verbose -font Arial  label:barfoo -rotate 90 -extent 200x800  Arialbarfoo90200x800.gif
echo '

convert -verbose -font Arial  label:barfoo -rotate 90 -extent 800x200  Arialbarfoo90800x200.gif'
convert -verbose -font Arial  label:barfoo -rotate 90 -extent 800x200  Arialbarfoo90800x200.gif
echo '

convert -verbose -font Arial  label:barfoo -rotate 270  Arialbarfoo270.gif'
convert -verbose -font Arial  label:barfoo -rotate 270  Arialbarfoo270.gif
echo '

convert -verbose -font Arial  label:barfoo -rotate 270 -extent 200x200  Arialbarfoo270200x200.gif'
convert -verbose -font Arial  label:barfoo -rotate 270 -extent 200x200  Arialbarfoo270200x200.gif
echo '

convert -verbose -font Arial  label:barfoo -rotate 270 -extent 200x800  Arialbarfoo270200x800.gif'
convert -verbose -font Arial  label:barfoo -rotate 270 -extent 200x800  Arialbarfoo270200x800.gif
echo '

convert -verbose -font Arial  label:barfoo -rotate 270 -extent 800x200  Arialbarfoo270800x200.gif'
convert -verbose -font Arial  label:barfoo -rotate 270 -extent 800x200  Arialbarfoo270800x200.gif
echo '

convert -verbose -pointsize 8  label:foobar  8foobar.gif'
convert -verbose -pointsize 8  label:foobar  8foobar.gif
echo '

convert -verbose -pointsize 8  label:foobar -extent 200x200  8foobar200x200.gif'
convert -verbose -pointsize 8  label:foobar -extent 200x200  8foobar200x200.gif
echo '

convert -verbose -pointsize 8  label:foobar -extent 200x800  8foobar200x800.gif'
convert -verbose -pointsize 8  label:foobar -extent 200x800  8foobar200x800.gif
echo '

convert -verbose -pointsize 8  label:foobar -extent 800x200  8foobar800x200.gif'
convert -verbose -pointsize 8  label:foobar -extent 800x200  8foobar800x200.gif
echo '

convert -verbose -pointsize 8  label:foobar -rotate 0  8foobar0.gif'
convert -verbose -pointsize 8  label:foobar -rotate 0  8foobar0.gif
echo '

convert -verbose -pointsize 8  label:foobar -rotate 0 -extent 200x200  8foobar0200x200.gif'
convert -verbose -pointsize 8  label:foobar -rotate 0 -extent 200x200  8foobar0200x200.gif
echo '

convert -verbose -pointsize 8  label:foobar -rotate 0 -extent 200x800  8foobar0200x800.gif'
convert -verbose -pointsize 8  label:foobar -rotate 0 -extent 200x800  8foobar0200x800.gif
echo '

convert -verbose -pointsize 8  label:foobar -rotate 0 -extent 800x200  8foobar0800x200.gif'
convert -verbose -pointsize 8  label:foobar -rotate 0 -extent 800x200  8foobar0800x200.gif
echo '

convert -verbose -pointsize 8  label:foobar -rotate 90  8foobar90.gif'
convert -verbose -pointsize 8  label:foobar -rotate 90  8foobar90.gif
echo '

convert -verbose -pointsize 8  label:foobar -rotate 90 -extent 200x200  8foobar90200x200.gif'
convert -verbose -pointsize 8  label:foobar -rotate 90 -extent 200x200  8foobar90200x200.gif
echo '

convert -verbose -pointsize 8  label:foobar -rotate 90 -extent 200x800  8foobar90200x800.gif'
convert -verbose -pointsize 8  label:foobar -rotate 90 -extent 200x800  8foobar90200x800.gif
echo '

convert -verbose -pointsize 8  label:foobar -rotate 90 -extent 800x200  8foobar90800x200.gif'
convert -verbose -pointsize 8  label:foobar -rotate 90 -extent 800x200  8foobar90800x200.gif
echo '

convert -verbose -pointsize 8  label:foobar -rotate 270  8foobar270.gif'
convert -verbose -pointsize 8  label:foobar -rotate 270  8foobar270.gif
echo '

convert -verbose -pointsize 8  label:foobar -rotate 270 -extent 200x200  8foobar270200x200.gif'
convert -verbose -pointsize 8  label:foobar -rotate 270 -extent 200x200  8foobar270200x200.gif
echo '

convert -verbose -pointsize 8  label:foobar -rotate 270 -extent 200x800  8foobar270200x800.gif'
convert -verbose -pointsize 8  label:foobar -rotate 270 -extent 200x800  8foobar270200x800.gif
echo '

convert -verbose -pointsize 8  label:foobar -rotate 270 -extent 800x200  8foobar270800x200.gif'
convert -verbose -pointsize 8  label:foobar -rotate 270 -extent 800x200  8foobar270800x200.gif
echo '

convert -verbose -pointsize 8  label:barfoo  8barfoo.gif'
convert -verbose -pointsize 8  label:barfoo  8barfoo.gif
echo '

convert -verbose -pointsize 8  label:barfoo -extent 200x200  8barfoo200x200.gif'
convert -verbose -pointsize 8  label:barfoo -extent 200x200  8barfoo200x200.gif
echo '

convert -verbose -pointsize 8  label:barfoo -extent 200x800  8barfoo200x800.gif'
convert -verbose -pointsize 8  label:barfoo -extent 200x800  8barfoo200x800.gif
echo '

convert -verbose -pointsize 8  label:barfoo -extent 800x200  8barfoo800x200.gif'
convert -verbose -pointsize 8  label:barfoo -extent 800x200  8barfoo800x200.gif
echo '

convert -verbose -pointsize 8  label:barfoo -rotate 0  8barfoo0.gif'
convert -verbose -pointsize 8  label:barfoo -rotate 0  8barfoo0.gif
echo '

convert -verbose -pointsize 8  label:barfoo -rotate 0 -extent 200x200  8barfoo0200x200.gif'
convert -verbose -pointsize 8  label:barfoo -rotate 0 -extent 200x200  8barfoo0200x200.gif
echo '

convert -verbose -pointsize 8  label:barfoo -rotate 0 -extent 200x800  8barfoo0200x800.gif'
convert -verbose -pointsize 8  label:barfoo -rotate 0 -extent 200x800  8barfoo0200x800.gif
echo '

convert -verbose -pointsize 8  label:barfoo -rotate 0 -extent 800x200  8barfoo0800x200.gif'
convert -verbose -pointsize 8  label:barfoo -rotate 0 -extent 800x200  8barfoo0800x200.gif
echo '

convert -verbose -pointsize 8  label:barfoo -rotate 90  8barfoo90.gif'
convert -verbose -pointsize 8  label:barfoo -rotate 90  8barfoo90.gif
echo '

convert -verbose -pointsize 8  label:barfoo -rotate 90 -extent 200x200  8barfoo90200x200.gif'
convert -verbose -pointsize 8  label:barfoo -rotate 90 -extent 200x200  8barfoo90200x200.gif
echo '

convert -verbose -pointsize 8  label:barfoo -rotate 90 -extent 200x800  8barfoo90200x800.gif'
convert -verbose -pointsize 8  label:barfoo -rotate 90 -extent 200x800  8barfoo90200x800.gif
echo '

convert -verbose -pointsize 8  label:barfoo -rotate 90 -extent 800x200  8barfoo90800x200.gif'
convert -verbose -pointsize 8  label:barfoo -rotate 90 -extent 800x200  8barfoo90800x200.gif
echo '

convert -verbose -pointsize 8  label:barfoo -rotate 270  8barfoo270.gif'
convert -verbose -pointsize 8  label:barfoo -rotate 270  8barfoo270.gif
echo '

convert -verbose -pointsize 8  label:barfoo -rotate 270 -extent 200x200  8barfoo270200x200.gif'
convert -verbose -pointsize 8  label:barfoo -rotate 270 -extent 200x200  8barfoo270200x200.gif
echo '

convert -verbose -pointsize 8  label:barfoo -rotate 270 -extent 200x800  8barfoo270200x800.gif'
convert -verbose -pointsize 8  label:barfoo -rotate 270 -extent 200x800  8barfoo270200x800.gif
echo '

convert -verbose -pointsize 8  label:barfoo -rotate 270 -extent 800x200  8barfoo270800x200.gif'
convert -verbose -pointsize 8  label:barfoo -rotate 270 -extent 800x200  8barfoo270800x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar  8Arialfoobar.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar  8Arialfoobar.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -extent 200x200  8Arialfoobar200x200.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -extent 200x200  8Arialfoobar200x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -extent 200x800  8Arialfoobar200x800.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -extent 200x800  8Arialfoobar200x800.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -extent 800x200  8Arialfoobar800x200.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -extent 800x200  8Arialfoobar800x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 0  8Arialfoobar0.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 0  8Arialfoobar0.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  8Arialfoobar0200x200.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  8Arialfoobar0200x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  8Arialfoobar0200x800.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  8Arialfoobar0200x800.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  8Arialfoobar0800x200.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  8Arialfoobar0800x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 90  8Arialfoobar90.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 90  8Arialfoobar90.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  8Arialfoobar90200x200.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  8Arialfoobar90200x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  8Arialfoobar90200x800.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  8Arialfoobar90200x800.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  8Arialfoobar90800x200.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  8Arialfoobar90800x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 270  8Arialfoobar270.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 270  8Arialfoobar270.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  8Arialfoobar270200x200.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  8Arialfoobar270200x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  8Arialfoobar270200x800.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  8Arialfoobar270200x800.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  8Arialfoobar270800x200.gif'
convert -verbose -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  8Arialfoobar270800x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo  8Arialbarfoo.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo  8Arialbarfoo.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -extent 200x200  8Arialbarfoo200x200.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -extent 200x200  8Arialbarfoo200x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -extent 200x800  8Arialbarfoo200x800.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -extent 200x800  8Arialbarfoo200x800.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -extent 800x200  8Arialbarfoo800x200.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -extent 800x200  8Arialbarfoo800x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 0  8Arialbarfoo0.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 0  8Arialbarfoo0.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  8Arialbarfoo0200x200.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  8Arialbarfoo0200x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  8Arialbarfoo0200x800.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  8Arialbarfoo0200x800.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  8Arialbarfoo0800x200.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  8Arialbarfoo0800x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 90  8Arialbarfoo90.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 90  8Arialbarfoo90.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  8Arialbarfoo90200x200.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  8Arialbarfoo90200x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  8Arialbarfoo90200x800.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  8Arialbarfoo90200x800.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  8Arialbarfoo90800x200.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  8Arialbarfoo90800x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 270  8Arialbarfoo270.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 270  8Arialbarfoo270.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  8Arialbarfoo270200x200.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  8Arialbarfoo270200x200.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  8Arialbarfoo270200x800.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  8Arialbarfoo270200x800.gif
echo '

convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  8Arialbarfoo270800x200.gif'
convert -verbose -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  8Arialbarfoo270800x200.gif
echo '

convert -verbose -pointsize 10  label:foobar  10foobar.gif'
convert -verbose -pointsize 10  label:foobar  10foobar.gif
echo '

convert -verbose -pointsize 10  label:foobar -extent 200x200  10foobar200x200.gif'
convert -verbose -pointsize 10  label:foobar -extent 200x200  10foobar200x200.gif
echo '

convert -verbose -pointsize 10  label:foobar -extent 200x800  10foobar200x800.gif'
convert -verbose -pointsize 10  label:foobar -extent 200x800  10foobar200x800.gif
echo '

convert -verbose -pointsize 10  label:foobar -extent 800x200  10foobar800x200.gif'
convert -verbose -pointsize 10  label:foobar -extent 800x200  10foobar800x200.gif
echo '

convert -verbose -pointsize 10  label:foobar -rotate 0  10foobar0.gif'
convert -verbose -pointsize 10  label:foobar -rotate 0  10foobar0.gif
echo '

convert -verbose -pointsize 10  label:foobar -rotate 0 -extent 200x200  10foobar0200x200.gif'
convert -verbose -pointsize 10  label:foobar -rotate 0 -extent 200x200  10foobar0200x200.gif
echo '

convert -verbose -pointsize 10  label:foobar -rotate 0 -extent 200x800  10foobar0200x800.gif'
convert -verbose -pointsize 10  label:foobar -rotate 0 -extent 200x800  10foobar0200x800.gif
echo '

convert -verbose -pointsize 10  label:foobar -rotate 0 -extent 800x200  10foobar0800x200.gif'
convert -verbose -pointsize 10  label:foobar -rotate 0 -extent 800x200  10foobar0800x200.gif
echo '

convert -verbose -pointsize 10  label:foobar -rotate 90  10foobar90.gif'
convert -verbose -pointsize 10  label:foobar -rotate 90  10foobar90.gif
echo '

convert -verbose -pointsize 10  label:foobar -rotate 90 -extent 200x200  10foobar90200x200.gif'
convert -verbose -pointsize 10  label:foobar -rotate 90 -extent 200x200  10foobar90200x200.gif
echo '

convert -verbose -pointsize 10  label:foobar -rotate 90 -extent 200x800  10foobar90200x800.gif'
convert -verbose -pointsize 10  label:foobar -rotate 90 -extent 200x800  10foobar90200x800.gif
echo '

convert -verbose -pointsize 10  label:foobar -rotate 90 -extent 800x200  10foobar90800x200.gif'
convert -verbose -pointsize 10  label:foobar -rotate 90 -extent 800x200  10foobar90800x200.gif
echo '

convert -verbose -pointsize 10  label:foobar -rotate 270  10foobar270.gif'
convert -verbose -pointsize 10  label:foobar -rotate 270  10foobar270.gif
echo '

convert -verbose -pointsize 10  label:foobar -rotate 270 -extent 200x200  10foobar270200x200.gif'
convert -verbose -pointsize 10  label:foobar -rotate 270 -extent 200x200  10foobar270200x200.gif
echo '

convert -verbose -pointsize 10  label:foobar -rotate 270 -extent 200x800  10foobar270200x800.gif'
convert -verbose -pointsize 10  label:foobar -rotate 270 -extent 200x800  10foobar270200x800.gif
echo '

convert -verbose -pointsize 10  label:foobar -rotate 270 -extent 800x200  10foobar270800x200.gif'
convert -verbose -pointsize 10  label:foobar -rotate 270 -extent 800x200  10foobar270800x200.gif
echo '

convert -verbose -pointsize 10  label:barfoo  10barfoo.gif'
convert -verbose -pointsize 10  label:barfoo  10barfoo.gif
echo '

convert -verbose -pointsize 10  label:barfoo -extent 200x200  10barfoo200x200.gif'
convert -verbose -pointsize 10  label:barfoo -extent 200x200  10barfoo200x200.gif
echo '

convert -verbose -pointsize 10  label:barfoo -extent 200x800  10barfoo200x800.gif'
convert -verbose -pointsize 10  label:barfoo -extent 200x800  10barfoo200x800.gif
echo '

convert -verbose -pointsize 10  label:barfoo -extent 800x200  10barfoo800x200.gif'
convert -verbose -pointsize 10  label:barfoo -extent 800x200  10barfoo800x200.gif
echo '

convert -verbose -pointsize 10  label:barfoo -rotate 0  10barfoo0.gif'
convert -verbose -pointsize 10  label:barfoo -rotate 0  10barfoo0.gif
echo '

convert -verbose -pointsize 10  label:barfoo -rotate 0 -extent 200x200  10barfoo0200x200.gif'
convert -verbose -pointsize 10  label:barfoo -rotate 0 -extent 200x200  10barfoo0200x200.gif
echo '

convert -verbose -pointsize 10  label:barfoo -rotate 0 -extent 200x800  10barfoo0200x800.gif'
convert -verbose -pointsize 10  label:barfoo -rotate 0 -extent 200x800  10barfoo0200x800.gif
echo '

convert -verbose -pointsize 10  label:barfoo -rotate 0 -extent 800x200  10barfoo0800x200.gif'
convert -verbose -pointsize 10  label:barfoo -rotate 0 -extent 800x200  10barfoo0800x200.gif
echo '

convert -verbose -pointsize 10  label:barfoo -rotate 90  10barfoo90.gif'
convert -verbose -pointsize 10  label:barfoo -rotate 90  10barfoo90.gif
echo '

convert -verbose -pointsize 10  label:barfoo -rotate 90 -extent 200x200  10barfoo90200x200.gif'
convert -verbose -pointsize 10  label:barfoo -rotate 90 -extent 200x200  10barfoo90200x200.gif
echo '

convert -verbose -pointsize 10  label:barfoo -rotate 90 -extent 200x800  10barfoo90200x800.gif'
convert -verbose -pointsize 10  label:barfoo -rotate 90 -extent 200x800  10barfoo90200x800.gif
echo '

convert -verbose -pointsize 10  label:barfoo -rotate 90 -extent 800x200  10barfoo90800x200.gif'
convert -verbose -pointsize 10  label:barfoo -rotate 90 -extent 800x200  10barfoo90800x200.gif
echo '

convert -verbose -pointsize 10  label:barfoo -rotate 270  10barfoo270.gif'
convert -verbose -pointsize 10  label:barfoo -rotate 270  10barfoo270.gif
echo '

convert -verbose -pointsize 10  label:barfoo -rotate 270 -extent 200x200  10barfoo270200x200.gif'
convert -verbose -pointsize 10  label:barfoo -rotate 270 -extent 200x200  10barfoo270200x200.gif
echo '

convert -verbose -pointsize 10  label:barfoo -rotate 270 -extent 200x800  10barfoo270200x800.gif'
convert -verbose -pointsize 10  label:barfoo -rotate 270 -extent 200x800  10barfoo270200x800.gif
echo '

convert -verbose -pointsize 10  label:barfoo -rotate 270 -extent 800x200  10barfoo270800x200.gif'
convert -verbose -pointsize 10  label:barfoo -rotate 270 -extent 800x200  10barfoo270800x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar  10Arialfoobar.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar  10Arialfoobar.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -extent 200x200  10Arialfoobar200x200.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -extent 200x200  10Arialfoobar200x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -extent 200x800  10Arialfoobar200x800.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -extent 200x800  10Arialfoobar200x800.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -extent 800x200  10Arialfoobar800x200.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -extent 800x200  10Arialfoobar800x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 0  10Arialfoobar0.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 0  10Arialfoobar0.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  10Arialfoobar0200x200.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  10Arialfoobar0200x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  10Arialfoobar0200x800.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  10Arialfoobar0200x800.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  10Arialfoobar0800x200.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  10Arialfoobar0800x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 90  10Arialfoobar90.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 90  10Arialfoobar90.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  10Arialfoobar90200x200.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  10Arialfoobar90200x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  10Arialfoobar90200x800.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  10Arialfoobar90200x800.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  10Arialfoobar90800x200.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  10Arialfoobar90800x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 270  10Arialfoobar270.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 270  10Arialfoobar270.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  10Arialfoobar270200x200.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  10Arialfoobar270200x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  10Arialfoobar270200x800.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  10Arialfoobar270200x800.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  10Arialfoobar270800x200.gif'
convert -verbose -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  10Arialfoobar270800x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo  10Arialbarfoo.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo  10Arialbarfoo.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -extent 200x200  10Arialbarfoo200x200.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -extent 200x200  10Arialbarfoo200x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -extent 200x800  10Arialbarfoo200x800.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -extent 200x800  10Arialbarfoo200x800.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -extent 800x200  10Arialbarfoo800x200.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -extent 800x200  10Arialbarfoo800x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 0  10Arialbarfoo0.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 0  10Arialbarfoo0.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  10Arialbarfoo0200x200.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  10Arialbarfoo0200x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  10Arialbarfoo0200x800.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  10Arialbarfoo0200x800.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  10Arialbarfoo0800x200.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  10Arialbarfoo0800x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 90  10Arialbarfoo90.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 90  10Arialbarfoo90.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  10Arialbarfoo90200x200.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  10Arialbarfoo90200x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  10Arialbarfoo90200x800.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  10Arialbarfoo90200x800.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  10Arialbarfoo90800x200.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  10Arialbarfoo90800x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 270  10Arialbarfoo270.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 270  10Arialbarfoo270.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  10Arialbarfoo270200x200.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  10Arialbarfoo270200x200.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  10Arialbarfoo270200x800.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  10Arialbarfoo270200x800.gif
echo '

convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  10Arialbarfoo270800x200.gif'
convert -verbose -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  10Arialbarfoo270800x200.gif
echo '

convert -verbose -pointsize 12  label:foobar  12foobar.gif'
convert -verbose -pointsize 12  label:foobar  12foobar.gif
echo '

convert -verbose -pointsize 12  label:foobar -extent 200x200  12foobar200x200.gif'
convert -verbose -pointsize 12  label:foobar -extent 200x200  12foobar200x200.gif
echo '

convert -verbose -pointsize 12  label:foobar -extent 200x800  12foobar200x800.gif'
convert -verbose -pointsize 12  label:foobar -extent 200x800  12foobar200x800.gif
echo '

convert -verbose -pointsize 12  label:foobar -extent 800x200  12foobar800x200.gif'
convert -verbose -pointsize 12  label:foobar -extent 800x200  12foobar800x200.gif
echo '

convert -verbose -pointsize 12  label:foobar -rotate 0  12foobar0.gif'
convert -verbose -pointsize 12  label:foobar -rotate 0  12foobar0.gif
echo '

convert -verbose -pointsize 12  label:foobar -rotate 0 -extent 200x200  12foobar0200x200.gif'
convert -verbose -pointsize 12  label:foobar -rotate 0 -extent 200x200  12foobar0200x200.gif
echo '

convert -verbose -pointsize 12  label:foobar -rotate 0 -extent 200x800  12foobar0200x800.gif'
convert -verbose -pointsize 12  label:foobar -rotate 0 -extent 200x800  12foobar0200x800.gif
echo '

convert -verbose -pointsize 12  label:foobar -rotate 0 -extent 800x200  12foobar0800x200.gif'
convert -verbose -pointsize 12  label:foobar -rotate 0 -extent 800x200  12foobar0800x200.gif
echo '

convert -verbose -pointsize 12  label:foobar -rotate 90  12foobar90.gif'
convert -verbose -pointsize 12  label:foobar -rotate 90  12foobar90.gif
echo '

convert -verbose -pointsize 12  label:foobar -rotate 90 -extent 200x200  12foobar90200x200.gif'
convert -verbose -pointsize 12  label:foobar -rotate 90 -extent 200x200  12foobar90200x200.gif
echo '

convert -verbose -pointsize 12  label:foobar -rotate 90 -extent 200x800  12foobar90200x800.gif'
convert -verbose -pointsize 12  label:foobar -rotate 90 -extent 200x800  12foobar90200x800.gif
echo '

convert -verbose -pointsize 12  label:foobar -rotate 90 -extent 800x200  12foobar90800x200.gif'
convert -verbose -pointsize 12  label:foobar -rotate 90 -extent 800x200  12foobar90800x200.gif
echo '

convert -verbose -pointsize 12  label:foobar -rotate 270  12foobar270.gif'
convert -verbose -pointsize 12  label:foobar -rotate 270  12foobar270.gif
echo '

convert -verbose -pointsize 12  label:foobar -rotate 270 -extent 200x200  12foobar270200x200.gif'
convert -verbose -pointsize 12  label:foobar -rotate 270 -extent 200x200  12foobar270200x200.gif
echo '

convert -verbose -pointsize 12  label:foobar -rotate 270 -extent 200x800  12foobar270200x800.gif'
convert -verbose -pointsize 12  label:foobar -rotate 270 -extent 200x800  12foobar270200x800.gif
echo '

convert -verbose -pointsize 12  label:foobar -rotate 270 -extent 800x200  12foobar270800x200.gif'
convert -verbose -pointsize 12  label:foobar -rotate 270 -extent 800x200  12foobar270800x200.gif
echo '

convert -verbose -pointsize 12  label:barfoo  12barfoo.gif'
convert -verbose -pointsize 12  label:barfoo  12barfoo.gif
echo '

convert -verbose -pointsize 12  label:barfoo -extent 200x200  12barfoo200x200.gif'
convert -verbose -pointsize 12  label:barfoo -extent 200x200  12barfoo200x200.gif
echo '

convert -verbose -pointsize 12  label:barfoo -extent 200x800  12barfoo200x800.gif'
convert -verbose -pointsize 12  label:barfoo -extent 200x800  12barfoo200x800.gif
echo '

convert -verbose -pointsize 12  label:barfoo -extent 800x200  12barfoo800x200.gif'
convert -verbose -pointsize 12  label:barfoo -extent 800x200  12barfoo800x200.gif
echo '

convert -verbose -pointsize 12  label:barfoo -rotate 0  12barfoo0.gif'
convert -verbose -pointsize 12  label:barfoo -rotate 0  12barfoo0.gif
echo '

convert -verbose -pointsize 12  label:barfoo -rotate 0 -extent 200x200  12barfoo0200x200.gif'
convert -verbose -pointsize 12  label:barfoo -rotate 0 -extent 200x200  12barfoo0200x200.gif
echo '

convert -verbose -pointsize 12  label:barfoo -rotate 0 -extent 200x800  12barfoo0200x800.gif'
convert -verbose -pointsize 12  label:barfoo -rotate 0 -extent 200x800  12barfoo0200x800.gif
echo '

convert -verbose -pointsize 12  label:barfoo -rotate 0 -extent 800x200  12barfoo0800x200.gif'
convert -verbose -pointsize 12  label:barfoo -rotate 0 -extent 800x200  12barfoo0800x200.gif
echo '

convert -verbose -pointsize 12  label:barfoo -rotate 90  12barfoo90.gif'
convert -verbose -pointsize 12  label:barfoo -rotate 90  12barfoo90.gif
echo '

convert -verbose -pointsize 12  label:barfoo -rotate 90 -extent 200x200  12barfoo90200x200.gif'
convert -verbose -pointsize 12  label:barfoo -rotate 90 -extent 200x200  12barfoo90200x200.gif
echo '

convert -verbose -pointsize 12  label:barfoo -rotate 90 -extent 200x800  12barfoo90200x800.gif'
convert -verbose -pointsize 12  label:barfoo -rotate 90 -extent 200x800  12barfoo90200x800.gif
echo '

convert -verbose -pointsize 12  label:barfoo -rotate 90 -extent 800x200  12barfoo90800x200.gif'
convert -verbose -pointsize 12  label:barfoo -rotate 90 -extent 800x200  12barfoo90800x200.gif
echo '

convert -verbose -pointsize 12  label:barfoo -rotate 270  12barfoo270.gif'
convert -verbose -pointsize 12  label:barfoo -rotate 270  12barfoo270.gif
echo '

convert -verbose -pointsize 12  label:barfoo -rotate 270 -extent 200x200  12barfoo270200x200.gif'
convert -verbose -pointsize 12  label:barfoo -rotate 270 -extent 200x200  12barfoo270200x200.gif
echo '

convert -verbose -pointsize 12  label:barfoo -rotate 270 -extent 200x800  12barfoo270200x800.gif'
convert -verbose -pointsize 12  label:barfoo -rotate 270 -extent 200x800  12barfoo270200x800.gif
echo '

convert -verbose -pointsize 12  label:barfoo -rotate 270 -extent 800x200  12barfoo270800x200.gif'
convert -verbose -pointsize 12  label:barfoo -rotate 270 -extent 800x200  12barfoo270800x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar  12Arialfoobar.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar  12Arialfoobar.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -extent 200x200  12Arialfoobar200x200.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -extent 200x200  12Arialfoobar200x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -extent 200x800  12Arialfoobar200x800.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -extent 200x800  12Arialfoobar200x800.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -extent 800x200  12Arialfoobar800x200.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -extent 800x200  12Arialfoobar800x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 0  12Arialfoobar0.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 0  12Arialfoobar0.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  12Arialfoobar0200x200.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  12Arialfoobar0200x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  12Arialfoobar0200x800.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  12Arialfoobar0200x800.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  12Arialfoobar0800x200.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  12Arialfoobar0800x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 90  12Arialfoobar90.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 90  12Arialfoobar90.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  12Arialfoobar90200x200.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  12Arialfoobar90200x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  12Arialfoobar90200x800.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  12Arialfoobar90200x800.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  12Arialfoobar90800x200.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  12Arialfoobar90800x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 270  12Arialfoobar270.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 270  12Arialfoobar270.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  12Arialfoobar270200x200.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  12Arialfoobar270200x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  12Arialfoobar270200x800.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  12Arialfoobar270200x800.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  12Arialfoobar270800x200.gif'
convert -verbose -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  12Arialfoobar270800x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo  12Arialbarfoo.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo  12Arialbarfoo.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -extent 200x200  12Arialbarfoo200x200.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -extent 200x200  12Arialbarfoo200x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -extent 200x800  12Arialbarfoo200x800.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -extent 200x800  12Arialbarfoo200x800.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -extent 800x200  12Arialbarfoo800x200.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -extent 800x200  12Arialbarfoo800x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 0  12Arialbarfoo0.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 0  12Arialbarfoo0.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  12Arialbarfoo0200x200.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  12Arialbarfoo0200x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  12Arialbarfoo0200x800.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  12Arialbarfoo0200x800.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  12Arialbarfoo0800x200.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  12Arialbarfoo0800x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 90  12Arialbarfoo90.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 90  12Arialbarfoo90.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  12Arialbarfoo90200x200.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  12Arialbarfoo90200x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  12Arialbarfoo90200x800.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  12Arialbarfoo90200x800.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  12Arialbarfoo90800x200.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  12Arialbarfoo90800x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 270  12Arialbarfoo270.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 270  12Arialbarfoo270.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  12Arialbarfoo270200x200.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  12Arialbarfoo270200x200.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  12Arialbarfoo270200x800.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  12Arialbarfoo270200x800.gif
echo '

convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  12Arialbarfoo270800x200.gif'
convert -verbose -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  12Arialbarfoo270800x200.gif
echo '

convert -verbose -pointsize 18  label:foobar  18foobar.gif'
convert -verbose -pointsize 18  label:foobar  18foobar.gif
echo '

convert -verbose -pointsize 18  label:foobar -extent 200x200  18foobar200x200.gif'
convert -verbose -pointsize 18  label:foobar -extent 200x200  18foobar200x200.gif
echo '

convert -verbose -pointsize 18  label:foobar -extent 200x800  18foobar200x800.gif'
convert -verbose -pointsize 18  label:foobar -extent 200x800  18foobar200x800.gif
echo '

convert -verbose -pointsize 18  label:foobar -extent 800x200  18foobar800x200.gif'
convert -verbose -pointsize 18  label:foobar -extent 800x200  18foobar800x200.gif
echo '

convert -verbose -pointsize 18  label:foobar -rotate 0  18foobar0.gif'
convert -verbose -pointsize 18  label:foobar -rotate 0  18foobar0.gif
echo '

convert -verbose -pointsize 18  label:foobar -rotate 0 -extent 200x200  18foobar0200x200.gif'
convert -verbose -pointsize 18  label:foobar -rotate 0 -extent 200x200  18foobar0200x200.gif
echo '

convert -verbose -pointsize 18  label:foobar -rotate 0 -extent 200x800  18foobar0200x800.gif'
convert -verbose -pointsize 18  label:foobar -rotate 0 -extent 200x800  18foobar0200x800.gif
echo '

convert -verbose -pointsize 18  label:foobar -rotate 0 -extent 800x200  18foobar0800x200.gif'
convert -verbose -pointsize 18  label:foobar -rotate 0 -extent 800x200  18foobar0800x200.gif
echo '

convert -verbose -pointsize 18  label:foobar -rotate 90  18foobar90.gif'
convert -verbose -pointsize 18  label:foobar -rotate 90  18foobar90.gif
echo '

convert -verbose -pointsize 18  label:foobar -rotate 90 -extent 200x200  18foobar90200x200.gif'
convert -verbose -pointsize 18  label:foobar -rotate 90 -extent 200x200  18foobar90200x200.gif
echo '

convert -verbose -pointsize 18  label:foobar -rotate 90 -extent 200x800  18foobar90200x800.gif'
convert -verbose -pointsize 18  label:foobar -rotate 90 -extent 200x800  18foobar90200x800.gif
echo '

convert -verbose -pointsize 18  label:foobar -rotate 90 -extent 800x200  18foobar90800x200.gif'
convert -verbose -pointsize 18  label:foobar -rotate 90 -extent 800x200  18foobar90800x200.gif
echo '

convert -verbose -pointsize 18  label:foobar -rotate 270  18foobar270.gif'
convert -verbose -pointsize 18  label:foobar -rotate 270  18foobar270.gif
echo '

convert -verbose -pointsize 18  label:foobar -rotate 270 -extent 200x200  18foobar270200x200.gif'
convert -verbose -pointsize 18  label:foobar -rotate 270 -extent 200x200  18foobar270200x200.gif
echo '

convert -verbose -pointsize 18  label:foobar -rotate 270 -extent 200x800  18foobar270200x800.gif'
convert -verbose -pointsize 18  label:foobar -rotate 270 -extent 200x800  18foobar270200x800.gif
echo '

convert -verbose -pointsize 18  label:foobar -rotate 270 -extent 800x200  18foobar270800x200.gif'
convert -verbose -pointsize 18  label:foobar -rotate 270 -extent 800x200  18foobar270800x200.gif
echo '

convert -verbose -pointsize 18  label:barfoo  18barfoo.gif'
convert -verbose -pointsize 18  label:barfoo  18barfoo.gif
echo '

convert -verbose -pointsize 18  label:barfoo -extent 200x200  18barfoo200x200.gif'
convert -verbose -pointsize 18  label:barfoo -extent 200x200  18barfoo200x200.gif
echo '

convert -verbose -pointsize 18  label:barfoo -extent 200x800  18barfoo200x800.gif'
convert -verbose -pointsize 18  label:barfoo -extent 200x800  18barfoo200x800.gif
echo '

convert -verbose -pointsize 18  label:barfoo -extent 800x200  18barfoo800x200.gif'
convert -verbose -pointsize 18  label:barfoo -extent 800x200  18barfoo800x200.gif
echo '

convert -verbose -pointsize 18  label:barfoo -rotate 0  18barfoo0.gif'
convert -verbose -pointsize 18  label:barfoo -rotate 0  18barfoo0.gif
echo '

convert -verbose -pointsize 18  label:barfoo -rotate 0 -extent 200x200  18barfoo0200x200.gif'
convert -verbose -pointsize 18  label:barfoo -rotate 0 -extent 200x200  18barfoo0200x200.gif
echo '

convert -verbose -pointsize 18  label:barfoo -rotate 0 -extent 200x800  18barfoo0200x800.gif'
convert -verbose -pointsize 18  label:barfoo -rotate 0 -extent 200x800  18barfoo0200x800.gif
echo '

convert -verbose -pointsize 18  label:barfoo -rotate 0 -extent 800x200  18barfoo0800x200.gif'
convert -verbose -pointsize 18  label:barfoo -rotate 0 -extent 800x200  18barfoo0800x200.gif
echo '

convert -verbose -pointsize 18  label:barfoo -rotate 90  18barfoo90.gif'
convert -verbose -pointsize 18  label:barfoo -rotate 90  18barfoo90.gif
echo '

convert -verbose -pointsize 18  label:barfoo -rotate 90 -extent 200x200  18barfoo90200x200.gif'
convert -verbose -pointsize 18  label:barfoo -rotate 90 -extent 200x200  18barfoo90200x200.gif
echo '

convert -verbose -pointsize 18  label:barfoo -rotate 90 -extent 200x800  18barfoo90200x800.gif'
convert -verbose -pointsize 18  label:barfoo -rotate 90 -extent 200x800  18barfoo90200x800.gif
echo '

convert -verbose -pointsize 18  label:barfoo -rotate 90 -extent 800x200  18barfoo90800x200.gif'
convert -verbose -pointsize 18  label:barfoo -rotate 90 -extent 800x200  18barfoo90800x200.gif
echo '

convert -verbose -pointsize 18  label:barfoo -rotate 270  18barfoo270.gif'
convert -verbose -pointsize 18  label:barfoo -rotate 270  18barfoo270.gif
echo '

convert -verbose -pointsize 18  label:barfoo -rotate 270 -extent 200x200  18barfoo270200x200.gif'
convert -verbose -pointsize 18  label:barfoo -rotate 270 -extent 200x200  18barfoo270200x200.gif
echo '

convert -verbose -pointsize 18  label:barfoo -rotate 270 -extent 200x800  18barfoo270200x800.gif'
convert -verbose -pointsize 18  label:barfoo -rotate 270 -extent 200x800  18barfoo270200x800.gif
echo '

convert -verbose -pointsize 18  label:barfoo -rotate 270 -extent 800x200  18barfoo270800x200.gif'
convert -verbose -pointsize 18  label:barfoo -rotate 270 -extent 800x200  18barfoo270800x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar  18Arialfoobar.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar  18Arialfoobar.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -extent 200x200  18Arialfoobar200x200.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -extent 200x200  18Arialfoobar200x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -extent 200x800  18Arialfoobar200x800.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -extent 200x800  18Arialfoobar200x800.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -extent 800x200  18Arialfoobar800x200.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -extent 800x200  18Arialfoobar800x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 0  18Arialfoobar0.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 0  18Arialfoobar0.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  18Arialfoobar0200x200.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  18Arialfoobar0200x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  18Arialfoobar0200x800.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  18Arialfoobar0200x800.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  18Arialfoobar0800x200.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  18Arialfoobar0800x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 90  18Arialfoobar90.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 90  18Arialfoobar90.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  18Arialfoobar90200x200.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  18Arialfoobar90200x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  18Arialfoobar90200x800.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  18Arialfoobar90200x800.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  18Arialfoobar90800x200.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  18Arialfoobar90800x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 270  18Arialfoobar270.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 270  18Arialfoobar270.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  18Arialfoobar270200x200.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  18Arialfoobar270200x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  18Arialfoobar270200x800.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  18Arialfoobar270200x800.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  18Arialfoobar270800x200.gif'
convert -verbose -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  18Arialfoobar270800x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo  18Arialbarfoo.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo  18Arialbarfoo.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -extent 200x200  18Arialbarfoo200x200.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -extent 200x200  18Arialbarfoo200x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -extent 200x800  18Arialbarfoo200x800.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -extent 200x800  18Arialbarfoo200x800.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -extent 800x200  18Arialbarfoo800x200.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -extent 800x200  18Arialbarfoo800x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 0  18Arialbarfoo0.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 0  18Arialbarfoo0.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  18Arialbarfoo0200x200.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  18Arialbarfoo0200x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  18Arialbarfoo0200x800.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  18Arialbarfoo0200x800.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  18Arialbarfoo0800x200.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  18Arialbarfoo0800x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 90  18Arialbarfoo90.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 90  18Arialbarfoo90.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  18Arialbarfoo90200x200.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  18Arialbarfoo90200x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  18Arialbarfoo90200x800.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  18Arialbarfoo90200x800.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  18Arialbarfoo90800x200.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  18Arialbarfoo90800x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 270  18Arialbarfoo270.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 270  18Arialbarfoo270.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  18Arialbarfoo270200x200.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  18Arialbarfoo270200x200.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  18Arialbarfoo270200x800.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  18Arialbarfoo270200x800.gif
echo '

convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  18Arialbarfoo270800x200.gif'
convert -verbose -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  18Arialbarfoo270800x200.gif
echo '

convert -verbose -pointsize 24  label:foobar  24foobar.gif'
convert -verbose -pointsize 24  label:foobar  24foobar.gif
echo '

convert -verbose -pointsize 24  label:foobar -extent 200x200  24foobar200x200.gif'
convert -verbose -pointsize 24  label:foobar -extent 200x200  24foobar200x200.gif
echo '

convert -verbose -pointsize 24  label:foobar -extent 200x800  24foobar200x800.gif'
convert -verbose -pointsize 24  label:foobar -extent 200x800  24foobar200x800.gif
echo '

convert -verbose -pointsize 24  label:foobar -extent 800x200  24foobar800x200.gif'
convert -verbose -pointsize 24  label:foobar -extent 800x200  24foobar800x200.gif
echo '

convert -verbose -pointsize 24  label:foobar -rotate 0  24foobar0.gif'
convert -verbose -pointsize 24  label:foobar -rotate 0  24foobar0.gif
echo '

convert -verbose -pointsize 24  label:foobar -rotate 0 -extent 200x200  24foobar0200x200.gif'
convert -verbose -pointsize 24  label:foobar -rotate 0 -extent 200x200  24foobar0200x200.gif
echo '

convert -verbose -pointsize 24  label:foobar -rotate 0 -extent 200x800  24foobar0200x800.gif'
convert -verbose -pointsize 24  label:foobar -rotate 0 -extent 200x800  24foobar0200x800.gif
echo '

convert -verbose -pointsize 24  label:foobar -rotate 0 -extent 800x200  24foobar0800x200.gif'
convert -verbose -pointsize 24  label:foobar -rotate 0 -extent 800x200  24foobar0800x200.gif
echo '

convert -verbose -pointsize 24  label:foobar -rotate 90  24foobar90.gif'
convert -verbose -pointsize 24  label:foobar -rotate 90  24foobar90.gif
echo '

convert -verbose -pointsize 24  label:foobar -rotate 90 -extent 200x200  24foobar90200x200.gif'
convert -verbose -pointsize 24  label:foobar -rotate 90 -extent 200x200  24foobar90200x200.gif
echo '

convert -verbose -pointsize 24  label:foobar -rotate 90 -extent 200x800  24foobar90200x800.gif'
convert -verbose -pointsize 24  label:foobar -rotate 90 -extent 200x800  24foobar90200x800.gif
echo '

convert -verbose -pointsize 24  label:foobar -rotate 90 -extent 800x200  24foobar90800x200.gif'
convert -verbose -pointsize 24  label:foobar -rotate 90 -extent 800x200  24foobar90800x200.gif
echo '

convert -verbose -pointsize 24  label:foobar -rotate 270  24foobar270.gif'
convert -verbose -pointsize 24  label:foobar -rotate 270  24foobar270.gif
echo '

convert -verbose -pointsize 24  label:foobar -rotate 270 -extent 200x200  24foobar270200x200.gif'
convert -verbose -pointsize 24  label:foobar -rotate 270 -extent 200x200  24foobar270200x200.gif
echo '

convert -verbose -pointsize 24  label:foobar -rotate 270 -extent 200x800  24foobar270200x800.gif'
convert -verbose -pointsize 24  label:foobar -rotate 270 -extent 200x800  24foobar270200x800.gif
echo '

convert -verbose -pointsize 24  label:foobar -rotate 270 -extent 800x200  24foobar270800x200.gif'
convert -verbose -pointsize 24  label:foobar -rotate 270 -extent 800x200  24foobar270800x200.gif
echo '

convert -verbose -pointsize 24  label:barfoo  24barfoo.gif'
convert -verbose -pointsize 24  label:barfoo  24barfoo.gif
echo '

convert -verbose -pointsize 24  label:barfoo -extent 200x200  24barfoo200x200.gif'
convert -verbose -pointsize 24  label:barfoo -extent 200x200  24barfoo200x200.gif
echo '

convert -verbose -pointsize 24  label:barfoo -extent 200x800  24barfoo200x800.gif'
convert -verbose -pointsize 24  label:barfoo -extent 200x800  24barfoo200x800.gif
echo '

convert -verbose -pointsize 24  label:barfoo -extent 800x200  24barfoo800x200.gif'
convert -verbose -pointsize 24  label:barfoo -extent 800x200  24barfoo800x200.gif
echo '

convert -verbose -pointsize 24  label:barfoo -rotate 0  24barfoo0.gif'
convert -verbose -pointsize 24  label:barfoo -rotate 0  24barfoo0.gif
echo '

convert -verbose -pointsize 24  label:barfoo -rotate 0 -extent 200x200  24barfoo0200x200.gif'
convert -verbose -pointsize 24  label:barfoo -rotate 0 -extent 200x200  24barfoo0200x200.gif
echo '

convert -verbose -pointsize 24  label:barfoo -rotate 0 -extent 200x800  24barfoo0200x800.gif'
convert -verbose -pointsize 24  label:barfoo -rotate 0 -extent 200x800  24barfoo0200x800.gif
echo '

convert -verbose -pointsize 24  label:barfoo -rotate 0 -extent 800x200  24barfoo0800x200.gif'
convert -verbose -pointsize 24  label:barfoo -rotate 0 -extent 800x200  24barfoo0800x200.gif
echo '

convert -verbose -pointsize 24  label:barfoo -rotate 90  24barfoo90.gif'
convert -verbose -pointsize 24  label:barfoo -rotate 90  24barfoo90.gif
echo '

convert -verbose -pointsize 24  label:barfoo -rotate 90 -extent 200x200  24barfoo90200x200.gif'
convert -verbose -pointsize 24  label:barfoo -rotate 90 -extent 200x200  24barfoo90200x200.gif
echo '

convert -verbose -pointsize 24  label:barfoo -rotate 90 -extent 200x800  24barfoo90200x800.gif'
convert -verbose -pointsize 24  label:barfoo -rotate 90 -extent 200x800  24barfoo90200x800.gif
echo '

convert -verbose -pointsize 24  label:barfoo -rotate 90 -extent 800x200  24barfoo90800x200.gif'
convert -verbose -pointsize 24  label:barfoo -rotate 90 -extent 800x200  24barfoo90800x200.gif
echo '

convert -verbose -pointsize 24  label:barfoo -rotate 270  24barfoo270.gif'
convert -verbose -pointsize 24  label:barfoo -rotate 270  24barfoo270.gif
echo '

convert -verbose -pointsize 24  label:barfoo -rotate 270 -extent 200x200  24barfoo270200x200.gif'
convert -verbose -pointsize 24  label:barfoo -rotate 270 -extent 200x200  24barfoo270200x200.gif
echo '

convert -verbose -pointsize 24  label:barfoo -rotate 270 -extent 200x800  24barfoo270200x800.gif'
convert -verbose -pointsize 24  label:barfoo -rotate 270 -extent 200x800  24barfoo270200x800.gif
echo '

convert -verbose -pointsize 24  label:barfoo -rotate 270 -extent 800x200  24barfoo270800x200.gif'
convert -verbose -pointsize 24  label:barfoo -rotate 270 -extent 800x200  24barfoo270800x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar  24Arialfoobar.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar  24Arialfoobar.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -extent 200x200  24Arialfoobar200x200.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -extent 200x200  24Arialfoobar200x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -extent 200x800  24Arialfoobar200x800.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -extent 200x800  24Arialfoobar200x800.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -extent 800x200  24Arialfoobar800x200.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -extent 800x200  24Arialfoobar800x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 0  24Arialfoobar0.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 0  24Arialfoobar0.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  24Arialfoobar0200x200.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  24Arialfoobar0200x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  24Arialfoobar0200x800.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  24Arialfoobar0200x800.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  24Arialfoobar0800x200.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  24Arialfoobar0800x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 90  24Arialfoobar90.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 90  24Arialfoobar90.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  24Arialfoobar90200x200.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  24Arialfoobar90200x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  24Arialfoobar90200x800.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  24Arialfoobar90200x800.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  24Arialfoobar90800x200.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  24Arialfoobar90800x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 270  24Arialfoobar270.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 270  24Arialfoobar270.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  24Arialfoobar270200x200.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  24Arialfoobar270200x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  24Arialfoobar270200x800.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  24Arialfoobar270200x800.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  24Arialfoobar270800x200.gif'
convert -verbose -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  24Arialfoobar270800x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo  24Arialbarfoo.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo  24Arialbarfoo.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -extent 200x200  24Arialbarfoo200x200.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -extent 200x200  24Arialbarfoo200x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -extent 200x800  24Arialbarfoo200x800.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -extent 200x800  24Arialbarfoo200x800.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -extent 800x200  24Arialbarfoo800x200.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -extent 800x200  24Arialbarfoo800x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 0  24Arialbarfoo0.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 0  24Arialbarfoo0.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  24Arialbarfoo0200x200.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  24Arialbarfoo0200x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  24Arialbarfoo0200x800.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  24Arialbarfoo0200x800.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  24Arialbarfoo0800x200.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  24Arialbarfoo0800x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 90  24Arialbarfoo90.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 90  24Arialbarfoo90.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  24Arialbarfoo90200x200.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  24Arialbarfoo90200x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  24Arialbarfoo90200x800.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  24Arialbarfoo90200x800.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  24Arialbarfoo90800x200.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  24Arialbarfoo90800x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 270  24Arialbarfoo270.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 270  24Arialbarfoo270.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  24Arialbarfoo270200x200.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  24Arialbarfoo270200x200.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  24Arialbarfoo270200x800.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  24Arialbarfoo270200x800.gif
echo '

convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  24Arialbarfoo270800x200.gif'
convert -verbose -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  24Arialbarfoo270800x200.gif
echo '

convert -verbose -pointsize 48  label:foobar  48foobar.gif'
convert -verbose -pointsize 48  label:foobar  48foobar.gif
echo '

convert -verbose -pointsize 48  label:foobar -extent 200x200  48foobar200x200.gif'
convert -verbose -pointsize 48  label:foobar -extent 200x200  48foobar200x200.gif
echo '

convert -verbose -pointsize 48  label:foobar -extent 200x800  48foobar200x800.gif'
convert -verbose -pointsize 48  label:foobar -extent 200x800  48foobar200x800.gif
echo '

convert -verbose -pointsize 48  label:foobar -extent 800x200  48foobar800x200.gif'
convert -verbose -pointsize 48  label:foobar -extent 800x200  48foobar800x200.gif
echo '

convert -verbose -pointsize 48  label:foobar -rotate 0  48foobar0.gif'
convert -verbose -pointsize 48  label:foobar -rotate 0  48foobar0.gif
echo '

convert -verbose -pointsize 48  label:foobar -rotate 0 -extent 200x200  48foobar0200x200.gif'
convert -verbose -pointsize 48  label:foobar -rotate 0 -extent 200x200  48foobar0200x200.gif
echo '

convert -verbose -pointsize 48  label:foobar -rotate 0 -extent 200x800  48foobar0200x800.gif'
convert -verbose -pointsize 48  label:foobar -rotate 0 -extent 200x800  48foobar0200x800.gif
echo '

convert -verbose -pointsize 48  label:foobar -rotate 0 -extent 800x200  48foobar0800x200.gif'
convert -verbose -pointsize 48  label:foobar -rotate 0 -extent 800x200  48foobar0800x200.gif
echo '

convert -verbose -pointsize 48  label:foobar -rotate 90  48foobar90.gif'
convert -verbose -pointsize 48  label:foobar -rotate 90  48foobar90.gif
echo '

convert -verbose -pointsize 48  label:foobar -rotate 90 -extent 200x200  48foobar90200x200.gif'
convert -verbose -pointsize 48  label:foobar -rotate 90 -extent 200x200  48foobar90200x200.gif
echo '

convert -verbose -pointsize 48  label:foobar -rotate 90 -extent 200x800  48foobar90200x800.gif'
convert -verbose -pointsize 48  label:foobar -rotate 90 -extent 200x800  48foobar90200x800.gif
echo '

convert -verbose -pointsize 48  label:foobar -rotate 90 -extent 800x200  48foobar90800x200.gif'
convert -verbose -pointsize 48  label:foobar -rotate 90 -extent 800x200  48foobar90800x200.gif
echo '

convert -verbose -pointsize 48  label:foobar -rotate 270  48foobar270.gif'
convert -verbose -pointsize 48  label:foobar -rotate 270  48foobar270.gif
echo '

convert -verbose -pointsize 48  label:foobar -rotate 270 -extent 200x200  48foobar270200x200.gif'
convert -verbose -pointsize 48  label:foobar -rotate 270 -extent 200x200  48foobar270200x200.gif
echo '

convert -verbose -pointsize 48  label:foobar -rotate 270 -extent 200x800  48foobar270200x800.gif'
convert -verbose -pointsize 48  label:foobar -rotate 270 -extent 200x800  48foobar270200x800.gif
echo '

convert -verbose -pointsize 48  label:foobar -rotate 270 -extent 800x200  48foobar270800x200.gif'
convert -verbose -pointsize 48  label:foobar -rotate 270 -extent 800x200  48foobar270800x200.gif
echo '

convert -verbose -pointsize 48  label:barfoo  48barfoo.gif'
convert -verbose -pointsize 48  label:barfoo  48barfoo.gif
echo '

convert -verbose -pointsize 48  label:barfoo -extent 200x200  48barfoo200x200.gif'
convert -verbose -pointsize 48  label:barfoo -extent 200x200  48barfoo200x200.gif
echo '

convert -verbose -pointsize 48  label:barfoo -extent 200x800  48barfoo200x800.gif'
convert -verbose -pointsize 48  label:barfoo -extent 200x800  48barfoo200x800.gif
echo '

convert -verbose -pointsize 48  label:barfoo -extent 800x200  48barfoo800x200.gif'
convert -verbose -pointsize 48  label:barfoo -extent 800x200  48barfoo800x200.gif
echo '

convert -verbose -pointsize 48  label:barfoo -rotate 0  48barfoo0.gif'
convert -verbose -pointsize 48  label:barfoo -rotate 0  48barfoo0.gif
echo '

convert -verbose -pointsize 48  label:barfoo -rotate 0 -extent 200x200  48barfoo0200x200.gif'
convert -verbose -pointsize 48  label:barfoo -rotate 0 -extent 200x200  48barfoo0200x200.gif
echo '

convert -verbose -pointsize 48  label:barfoo -rotate 0 -extent 200x800  48barfoo0200x800.gif'
convert -verbose -pointsize 48  label:barfoo -rotate 0 -extent 200x800  48barfoo0200x800.gif
echo '

convert -verbose -pointsize 48  label:barfoo -rotate 0 -extent 800x200  48barfoo0800x200.gif'
convert -verbose -pointsize 48  label:barfoo -rotate 0 -extent 800x200  48barfoo0800x200.gif
echo '

convert -verbose -pointsize 48  label:barfoo -rotate 90  48barfoo90.gif'
convert -verbose -pointsize 48  label:barfoo -rotate 90  48barfoo90.gif
echo '

convert -verbose -pointsize 48  label:barfoo -rotate 90 -extent 200x200  48barfoo90200x200.gif'
convert -verbose -pointsize 48  label:barfoo -rotate 90 -extent 200x200  48barfoo90200x200.gif
echo '

convert -verbose -pointsize 48  label:barfoo -rotate 90 -extent 200x800  48barfoo90200x800.gif'
convert -verbose -pointsize 48  label:barfoo -rotate 90 -extent 200x800  48barfoo90200x800.gif
echo '

convert -verbose -pointsize 48  label:barfoo -rotate 90 -extent 800x200  48barfoo90800x200.gif'
convert -verbose -pointsize 48  label:barfoo -rotate 90 -extent 800x200  48barfoo90800x200.gif
echo '

convert -verbose -pointsize 48  label:barfoo -rotate 270  48barfoo270.gif'
convert -verbose -pointsize 48  label:barfoo -rotate 270  48barfoo270.gif
echo '

convert -verbose -pointsize 48  label:barfoo -rotate 270 -extent 200x200  48barfoo270200x200.gif'
convert -verbose -pointsize 48  label:barfoo -rotate 270 -extent 200x200  48barfoo270200x200.gif
echo '

convert -verbose -pointsize 48  label:barfoo -rotate 270 -extent 200x800  48barfoo270200x800.gif'
convert -verbose -pointsize 48  label:barfoo -rotate 270 -extent 200x800  48barfoo270200x800.gif
echo '

convert -verbose -pointsize 48  label:barfoo -rotate 270 -extent 800x200  48barfoo270800x200.gif'
convert -verbose -pointsize 48  label:barfoo -rotate 270 -extent 800x200  48barfoo270800x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar  48Arialfoobar.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar  48Arialfoobar.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -extent 200x200  48Arialfoobar200x200.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -extent 200x200  48Arialfoobar200x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -extent 200x800  48Arialfoobar200x800.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -extent 200x800  48Arialfoobar200x800.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -extent 800x200  48Arialfoobar800x200.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -extent 800x200  48Arialfoobar800x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 0  48Arialfoobar0.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 0  48Arialfoobar0.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  48Arialfoobar0200x200.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  48Arialfoobar0200x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  48Arialfoobar0200x800.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  48Arialfoobar0200x800.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  48Arialfoobar0800x200.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  48Arialfoobar0800x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 90  48Arialfoobar90.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 90  48Arialfoobar90.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  48Arialfoobar90200x200.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  48Arialfoobar90200x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  48Arialfoobar90200x800.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  48Arialfoobar90200x800.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  48Arialfoobar90800x200.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  48Arialfoobar90800x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 270  48Arialfoobar270.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 270  48Arialfoobar270.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  48Arialfoobar270200x200.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  48Arialfoobar270200x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  48Arialfoobar270200x800.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  48Arialfoobar270200x800.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  48Arialfoobar270800x200.gif'
convert -verbose -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  48Arialfoobar270800x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo  48Arialbarfoo.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo  48Arialbarfoo.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -extent 200x200  48Arialbarfoo200x200.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -extent 200x200  48Arialbarfoo200x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -extent 200x800  48Arialbarfoo200x800.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -extent 200x800  48Arialbarfoo200x800.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -extent 800x200  48Arialbarfoo800x200.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -extent 800x200  48Arialbarfoo800x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 0  48Arialbarfoo0.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 0  48Arialbarfoo0.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  48Arialbarfoo0200x200.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  48Arialbarfoo0200x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  48Arialbarfoo0200x800.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  48Arialbarfoo0200x800.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  48Arialbarfoo0800x200.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  48Arialbarfoo0800x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 90  48Arialbarfoo90.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 90  48Arialbarfoo90.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  48Arialbarfoo90200x200.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  48Arialbarfoo90200x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  48Arialbarfoo90200x800.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  48Arialbarfoo90200x800.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  48Arialbarfoo90800x200.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  48Arialbarfoo90800x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 270  48Arialbarfoo270.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 270  48Arialbarfoo270.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  48Arialbarfoo270200x200.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  48Arialbarfoo270200x200.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  48Arialbarfoo270200x800.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  48Arialbarfoo270200x800.gif
echo '

convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  48Arialbarfoo270800x200.gif'
convert -verbose -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  48Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar  d6d2d0foobar.gif'
convert -verbose -background '#d6d2d0'  label:foobar  d6d2d0foobar.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -extent 200x200  d6d2d0foobar200x200.gif'
convert -verbose -background '#d6d2d0'  label:foobar -extent 200x200  d6d2d0foobar200x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -extent 200x800  d6d2d0foobar200x800.gif'
convert -verbose -background '#d6d2d0'  label:foobar -extent 200x800  d6d2d0foobar200x800.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -extent 800x200  d6d2d0foobar800x200.gif'
convert -verbose -background '#d6d2d0'  label:foobar -extent 800x200  d6d2d0foobar800x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -rotate 0  d6d2d0foobar0.gif'
convert -verbose -background '#d6d2d0'  label:foobar -rotate 0  d6d2d0foobar0.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -rotate 0 -extent 200x200  d6d2d0foobar0200x200.gif'
convert -verbose -background '#d6d2d0'  label:foobar -rotate 0 -extent 200x200  d6d2d0foobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -rotate 0 -extent 200x800  d6d2d0foobar0200x800.gif'
convert -verbose -background '#d6d2d0'  label:foobar -rotate 0 -extent 200x800  d6d2d0foobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -rotate 0 -extent 800x200  d6d2d0foobar0800x200.gif'
convert -verbose -background '#d6d2d0'  label:foobar -rotate 0 -extent 800x200  d6d2d0foobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -rotate 90  d6d2d0foobar90.gif'
convert -verbose -background '#d6d2d0'  label:foobar -rotate 90  d6d2d0foobar90.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -rotate 90 -extent 200x200  d6d2d0foobar90200x200.gif'
convert -verbose -background '#d6d2d0'  label:foobar -rotate 90 -extent 200x200  d6d2d0foobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -rotate 90 -extent 200x800  d6d2d0foobar90200x800.gif'
convert -verbose -background '#d6d2d0'  label:foobar -rotate 90 -extent 200x800  d6d2d0foobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -rotate 90 -extent 800x200  d6d2d0foobar90800x200.gif'
convert -verbose -background '#d6d2d0'  label:foobar -rotate 90 -extent 800x200  d6d2d0foobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -rotate 270  d6d2d0foobar270.gif'
convert -verbose -background '#d6d2d0'  label:foobar -rotate 270  d6d2d0foobar270.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -rotate 270 -extent 200x200  d6d2d0foobar270200x200.gif'
convert -verbose -background '#d6d2d0'  label:foobar -rotate 270 -extent 200x200  d6d2d0foobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -rotate 270 -extent 200x800  d6d2d0foobar270200x800.gif'
convert -verbose -background '#d6d2d0'  label:foobar -rotate 270 -extent 200x800  d6d2d0foobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0'  label:foobar -rotate 270 -extent 800x200  d6d2d0foobar270800x200.gif'
convert -verbose -background '#d6d2d0'  label:foobar -rotate 270 -extent 800x200  d6d2d0foobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo  d6d2d0barfoo.gif'
convert -verbose -background '#d6d2d0'  label:barfoo  d6d2d0barfoo.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -extent 200x200  d6d2d0barfoo200x200.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -extent 200x200  d6d2d0barfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -extent 200x800  d6d2d0barfoo200x800.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -extent 200x800  d6d2d0barfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -extent 800x200  d6d2d0barfoo800x200.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -extent 800x200  d6d2d0barfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -rotate 0  d6d2d0barfoo0.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -rotate 0  d6d2d0barfoo0.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -rotate 0 -extent 200x200  d6d2d0barfoo0200x200.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -rotate 0 -extent 200x200  d6d2d0barfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -rotate 0 -extent 200x800  d6d2d0barfoo0200x800.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -rotate 0 -extent 200x800  d6d2d0barfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -rotate 0 -extent 800x200  d6d2d0barfoo0800x200.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -rotate 0 -extent 800x200  d6d2d0barfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -rotate 90  d6d2d0barfoo90.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -rotate 90  d6d2d0barfoo90.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -rotate 90 -extent 200x200  d6d2d0barfoo90200x200.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -rotate 90 -extent 200x200  d6d2d0barfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -rotate 90 -extent 200x800  d6d2d0barfoo90200x800.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -rotate 90 -extent 200x800  d6d2d0barfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -rotate 90 -extent 800x200  d6d2d0barfoo90800x200.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -rotate 90 -extent 800x200  d6d2d0barfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -rotate 270  d6d2d0barfoo270.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -rotate 270  d6d2d0barfoo270.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -rotate 270 -extent 200x200  d6d2d0barfoo270200x200.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -rotate 270 -extent 200x200  d6d2d0barfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -rotate 270 -extent 200x800  d6d2d0barfoo270200x800.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -rotate 270 -extent 200x800  d6d2d0barfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0'  label:barfoo -rotate 270 -extent 800x200  d6d2d0barfoo270800x200.gif'
convert -verbose -background '#d6d2d0'  label:barfoo -rotate 270 -extent 800x200  d6d2d0barfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar  d6d2d0Arialfoobar.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar  d6d2d0Arialfoobar.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -extent 200x200  d6d2d0Arialfoobar200x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -extent 200x200  d6d2d0Arialfoobar200x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -extent 200x800  d6d2d0Arialfoobar200x800.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -extent 200x800  d6d2d0Arialfoobar200x800.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -extent 800x200  d6d2d0Arialfoobar800x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -extent 800x200  d6d2d0Arialfoobar800x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 0  d6d2d0Arialfoobar0.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 0  d6d2d0Arialfoobar0.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d0Arialfoobar0200x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d0Arialfoobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d0Arialfoobar0200x800.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d0Arialfoobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d0Arialfoobar0800x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d0Arialfoobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 90  d6d2d0Arialfoobar90.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 90  d6d2d0Arialfoobar90.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d0Arialfoobar90200x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d0Arialfoobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d0Arialfoobar90200x800.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d0Arialfoobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d0Arialfoobar90800x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d0Arialfoobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 270  d6d2d0Arialfoobar270.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 270  d6d2d0Arialfoobar270.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d0Arialfoobar270200x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d0Arialfoobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d0Arialfoobar270200x800.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d0Arialfoobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d0Arialfoobar270800x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d0Arialfoobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo  d6d2d0Arialbarfoo.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo  d6d2d0Arialbarfoo.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -extent 200x200  d6d2d0Arialbarfoo200x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -extent 200x200  d6d2d0Arialbarfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -extent 200x800  d6d2d0Arialbarfoo200x800.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -extent 200x800  d6d2d0Arialbarfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -extent 800x200  d6d2d0Arialbarfoo800x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -extent 800x200  d6d2d0Arialbarfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 0  d6d2d0Arialbarfoo0.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 0  d6d2d0Arialbarfoo0.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d0Arialbarfoo0200x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d0Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d0Arialbarfoo0200x800.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d0Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d0Arialbarfoo0800x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d0Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 90  d6d2d0Arialbarfoo90.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 90  d6d2d0Arialbarfoo90.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d0Arialbarfoo90200x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d0Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d0Arialbarfoo90200x800.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d0Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d0Arialbarfoo90800x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d0Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 270  d6d2d0Arialbarfoo270.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 270  d6d2d0Arialbarfoo270.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d0Arialbarfoo270200x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d0Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d0Arialbarfoo270200x800.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d0Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d0Arialbarfoo270800x200.gif'
convert -verbose -background '#d6d2d0' -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d0Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar  d6d2d08foobar.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar  d6d2d08foobar.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -extent 200x200  d6d2d08foobar200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -extent 200x200  d6d2d08foobar200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -extent 200x800  d6d2d08foobar200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -extent 200x800  d6d2d08foobar200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -extent 800x200  d6d2d08foobar800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -extent 800x200  d6d2d08foobar800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0  d6d2d08foobar0.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0  d6d2d08foobar0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0 -extent 200x200  d6d2d08foobar0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0 -extent 200x200  d6d2d08foobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0 -extent 200x800  d6d2d08foobar0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0 -extent 200x800  d6d2d08foobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0 -extent 800x200  d6d2d08foobar0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0 -extent 800x200  d6d2d08foobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90  d6d2d08foobar90.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90  d6d2d08foobar90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90 -extent 200x200  d6d2d08foobar90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90 -extent 200x200  d6d2d08foobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90 -extent 200x800  d6d2d08foobar90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90 -extent 200x800  d6d2d08foobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90 -extent 800x200  d6d2d08foobar90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90 -extent 800x200  d6d2d08foobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270  d6d2d08foobar270.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270  d6d2d08foobar270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270 -extent 200x200  d6d2d08foobar270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270 -extent 200x200  d6d2d08foobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270 -extent 200x800  d6d2d08foobar270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270 -extent 200x800  d6d2d08foobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270 -extent 800x200  d6d2d08foobar270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270 -extent 800x200  d6d2d08foobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo  d6d2d08barfoo.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo  d6d2d08barfoo.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -extent 200x200  d6d2d08barfoo200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -extent 200x200  d6d2d08barfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -extent 200x800  d6d2d08barfoo200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -extent 200x800  d6d2d08barfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -extent 800x200  d6d2d08barfoo800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -extent 800x200  d6d2d08barfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0  d6d2d08barfoo0.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0  d6d2d08barfoo0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0 -extent 200x200  d6d2d08barfoo0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0 -extent 200x200  d6d2d08barfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0 -extent 200x800  d6d2d08barfoo0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0 -extent 200x800  d6d2d08barfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0 -extent 800x200  d6d2d08barfoo0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0 -extent 800x200  d6d2d08barfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90  d6d2d08barfoo90.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90  d6d2d08barfoo90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90 -extent 200x200  d6d2d08barfoo90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90 -extent 200x200  d6d2d08barfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90 -extent 200x800  d6d2d08barfoo90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90 -extent 200x800  d6d2d08barfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90 -extent 800x200  d6d2d08barfoo90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90 -extent 800x200  d6d2d08barfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270  d6d2d08barfoo270.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270  d6d2d08barfoo270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270 -extent 200x200  d6d2d08barfoo270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270 -extent 200x200  d6d2d08barfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270 -extent 200x800  d6d2d08barfoo270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270 -extent 200x800  d6d2d08barfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270 -extent 800x200  d6d2d08barfoo270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270 -extent 800x200  d6d2d08barfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar  d6d2d08Arialfoobar.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar  d6d2d08Arialfoobar.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -extent 200x200  d6d2d08Arialfoobar200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -extent 200x200  d6d2d08Arialfoobar200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -extent 200x800  d6d2d08Arialfoobar200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -extent 200x800  d6d2d08Arialfoobar200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -extent 800x200  d6d2d08Arialfoobar800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -extent 800x200  d6d2d08Arialfoobar800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0  d6d2d08Arialfoobar0.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0  d6d2d08Arialfoobar0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d08Arialfoobar0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d08Arialfoobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d08Arialfoobar0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d08Arialfoobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d08Arialfoobar0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d08Arialfoobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90  d6d2d08Arialfoobar90.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90  d6d2d08Arialfoobar90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d08Arialfoobar90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d08Arialfoobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d08Arialfoobar90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d08Arialfoobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d08Arialfoobar90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d08Arialfoobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270  d6d2d08Arialfoobar270.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270  d6d2d08Arialfoobar270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d08Arialfoobar270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d08Arialfoobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d08Arialfoobar270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d08Arialfoobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d08Arialfoobar270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d08Arialfoobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo  d6d2d08Arialbarfoo.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo  d6d2d08Arialbarfoo.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -extent 200x200  d6d2d08Arialbarfoo200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -extent 200x200  d6d2d08Arialbarfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -extent 200x800  d6d2d08Arialbarfoo200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -extent 200x800  d6d2d08Arialbarfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -extent 800x200  d6d2d08Arialbarfoo800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -extent 800x200  d6d2d08Arialbarfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0  d6d2d08Arialbarfoo0.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0  d6d2d08Arialbarfoo0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d08Arialbarfoo0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d08Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d08Arialbarfoo0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d08Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d08Arialbarfoo0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d08Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90  d6d2d08Arialbarfoo90.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90  d6d2d08Arialbarfoo90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d08Arialbarfoo90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d08Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d08Arialbarfoo90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d08Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d08Arialbarfoo90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d08Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270  d6d2d08Arialbarfoo270.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270  d6d2d08Arialbarfoo270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d08Arialbarfoo270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d08Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d08Arialbarfoo270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d08Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d08Arialbarfoo270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d08Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar  d6d2d010foobar.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar  d6d2d010foobar.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -extent 200x200  d6d2d010foobar200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -extent 200x200  d6d2d010foobar200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -extent 200x800  d6d2d010foobar200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -extent 200x800  d6d2d010foobar200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -extent 800x200  d6d2d010foobar800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -extent 800x200  d6d2d010foobar800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0  d6d2d010foobar0.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0  d6d2d010foobar0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0 -extent 200x200  d6d2d010foobar0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0 -extent 200x200  d6d2d010foobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0 -extent 200x800  d6d2d010foobar0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0 -extent 200x800  d6d2d010foobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0 -extent 800x200  d6d2d010foobar0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0 -extent 800x200  d6d2d010foobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90  d6d2d010foobar90.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90  d6d2d010foobar90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90 -extent 200x200  d6d2d010foobar90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90 -extent 200x200  d6d2d010foobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90 -extent 200x800  d6d2d010foobar90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90 -extent 200x800  d6d2d010foobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90 -extent 800x200  d6d2d010foobar90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90 -extent 800x200  d6d2d010foobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270  d6d2d010foobar270.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270  d6d2d010foobar270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270 -extent 200x200  d6d2d010foobar270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270 -extent 200x200  d6d2d010foobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270 -extent 200x800  d6d2d010foobar270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270 -extent 200x800  d6d2d010foobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270 -extent 800x200  d6d2d010foobar270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270 -extent 800x200  d6d2d010foobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo  d6d2d010barfoo.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo  d6d2d010barfoo.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -extent 200x200  d6d2d010barfoo200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -extent 200x200  d6d2d010barfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -extent 200x800  d6d2d010barfoo200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -extent 200x800  d6d2d010barfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -extent 800x200  d6d2d010barfoo800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -extent 800x200  d6d2d010barfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0  d6d2d010barfoo0.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0  d6d2d010barfoo0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0 -extent 200x200  d6d2d010barfoo0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0 -extent 200x200  d6d2d010barfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0 -extent 200x800  d6d2d010barfoo0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0 -extent 200x800  d6d2d010barfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0 -extent 800x200  d6d2d010barfoo0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0 -extent 800x200  d6d2d010barfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90  d6d2d010barfoo90.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90  d6d2d010barfoo90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90 -extent 200x200  d6d2d010barfoo90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90 -extent 200x200  d6d2d010barfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90 -extent 200x800  d6d2d010barfoo90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90 -extent 200x800  d6d2d010barfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90 -extent 800x200  d6d2d010barfoo90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90 -extent 800x200  d6d2d010barfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270  d6d2d010barfoo270.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270  d6d2d010barfoo270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270 -extent 200x200  d6d2d010barfoo270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270 -extent 200x200  d6d2d010barfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270 -extent 200x800  d6d2d010barfoo270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270 -extent 200x800  d6d2d010barfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270 -extent 800x200  d6d2d010barfoo270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270 -extent 800x200  d6d2d010barfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar  d6d2d010Arialfoobar.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar  d6d2d010Arialfoobar.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -extent 200x200  d6d2d010Arialfoobar200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -extent 200x200  d6d2d010Arialfoobar200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -extent 200x800  d6d2d010Arialfoobar200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -extent 200x800  d6d2d010Arialfoobar200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -extent 800x200  d6d2d010Arialfoobar800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -extent 800x200  d6d2d010Arialfoobar800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0  d6d2d010Arialfoobar0.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0  d6d2d010Arialfoobar0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d010Arialfoobar0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d010Arialfoobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d010Arialfoobar0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d010Arialfoobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d010Arialfoobar0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d010Arialfoobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90  d6d2d010Arialfoobar90.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90  d6d2d010Arialfoobar90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d010Arialfoobar90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d010Arialfoobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d010Arialfoobar90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d010Arialfoobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d010Arialfoobar90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d010Arialfoobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270  d6d2d010Arialfoobar270.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270  d6d2d010Arialfoobar270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d010Arialfoobar270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d010Arialfoobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d010Arialfoobar270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d010Arialfoobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d010Arialfoobar270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d010Arialfoobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo  d6d2d010Arialbarfoo.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo  d6d2d010Arialbarfoo.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -extent 200x200  d6d2d010Arialbarfoo200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -extent 200x200  d6d2d010Arialbarfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -extent 200x800  d6d2d010Arialbarfoo200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -extent 200x800  d6d2d010Arialbarfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -extent 800x200  d6d2d010Arialbarfoo800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -extent 800x200  d6d2d010Arialbarfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0  d6d2d010Arialbarfoo0.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0  d6d2d010Arialbarfoo0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d010Arialbarfoo0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d010Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d010Arialbarfoo0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d010Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d010Arialbarfoo0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d010Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90  d6d2d010Arialbarfoo90.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90  d6d2d010Arialbarfoo90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d010Arialbarfoo90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d010Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d010Arialbarfoo90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d010Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d010Arialbarfoo90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d010Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270  d6d2d010Arialbarfoo270.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270  d6d2d010Arialbarfoo270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d010Arialbarfoo270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d010Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d010Arialbarfoo270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d010Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d010Arialbarfoo270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d010Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar  d6d2d012foobar.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar  d6d2d012foobar.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -extent 200x200  d6d2d012foobar200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -extent 200x200  d6d2d012foobar200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -extent 200x800  d6d2d012foobar200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -extent 200x800  d6d2d012foobar200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -extent 800x200  d6d2d012foobar800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -extent 800x200  d6d2d012foobar800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0  d6d2d012foobar0.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0  d6d2d012foobar0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0 -extent 200x200  d6d2d012foobar0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0 -extent 200x200  d6d2d012foobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0 -extent 200x800  d6d2d012foobar0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0 -extent 200x800  d6d2d012foobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0 -extent 800x200  d6d2d012foobar0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0 -extent 800x200  d6d2d012foobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90  d6d2d012foobar90.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90  d6d2d012foobar90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90 -extent 200x200  d6d2d012foobar90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90 -extent 200x200  d6d2d012foobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90 -extent 200x800  d6d2d012foobar90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90 -extent 200x800  d6d2d012foobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90 -extent 800x200  d6d2d012foobar90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90 -extent 800x200  d6d2d012foobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270  d6d2d012foobar270.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270  d6d2d012foobar270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270 -extent 200x200  d6d2d012foobar270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270 -extent 200x200  d6d2d012foobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270 -extent 200x800  d6d2d012foobar270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270 -extent 200x800  d6d2d012foobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270 -extent 800x200  d6d2d012foobar270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270 -extent 800x200  d6d2d012foobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo  d6d2d012barfoo.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo  d6d2d012barfoo.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -extent 200x200  d6d2d012barfoo200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -extent 200x200  d6d2d012barfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -extent 200x800  d6d2d012barfoo200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -extent 200x800  d6d2d012barfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -extent 800x200  d6d2d012barfoo800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -extent 800x200  d6d2d012barfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0  d6d2d012barfoo0.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0  d6d2d012barfoo0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0 -extent 200x200  d6d2d012barfoo0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0 -extent 200x200  d6d2d012barfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0 -extent 200x800  d6d2d012barfoo0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0 -extent 200x800  d6d2d012barfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0 -extent 800x200  d6d2d012barfoo0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0 -extent 800x200  d6d2d012barfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90  d6d2d012barfoo90.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90  d6d2d012barfoo90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90 -extent 200x200  d6d2d012barfoo90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90 -extent 200x200  d6d2d012barfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90 -extent 200x800  d6d2d012barfoo90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90 -extent 200x800  d6d2d012barfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90 -extent 800x200  d6d2d012barfoo90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90 -extent 800x200  d6d2d012barfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270  d6d2d012barfoo270.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270  d6d2d012barfoo270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270 -extent 200x200  d6d2d012barfoo270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270 -extent 200x200  d6d2d012barfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270 -extent 200x800  d6d2d012barfoo270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270 -extent 200x800  d6d2d012barfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270 -extent 800x200  d6d2d012barfoo270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270 -extent 800x200  d6d2d012barfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar  d6d2d012Arialfoobar.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar  d6d2d012Arialfoobar.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -extent 200x200  d6d2d012Arialfoobar200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -extent 200x200  d6d2d012Arialfoobar200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -extent 200x800  d6d2d012Arialfoobar200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -extent 200x800  d6d2d012Arialfoobar200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -extent 800x200  d6d2d012Arialfoobar800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -extent 800x200  d6d2d012Arialfoobar800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0  d6d2d012Arialfoobar0.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0  d6d2d012Arialfoobar0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d012Arialfoobar0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d012Arialfoobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d012Arialfoobar0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d012Arialfoobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d012Arialfoobar0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d012Arialfoobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90  d6d2d012Arialfoobar90.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90  d6d2d012Arialfoobar90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d012Arialfoobar90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d012Arialfoobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d012Arialfoobar90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d012Arialfoobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d012Arialfoobar90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d012Arialfoobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270  d6d2d012Arialfoobar270.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270  d6d2d012Arialfoobar270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d012Arialfoobar270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d012Arialfoobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d012Arialfoobar270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d012Arialfoobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d012Arialfoobar270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d012Arialfoobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo  d6d2d012Arialbarfoo.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo  d6d2d012Arialbarfoo.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -extent 200x200  d6d2d012Arialbarfoo200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -extent 200x200  d6d2d012Arialbarfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -extent 200x800  d6d2d012Arialbarfoo200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -extent 200x800  d6d2d012Arialbarfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -extent 800x200  d6d2d012Arialbarfoo800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -extent 800x200  d6d2d012Arialbarfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0  d6d2d012Arialbarfoo0.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0  d6d2d012Arialbarfoo0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d012Arialbarfoo0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d012Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d012Arialbarfoo0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d012Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d012Arialbarfoo0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d012Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90  d6d2d012Arialbarfoo90.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90  d6d2d012Arialbarfoo90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d012Arialbarfoo90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d012Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d012Arialbarfoo90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d012Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d012Arialbarfoo90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d012Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270  d6d2d012Arialbarfoo270.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270  d6d2d012Arialbarfoo270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d012Arialbarfoo270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d012Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d012Arialbarfoo270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d012Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d012Arialbarfoo270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d012Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar  d6d2d018foobar.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar  d6d2d018foobar.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -extent 200x200  d6d2d018foobar200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -extent 200x200  d6d2d018foobar200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -extent 200x800  d6d2d018foobar200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -extent 200x800  d6d2d018foobar200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -extent 800x200  d6d2d018foobar800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -extent 800x200  d6d2d018foobar800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0  d6d2d018foobar0.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0  d6d2d018foobar0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0 -extent 200x200  d6d2d018foobar0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0 -extent 200x200  d6d2d018foobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0 -extent 200x800  d6d2d018foobar0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0 -extent 200x800  d6d2d018foobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0 -extent 800x200  d6d2d018foobar0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0 -extent 800x200  d6d2d018foobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90  d6d2d018foobar90.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90  d6d2d018foobar90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90 -extent 200x200  d6d2d018foobar90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90 -extent 200x200  d6d2d018foobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90 -extent 200x800  d6d2d018foobar90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90 -extent 200x800  d6d2d018foobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90 -extent 800x200  d6d2d018foobar90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90 -extent 800x200  d6d2d018foobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270  d6d2d018foobar270.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270  d6d2d018foobar270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270 -extent 200x200  d6d2d018foobar270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270 -extent 200x200  d6d2d018foobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270 -extent 200x800  d6d2d018foobar270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270 -extent 200x800  d6d2d018foobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270 -extent 800x200  d6d2d018foobar270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270 -extent 800x200  d6d2d018foobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo  d6d2d018barfoo.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo  d6d2d018barfoo.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -extent 200x200  d6d2d018barfoo200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -extent 200x200  d6d2d018barfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -extent 200x800  d6d2d018barfoo200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -extent 200x800  d6d2d018barfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -extent 800x200  d6d2d018barfoo800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -extent 800x200  d6d2d018barfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0  d6d2d018barfoo0.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0  d6d2d018barfoo0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0 -extent 200x200  d6d2d018barfoo0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0 -extent 200x200  d6d2d018barfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0 -extent 200x800  d6d2d018barfoo0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0 -extent 200x800  d6d2d018barfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0 -extent 800x200  d6d2d018barfoo0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0 -extent 800x200  d6d2d018barfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90  d6d2d018barfoo90.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90  d6d2d018barfoo90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90 -extent 200x200  d6d2d018barfoo90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90 -extent 200x200  d6d2d018barfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90 -extent 200x800  d6d2d018barfoo90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90 -extent 200x800  d6d2d018barfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90 -extent 800x200  d6d2d018barfoo90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90 -extent 800x200  d6d2d018barfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270  d6d2d018barfoo270.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270  d6d2d018barfoo270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270 -extent 200x200  d6d2d018barfoo270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270 -extent 200x200  d6d2d018barfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270 -extent 200x800  d6d2d018barfoo270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270 -extent 200x800  d6d2d018barfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270 -extent 800x200  d6d2d018barfoo270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270 -extent 800x200  d6d2d018barfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar  d6d2d018Arialfoobar.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar  d6d2d018Arialfoobar.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -extent 200x200  d6d2d018Arialfoobar200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -extent 200x200  d6d2d018Arialfoobar200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -extent 200x800  d6d2d018Arialfoobar200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -extent 200x800  d6d2d018Arialfoobar200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -extent 800x200  d6d2d018Arialfoobar800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -extent 800x200  d6d2d018Arialfoobar800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0  d6d2d018Arialfoobar0.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0  d6d2d018Arialfoobar0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d018Arialfoobar0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d018Arialfoobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d018Arialfoobar0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d018Arialfoobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d018Arialfoobar0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d018Arialfoobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90  d6d2d018Arialfoobar90.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90  d6d2d018Arialfoobar90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d018Arialfoobar90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d018Arialfoobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d018Arialfoobar90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d018Arialfoobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d018Arialfoobar90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d018Arialfoobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270  d6d2d018Arialfoobar270.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270  d6d2d018Arialfoobar270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d018Arialfoobar270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d018Arialfoobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d018Arialfoobar270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d018Arialfoobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d018Arialfoobar270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d018Arialfoobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo  d6d2d018Arialbarfoo.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo  d6d2d018Arialbarfoo.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -extent 200x200  d6d2d018Arialbarfoo200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -extent 200x200  d6d2d018Arialbarfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -extent 200x800  d6d2d018Arialbarfoo200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -extent 200x800  d6d2d018Arialbarfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -extent 800x200  d6d2d018Arialbarfoo800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -extent 800x200  d6d2d018Arialbarfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0  d6d2d018Arialbarfoo0.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0  d6d2d018Arialbarfoo0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d018Arialbarfoo0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d018Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d018Arialbarfoo0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d018Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d018Arialbarfoo0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d018Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90  d6d2d018Arialbarfoo90.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90  d6d2d018Arialbarfoo90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d018Arialbarfoo90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d018Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d018Arialbarfoo90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d018Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d018Arialbarfoo90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d018Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270  d6d2d018Arialbarfoo270.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270  d6d2d018Arialbarfoo270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d018Arialbarfoo270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d018Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d018Arialbarfoo270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d018Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d018Arialbarfoo270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d018Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar  d6d2d024foobar.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar  d6d2d024foobar.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -extent 200x200  d6d2d024foobar200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -extent 200x200  d6d2d024foobar200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -extent 200x800  d6d2d024foobar200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -extent 200x800  d6d2d024foobar200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -extent 800x200  d6d2d024foobar800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -extent 800x200  d6d2d024foobar800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0  d6d2d024foobar0.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0  d6d2d024foobar0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0 -extent 200x200  d6d2d024foobar0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0 -extent 200x200  d6d2d024foobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0 -extent 200x800  d6d2d024foobar0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0 -extent 200x800  d6d2d024foobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0 -extent 800x200  d6d2d024foobar0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0 -extent 800x200  d6d2d024foobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90  d6d2d024foobar90.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90  d6d2d024foobar90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90 -extent 200x200  d6d2d024foobar90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90 -extent 200x200  d6d2d024foobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90 -extent 200x800  d6d2d024foobar90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90 -extent 200x800  d6d2d024foobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90 -extent 800x200  d6d2d024foobar90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90 -extent 800x200  d6d2d024foobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270  d6d2d024foobar270.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270  d6d2d024foobar270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270 -extent 200x200  d6d2d024foobar270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270 -extent 200x200  d6d2d024foobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270 -extent 200x800  d6d2d024foobar270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270 -extent 200x800  d6d2d024foobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270 -extent 800x200  d6d2d024foobar270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270 -extent 800x200  d6d2d024foobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo  d6d2d024barfoo.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo  d6d2d024barfoo.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -extent 200x200  d6d2d024barfoo200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -extent 200x200  d6d2d024barfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -extent 200x800  d6d2d024barfoo200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -extent 200x800  d6d2d024barfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -extent 800x200  d6d2d024barfoo800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -extent 800x200  d6d2d024barfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0  d6d2d024barfoo0.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0  d6d2d024barfoo0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0 -extent 200x200  d6d2d024barfoo0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0 -extent 200x200  d6d2d024barfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0 -extent 200x800  d6d2d024barfoo0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0 -extent 200x800  d6d2d024barfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0 -extent 800x200  d6d2d024barfoo0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0 -extent 800x200  d6d2d024barfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90  d6d2d024barfoo90.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90  d6d2d024barfoo90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90 -extent 200x200  d6d2d024barfoo90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90 -extent 200x200  d6d2d024barfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90 -extent 200x800  d6d2d024barfoo90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90 -extent 200x800  d6d2d024barfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90 -extent 800x200  d6d2d024barfoo90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90 -extent 800x200  d6d2d024barfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270  d6d2d024barfoo270.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270  d6d2d024barfoo270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270 -extent 200x200  d6d2d024barfoo270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270 -extent 200x200  d6d2d024barfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270 -extent 200x800  d6d2d024barfoo270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270 -extent 200x800  d6d2d024barfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270 -extent 800x200  d6d2d024barfoo270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270 -extent 800x200  d6d2d024barfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar  d6d2d024Arialfoobar.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar  d6d2d024Arialfoobar.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -extent 200x200  d6d2d024Arialfoobar200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -extent 200x200  d6d2d024Arialfoobar200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -extent 200x800  d6d2d024Arialfoobar200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -extent 200x800  d6d2d024Arialfoobar200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -extent 800x200  d6d2d024Arialfoobar800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -extent 800x200  d6d2d024Arialfoobar800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0  d6d2d024Arialfoobar0.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0  d6d2d024Arialfoobar0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d024Arialfoobar0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d024Arialfoobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d024Arialfoobar0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d024Arialfoobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d024Arialfoobar0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d024Arialfoobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90  d6d2d024Arialfoobar90.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90  d6d2d024Arialfoobar90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d024Arialfoobar90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d024Arialfoobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d024Arialfoobar90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d024Arialfoobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d024Arialfoobar90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d024Arialfoobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270  d6d2d024Arialfoobar270.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270  d6d2d024Arialfoobar270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d024Arialfoobar270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d024Arialfoobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d024Arialfoobar270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d024Arialfoobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d024Arialfoobar270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d024Arialfoobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo  d6d2d024Arialbarfoo.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo  d6d2d024Arialbarfoo.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -extent 200x200  d6d2d024Arialbarfoo200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -extent 200x200  d6d2d024Arialbarfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -extent 200x800  d6d2d024Arialbarfoo200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -extent 200x800  d6d2d024Arialbarfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -extent 800x200  d6d2d024Arialbarfoo800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -extent 800x200  d6d2d024Arialbarfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0  d6d2d024Arialbarfoo0.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0  d6d2d024Arialbarfoo0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d024Arialbarfoo0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d024Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d024Arialbarfoo0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d024Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d024Arialbarfoo0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d024Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90  d6d2d024Arialbarfoo90.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90  d6d2d024Arialbarfoo90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d024Arialbarfoo90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d024Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d024Arialbarfoo90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d024Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d024Arialbarfoo90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d024Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270  d6d2d024Arialbarfoo270.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270  d6d2d024Arialbarfoo270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d024Arialbarfoo270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d024Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d024Arialbarfoo270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d024Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d024Arialbarfoo270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d024Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar  d6d2d048foobar.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar  d6d2d048foobar.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -extent 200x200  d6d2d048foobar200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -extent 200x200  d6d2d048foobar200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -extent 200x800  d6d2d048foobar200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -extent 200x800  d6d2d048foobar200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -extent 800x200  d6d2d048foobar800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -extent 800x200  d6d2d048foobar800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0  d6d2d048foobar0.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0  d6d2d048foobar0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0 -extent 200x200  d6d2d048foobar0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0 -extent 200x200  d6d2d048foobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0 -extent 200x800  d6d2d048foobar0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0 -extent 200x800  d6d2d048foobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0 -extent 800x200  d6d2d048foobar0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0 -extent 800x200  d6d2d048foobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90  d6d2d048foobar90.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90  d6d2d048foobar90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90 -extent 200x200  d6d2d048foobar90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90 -extent 200x200  d6d2d048foobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90 -extent 200x800  d6d2d048foobar90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90 -extent 200x800  d6d2d048foobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90 -extent 800x200  d6d2d048foobar90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90 -extent 800x200  d6d2d048foobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270  d6d2d048foobar270.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270  d6d2d048foobar270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270 -extent 200x200  d6d2d048foobar270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270 -extent 200x200  d6d2d048foobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270 -extent 200x800  d6d2d048foobar270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270 -extent 200x800  d6d2d048foobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270 -extent 800x200  d6d2d048foobar270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270 -extent 800x200  d6d2d048foobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo  d6d2d048barfoo.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo  d6d2d048barfoo.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -extent 200x200  d6d2d048barfoo200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -extent 200x200  d6d2d048barfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -extent 200x800  d6d2d048barfoo200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -extent 200x800  d6d2d048barfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -extent 800x200  d6d2d048barfoo800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -extent 800x200  d6d2d048barfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0  d6d2d048barfoo0.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0  d6d2d048barfoo0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0 -extent 200x200  d6d2d048barfoo0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0 -extent 200x200  d6d2d048barfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0 -extent 200x800  d6d2d048barfoo0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0 -extent 200x800  d6d2d048barfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0 -extent 800x200  d6d2d048barfoo0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0 -extent 800x200  d6d2d048barfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90  d6d2d048barfoo90.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90  d6d2d048barfoo90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90 -extent 200x200  d6d2d048barfoo90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90 -extent 200x200  d6d2d048barfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90 -extent 200x800  d6d2d048barfoo90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90 -extent 200x800  d6d2d048barfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90 -extent 800x200  d6d2d048barfoo90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90 -extent 800x200  d6d2d048barfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270  d6d2d048barfoo270.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270  d6d2d048barfoo270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270 -extent 200x200  d6d2d048barfoo270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270 -extent 200x200  d6d2d048barfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270 -extent 200x800  d6d2d048barfoo270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270 -extent 200x800  d6d2d048barfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270 -extent 800x200  d6d2d048barfoo270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270 -extent 800x200  d6d2d048barfoo270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar  d6d2d048Arialfoobar.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar  d6d2d048Arialfoobar.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -extent 200x200  d6d2d048Arialfoobar200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -extent 200x200  d6d2d048Arialfoobar200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -extent 200x800  d6d2d048Arialfoobar200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -extent 200x800  d6d2d048Arialfoobar200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -extent 800x200  d6d2d048Arialfoobar800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -extent 800x200  d6d2d048Arialfoobar800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0  d6d2d048Arialfoobar0.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0  d6d2d048Arialfoobar0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d048Arialfoobar0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  d6d2d048Arialfoobar0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d048Arialfoobar0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  d6d2d048Arialfoobar0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d048Arialfoobar0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  d6d2d048Arialfoobar0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90  d6d2d048Arialfoobar90.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90  d6d2d048Arialfoobar90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d048Arialfoobar90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  d6d2d048Arialfoobar90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d048Arialfoobar90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  d6d2d048Arialfoobar90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d048Arialfoobar90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  d6d2d048Arialfoobar90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270  d6d2d048Arialfoobar270.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270  d6d2d048Arialfoobar270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d048Arialfoobar270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  d6d2d048Arialfoobar270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d048Arialfoobar270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  d6d2d048Arialfoobar270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d048Arialfoobar270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  d6d2d048Arialfoobar270800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo  d6d2d048Arialbarfoo.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo  d6d2d048Arialbarfoo.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -extent 200x200  d6d2d048Arialbarfoo200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -extent 200x200  d6d2d048Arialbarfoo200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -extent 200x800  d6d2d048Arialbarfoo200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -extent 200x800  d6d2d048Arialbarfoo200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -extent 800x200  d6d2d048Arialbarfoo800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -extent 800x200  d6d2d048Arialbarfoo800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0  d6d2d048Arialbarfoo0.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0  d6d2d048Arialbarfoo0.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d048Arialbarfoo0200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  d6d2d048Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d048Arialbarfoo0200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  d6d2d048Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d048Arialbarfoo0800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  d6d2d048Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90  d6d2d048Arialbarfoo90.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90  d6d2d048Arialbarfoo90.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d048Arialbarfoo90200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  d6d2d048Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d048Arialbarfoo90200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  d6d2d048Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d048Arialbarfoo90800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  d6d2d048Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270  d6d2d048Arialbarfoo270.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270  d6d2d048Arialbarfoo270.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d048Arialbarfoo270200x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  d6d2d048Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d048Arialbarfoo270200x800.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  d6d2d048Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d048Arialbarfoo270800x200.gif'
convert -verbose -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  d6d2d048Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#0000ff'  label:foobar  0000fffoobar.gif'
convert -verbose -background '#0000ff'  label:foobar  0000fffoobar.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -extent 200x200  0000fffoobar200x200.gif'
convert -verbose -background '#0000ff'  label:foobar -extent 200x200  0000fffoobar200x200.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -extent 200x800  0000fffoobar200x800.gif'
convert -verbose -background '#0000ff'  label:foobar -extent 200x800  0000fffoobar200x800.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -extent 800x200  0000fffoobar800x200.gif'
convert -verbose -background '#0000ff'  label:foobar -extent 800x200  0000fffoobar800x200.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -rotate 0  0000fffoobar0.gif'
convert -verbose -background '#0000ff'  label:foobar -rotate 0  0000fffoobar0.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -rotate 0 -extent 200x200  0000fffoobar0200x200.gif'
convert -verbose -background '#0000ff'  label:foobar -rotate 0 -extent 200x200  0000fffoobar0200x200.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -rotate 0 -extent 200x800  0000fffoobar0200x800.gif'
convert -verbose -background '#0000ff'  label:foobar -rotate 0 -extent 200x800  0000fffoobar0200x800.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -rotate 0 -extent 800x200  0000fffoobar0800x200.gif'
convert -verbose -background '#0000ff'  label:foobar -rotate 0 -extent 800x200  0000fffoobar0800x200.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -rotate 90  0000fffoobar90.gif'
convert -verbose -background '#0000ff'  label:foobar -rotate 90  0000fffoobar90.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -rotate 90 -extent 200x200  0000fffoobar90200x200.gif'
convert -verbose -background '#0000ff'  label:foobar -rotate 90 -extent 200x200  0000fffoobar90200x200.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -rotate 90 -extent 200x800  0000fffoobar90200x800.gif'
convert -verbose -background '#0000ff'  label:foobar -rotate 90 -extent 200x800  0000fffoobar90200x800.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -rotate 90 -extent 800x200  0000fffoobar90800x200.gif'
convert -verbose -background '#0000ff'  label:foobar -rotate 90 -extent 800x200  0000fffoobar90800x200.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -rotate 270  0000fffoobar270.gif'
convert -verbose -background '#0000ff'  label:foobar -rotate 270  0000fffoobar270.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -rotate 270 -extent 200x200  0000fffoobar270200x200.gif'
convert -verbose -background '#0000ff'  label:foobar -rotate 270 -extent 200x200  0000fffoobar270200x200.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -rotate 270 -extent 200x800  0000fffoobar270200x800.gif'
convert -verbose -background '#0000ff'  label:foobar -rotate 270 -extent 200x800  0000fffoobar270200x800.gif
echo '

convert -verbose -background '#0000ff'  label:foobar -rotate 270 -extent 800x200  0000fffoobar270800x200.gif'
convert -verbose -background '#0000ff'  label:foobar -rotate 270 -extent 800x200  0000fffoobar270800x200.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo  0000ffbarfoo.gif'
convert -verbose -background '#0000ff'  label:barfoo  0000ffbarfoo.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -extent 200x200  0000ffbarfoo200x200.gif'
convert -verbose -background '#0000ff'  label:barfoo -extent 200x200  0000ffbarfoo200x200.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -extent 200x800  0000ffbarfoo200x800.gif'
convert -verbose -background '#0000ff'  label:barfoo -extent 200x800  0000ffbarfoo200x800.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -extent 800x200  0000ffbarfoo800x200.gif'
convert -verbose -background '#0000ff'  label:barfoo -extent 800x200  0000ffbarfoo800x200.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -rotate 0  0000ffbarfoo0.gif'
convert -verbose -background '#0000ff'  label:barfoo -rotate 0  0000ffbarfoo0.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -rotate 0 -extent 200x200  0000ffbarfoo0200x200.gif'
convert -verbose -background '#0000ff'  label:barfoo -rotate 0 -extent 200x200  0000ffbarfoo0200x200.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -rotate 0 -extent 200x800  0000ffbarfoo0200x800.gif'
convert -verbose -background '#0000ff'  label:barfoo -rotate 0 -extent 200x800  0000ffbarfoo0200x800.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -rotate 0 -extent 800x200  0000ffbarfoo0800x200.gif'
convert -verbose -background '#0000ff'  label:barfoo -rotate 0 -extent 800x200  0000ffbarfoo0800x200.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -rotate 90  0000ffbarfoo90.gif'
convert -verbose -background '#0000ff'  label:barfoo -rotate 90  0000ffbarfoo90.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -rotate 90 -extent 200x200  0000ffbarfoo90200x200.gif'
convert -verbose -background '#0000ff'  label:barfoo -rotate 90 -extent 200x200  0000ffbarfoo90200x200.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -rotate 90 -extent 200x800  0000ffbarfoo90200x800.gif'
convert -verbose -background '#0000ff'  label:barfoo -rotate 90 -extent 200x800  0000ffbarfoo90200x800.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -rotate 90 -extent 800x200  0000ffbarfoo90800x200.gif'
convert -verbose -background '#0000ff'  label:barfoo -rotate 90 -extent 800x200  0000ffbarfoo90800x200.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -rotate 270  0000ffbarfoo270.gif'
convert -verbose -background '#0000ff'  label:barfoo -rotate 270  0000ffbarfoo270.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -rotate 270 -extent 200x200  0000ffbarfoo270200x200.gif'
convert -verbose -background '#0000ff'  label:barfoo -rotate 270 -extent 200x200  0000ffbarfoo270200x200.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -rotate 270 -extent 200x800  0000ffbarfoo270200x800.gif'
convert -verbose -background '#0000ff'  label:barfoo -rotate 270 -extent 200x800  0000ffbarfoo270200x800.gif
echo '

convert -verbose -background '#0000ff'  label:barfoo -rotate 270 -extent 800x200  0000ffbarfoo270800x200.gif'
convert -verbose -background '#0000ff'  label:barfoo -rotate 270 -extent 800x200  0000ffbarfoo270800x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar  0000ffArialfoobar.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar  0000ffArialfoobar.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -extent 200x200  0000ffArialfoobar200x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -extent 200x200  0000ffArialfoobar200x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -extent 200x800  0000ffArialfoobar200x800.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -extent 200x800  0000ffArialfoobar200x800.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -extent 800x200  0000ffArialfoobar800x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -extent 800x200  0000ffArialfoobar800x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 0  0000ffArialfoobar0.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 0  0000ffArialfoobar0.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 0 -extent 200x200  0000ffArialfoobar0200x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 0 -extent 200x200  0000ffArialfoobar0200x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 0 -extent 200x800  0000ffArialfoobar0200x800.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 0 -extent 200x800  0000ffArialfoobar0200x800.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 0 -extent 800x200  0000ffArialfoobar0800x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 0 -extent 800x200  0000ffArialfoobar0800x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 90  0000ffArialfoobar90.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 90  0000ffArialfoobar90.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 90 -extent 200x200  0000ffArialfoobar90200x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 90 -extent 200x200  0000ffArialfoobar90200x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 90 -extent 200x800  0000ffArialfoobar90200x800.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 90 -extent 200x800  0000ffArialfoobar90200x800.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 90 -extent 800x200  0000ffArialfoobar90800x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 90 -extent 800x200  0000ffArialfoobar90800x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 270  0000ffArialfoobar270.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 270  0000ffArialfoobar270.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 270 -extent 200x200  0000ffArialfoobar270200x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 270 -extent 200x200  0000ffArialfoobar270200x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 270 -extent 200x800  0000ffArialfoobar270200x800.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 270 -extent 200x800  0000ffArialfoobar270200x800.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 270 -extent 800x200  0000ffArialfoobar270800x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:foobar -rotate 270 -extent 800x200  0000ffArialfoobar270800x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo  0000ffArialbarfoo.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo  0000ffArialbarfoo.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -extent 200x200  0000ffArialbarfoo200x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -extent 200x200  0000ffArialbarfoo200x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -extent 200x800  0000ffArialbarfoo200x800.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -extent 200x800  0000ffArialbarfoo200x800.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -extent 800x200  0000ffArialbarfoo800x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -extent 800x200  0000ffArialbarfoo800x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 0  0000ffArialbarfoo0.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 0  0000ffArialbarfoo0.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ffArialbarfoo0200x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ffArialbarfoo0200x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ffArialbarfoo0200x800.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ffArialbarfoo0200x800.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ffArialbarfoo0800x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ffArialbarfoo0800x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 90  0000ffArialbarfoo90.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 90  0000ffArialbarfoo90.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ffArialbarfoo90200x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ffArialbarfoo90200x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ffArialbarfoo90200x800.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ffArialbarfoo90200x800.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ffArialbarfoo90800x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ffArialbarfoo90800x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 270  0000ffArialbarfoo270.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 270  0000ffArialbarfoo270.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ffArialbarfoo270200x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ffArialbarfoo270200x200.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ffArialbarfoo270200x800.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ffArialbarfoo270200x800.gif
echo '

convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ffArialbarfoo270800x200.gif'
convert -verbose -background '#0000ff' -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ffArialbarfoo270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar  0000ff8foobar.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar  0000ff8foobar.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -extent 200x200  0000ff8foobar200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -extent 200x200  0000ff8foobar200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -extent 200x800  0000ff8foobar200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -extent 200x800  0000ff8foobar200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -extent 800x200  0000ff8foobar800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -extent 800x200  0000ff8foobar800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 0  0000ff8foobar0.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 0  0000ff8foobar0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 0 -extent 200x200  0000ff8foobar0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 0 -extent 200x200  0000ff8foobar0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 0 -extent 200x800  0000ff8foobar0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 0 -extent 200x800  0000ff8foobar0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 0 -extent 800x200  0000ff8foobar0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 0 -extent 800x200  0000ff8foobar0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 90  0000ff8foobar90.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 90  0000ff8foobar90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 90 -extent 200x200  0000ff8foobar90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 90 -extent 200x200  0000ff8foobar90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 90 -extent 200x800  0000ff8foobar90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 90 -extent 200x800  0000ff8foobar90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 90 -extent 800x200  0000ff8foobar90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 90 -extent 800x200  0000ff8foobar90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 270  0000ff8foobar270.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 270  0000ff8foobar270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 270 -extent 200x200  0000ff8foobar270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 270 -extent 200x200  0000ff8foobar270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 270 -extent 200x800  0000ff8foobar270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 270 -extent 200x800  0000ff8foobar270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 270 -extent 800x200  0000ff8foobar270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:foobar -rotate 270 -extent 800x200  0000ff8foobar270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo  0000ff8barfoo.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo  0000ff8barfoo.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -extent 200x200  0000ff8barfoo200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -extent 200x200  0000ff8barfoo200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -extent 200x800  0000ff8barfoo200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -extent 200x800  0000ff8barfoo200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -extent 800x200  0000ff8barfoo800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -extent 800x200  0000ff8barfoo800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 0  0000ff8barfoo0.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 0  0000ff8barfoo0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 0 -extent 200x200  0000ff8barfoo0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 0 -extent 200x200  0000ff8barfoo0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 0 -extent 200x800  0000ff8barfoo0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 0 -extent 200x800  0000ff8barfoo0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 0 -extent 800x200  0000ff8barfoo0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 0 -extent 800x200  0000ff8barfoo0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 90  0000ff8barfoo90.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 90  0000ff8barfoo90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 90 -extent 200x200  0000ff8barfoo90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 90 -extent 200x200  0000ff8barfoo90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 90 -extent 200x800  0000ff8barfoo90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 90 -extent 200x800  0000ff8barfoo90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 90 -extent 800x200  0000ff8barfoo90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 90 -extent 800x200  0000ff8barfoo90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 270  0000ff8barfoo270.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 270  0000ff8barfoo270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 270 -extent 200x200  0000ff8barfoo270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 270 -extent 200x200  0000ff8barfoo270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 270 -extent 200x800  0000ff8barfoo270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 270 -extent 200x800  0000ff8barfoo270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 270 -extent 800x200  0000ff8barfoo270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8  label:barfoo -rotate 270 -extent 800x200  0000ff8barfoo270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar  0000ff8Arialfoobar.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar  0000ff8Arialfoobar.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -extent 200x200  0000ff8Arialfoobar200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -extent 200x200  0000ff8Arialfoobar200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -extent 200x800  0000ff8Arialfoobar200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -extent 200x800  0000ff8Arialfoobar200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -extent 800x200  0000ff8Arialfoobar800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -extent 800x200  0000ff8Arialfoobar800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0  0000ff8Arialfoobar0.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0  0000ff8Arialfoobar0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  0000ff8Arialfoobar0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  0000ff8Arialfoobar0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  0000ff8Arialfoobar0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  0000ff8Arialfoobar0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  0000ff8Arialfoobar0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  0000ff8Arialfoobar0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90  0000ff8Arialfoobar90.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90  0000ff8Arialfoobar90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  0000ff8Arialfoobar90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  0000ff8Arialfoobar90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  0000ff8Arialfoobar90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  0000ff8Arialfoobar90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  0000ff8Arialfoobar90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  0000ff8Arialfoobar90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270  0000ff8Arialfoobar270.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270  0000ff8Arialfoobar270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  0000ff8Arialfoobar270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  0000ff8Arialfoobar270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  0000ff8Arialfoobar270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  0000ff8Arialfoobar270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  0000ff8Arialfoobar270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  0000ff8Arialfoobar270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo  0000ff8Arialbarfoo.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo  0000ff8Arialbarfoo.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -extent 200x200  0000ff8Arialbarfoo200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -extent 200x200  0000ff8Arialbarfoo200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -extent 200x800  0000ff8Arialbarfoo200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -extent 200x800  0000ff8Arialbarfoo200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -extent 800x200  0000ff8Arialbarfoo800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -extent 800x200  0000ff8Arialbarfoo800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0  0000ff8Arialbarfoo0.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0  0000ff8Arialbarfoo0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ff8Arialbarfoo0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ff8Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ff8Arialbarfoo0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ff8Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ff8Arialbarfoo0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ff8Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90  0000ff8Arialbarfoo90.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90  0000ff8Arialbarfoo90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ff8Arialbarfoo90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ff8Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ff8Arialbarfoo90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ff8Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ff8Arialbarfoo90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ff8Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270  0000ff8Arialbarfoo270.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270  0000ff8Arialbarfoo270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ff8Arialbarfoo270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ff8Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ff8Arialbarfoo270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ff8Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ff8Arialbarfoo270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ff8Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar  0000ff10foobar.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar  0000ff10foobar.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -extent 200x200  0000ff10foobar200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -extent 200x200  0000ff10foobar200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -extent 200x800  0000ff10foobar200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -extent 200x800  0000ff10foobar200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -extent 800x200  0000ff10foobar800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -extent 800x200  0000ff10foobar800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 0  0000ff10foobar0.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 0  0000ff10foobar0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 0 -extent 200x200  0000ff10foobar0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 0 -extent 200x200  0000ff10foobar0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 0 -extent 200x800  0000ff10foobar0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 0 -extent 200x800  0000ff10foobar0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 0 -extent 800x200  0000ff10foobar0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 0 -extent 800x200  0000ff10foobar0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 90  0000ff10foobar90.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 90  0000ff10foobar90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 90 -extent 200x200  0000ff10foobar90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 90 -extent 200x200  0000ff10foobar90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 90 -extent 200x800  0000ff10foobar90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 90 -extent 200x800  0000ff10foobar90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 90 -extent 800x200  0000ff10foobar90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 90 -extent 800x200  0000ff10foobar90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 270  0000ff10foobar270.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 270  0000ff10foobar270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 270 -extent 200x200  0000ff10foobar270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 270 -extent 200x200  0000ff10foobar270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 270 -extent 200x800  0000ff10foobar270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 270 -extent 200x800  0000ff10foobar270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 270 -extent 800x200  0000ff10foobar270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:foobar -rotate 270 -extent 800x200  0000ff10foobar270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo  0000ff10barfoo.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo  0000ff10barfoo.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -extent 200x200  0000ff10barfoo200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -extent 200x200  0000ff10barfoo200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -extent 200x800  0000ff10barfoo200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -extent 200x800  0000ff10barfoo200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -extent 800x200  0000ff10barfoo800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -extent 800x200  0000ff10barfoo800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 0  0000ff10barfoo0.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 0  0000ff10barfoo0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 0 -extent 200x200  0000ff10barfoo0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 0 -extent 200x200  0000ff10barfoo0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 0 -extent 200x800  0000ff10barfoo0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 0 -extent 200x800  0000ff10barfoo0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 0 -extent 800x200  0000ff10barfoo0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 0 -extent 800x200  0000ff10barfoo0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 90  0000ff10barfoo90.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 90  0000ff10barfoo90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 90 -extent 200x200  0000ff10barfoo90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 90 -extent 200x200  0000ff10barfoo90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 90 -extent 200x800  0000ff10barfoo90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 90 -extent 200x800  0000ff10barfoo90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 90 -extent 800x200  0000ff10barfoo90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 90 -extent 800x200  0000ff10barfoo90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 270  0000ff10barfoo270.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 270  0000ff10barfoo270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 270 -extent 200x200  0000ff10barfoo270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 270 -extent 200x200  0000ff10barfoo270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 270 -extent 200x800  0000ff10barfoo270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 270 -extent 200x800  0000ff10barfoo270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 270 -extent 800x200  0000ff10barfoo270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10  label:barfoo -rotate 270 -extent 800x200  0000ff10barfoo270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar  0000ff10Arialfoobar.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar  0000ff10Arialfoobar.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -extent 200x200  0000ff10Arialfoobar200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -extent 200x200  0000ff10Arialfoobar200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -extent 200x800  0000ff10Arialfoobar200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -extent 200x800  0000ff10Arialfoobar200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -extent 800x200  0000ff10Arialfoobar800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -extent 800x200  0000ff10Arialfoobar800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0  0000ff10Arialfoobar0.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0  0000ff10Arialfoobar0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  0000ff10Arialfoobar0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  0000ff10Arialfoobar0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  0000ff10Arialfoobar0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  0000ff10Arialfoobar0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  0000ff10Arialfoobar0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  0000ff10Arialfoobar0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90  0000ff10Arialfoobar90.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90  0000ff10Arialfoobar90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  0000ff10Arialfoobar90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  0000ff10Arialfoobar90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  0000ff10Arialfoobar90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  0000ff10Arialfoobar90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  0000ff10Arialfoobar90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  0000ff10Arialfoobar90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270  0000ff10Arialfoobar270.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270  0000ff10Arialfoobar270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  0000ff10Arialfoobar270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  0000ff10Arialfoobar270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  0000ff10Arialfoobar270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  0000ff10Arialfoobar270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  0000ff10Arialfoobar270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  0000ff10Arialfoobar270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo  0000ff10Arialbarfoo.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo  0000ff10Arialbarfoo.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -extent 200x200  0000ff10Arialbarfoo200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -extent 200x200  0000ff10Arialbarfoo200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -extent 200x800  0000ff10Arialbarfoo200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -extent 200x800  0000ff10Arialbarfoo200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -extent 800x200  0000ff10Arialbarfoo800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -extent 800x200  0000ff10Arialbarfoo800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0  0000ff10Arialbarfoo0.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0  0000ff10Arialbarfoo0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ff10Arialbarfoo0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ff10Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ff10Arialbarfoo0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ff10Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ff10Arialbarfoo0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ff10Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90  0000ff10Arialbarfoo90.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90  0000ff10Arialbarfoo90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ff10Arialbarfoo90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ff10Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ff10Arialbarfoo90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ff10Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ff10Arialbarfoo90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ff10Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270  0000ff10Arialbarfoo270.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270  0000ff10Arialbarfoo270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ff10Arialbarfoo270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ff10Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ff10Arialbarfoo270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ff10Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ff10Arialbarfoo270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ff10Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar  0000ff12foobar.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar  0000ff12foobar.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -extent 200x200  0000ff12foobar200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -extent 200x200  0000ff12foobar200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -extent 200x800  0000ff12foobar200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -extent 200x800  0000ff12foobar200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -extent 800x200  0000ff12foobar800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -extent 800x200  0000ff12foobar800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 0  0000ff12foobar0.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 0  0000ff12foobar0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 0 -extent 200x200  0000ff12foobar0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 0 -extent 200x200  0000ff12foobar0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 0 -extent 200x800  0000ff12foobar0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 0 -extent 200x800  0000ff12foobar0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 0 -extent 800x200  0000ff12foobar0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 0 -extent 800x200  0000ff12foobar0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 90  0000ff12foobar90.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 90  0000ff12foobar90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 90 -extent 200x200  0000ff12foobar90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 90 -extent 200x200  0000ff12foobar90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 90 -extent 200x800  0000ff12foobar90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 90 -extent 200x800  0000ff12foobar90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 90 -extent 800x200  0000ff12foobar90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 90 -extent 800x200  0000ff12foobar90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 270  0000ff12foobar270.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 270  0000ff12foobar270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 270 -extent 200x200  0000ff12foobar270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 270 -extent 200x200  0000ff12foobar270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 270 -extent 200x800  0000ff12foobar270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 270 -extent 200x800  0000ff12foobar270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 270 -extent 800x200  0000ff12foobar270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:foobar -rotate 270 -extent 800x200  0000ff12foobar270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo  0000ff12barfoo.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo  0000ff12barfoo.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -extent 200x200  0000ff12barfoo200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -extent 200x200  0000ff12barfoo200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -extent 200x800  0000ff12barfoo200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -extent 200x800  0000ff12barfoo200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -extent 800x200  0000ff12barfoo800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -extent 800x200  0000ff12barfoo800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 0  0000ff12barfoo0.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 0  0000ff12barfoo0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 0 -extent 200x200  0000ff12barfoo0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 0 -extent 200x200  0000ff12barfoo0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 0 -extent 200x800  0000ff12barfoo0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 0 -extent 200x800  0000ff12barfoo0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 0 -extent 800x200  0000ff12barfoo0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 0 -extent 800x200  0000ff12barfoo0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 90  0000ff12barfoo90.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 90  0000ff12barfoo90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 90 -extent 200x200  0000ff12barfoo90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 90 -extent 200x200  0000ff12barfoo90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 90 -extent 200x800  0000ff12barfoo90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 90 -extent 200x800  0000ff12barfoo90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 90 -extent 800x200  0000ff12barfoo90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 90 -extent 800x200  0000ff12barfoo90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 270  0000ff12barfoo270.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 270  0000ff12barfoo270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 270 -extent 200x200  0000ff12barfoo270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 270 -extent 200x200  0000ff12barfoo270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 270 -extent 200x800  0000ff12barfoo270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 270 -extent 200x800  0000ff12barfoo270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 270 -extent 800x200  0000ff12barfoo270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12  label:barfoo -rotate 270 -extent 800x200  0000ff12barfoo270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar  0000ff12Arialfoobar.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar  0000ff12Arialfoobar.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -extent 200x200  0000ff12Arialfoobar200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -extent 200x200  0000ff12Arialfoobar200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -extent 200x800  0000ff12Arialfoobar200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -extent 200x800  0000ff12Arialfoobar200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -extent 800x200  0000ff12Arialfoobar800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -extent 800x200  0000ff12Arialfoobar800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0  0000ff12Arialfoobar0.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0  0000ff12Arialfoobar0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  0000ff12Arialfoobar0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  0000ff12Arialfoobar0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  0000ff12Arialfoobar0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  0000ff12Arialfoobar0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  0000ff12Arialfoobar0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  0000ff12Arialfoobar0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90  0000ff12Arialfoobar90.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90  0000ff12Arialfoobar90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  0000ff12Arialfoobar90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  0000ff12Arialfoobar90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  0000ff12Arialfoobar90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  0000ff12Arialfoobar90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  0000ff12Arialfoobar90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  0000ff12Arialfoobar90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270  0000ff12Arialfoobar270.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270  0000ff12Arialfoobar270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  0000ff12Arialfoobar270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  0000ff12Arialfoobar270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  0000ff12Arialfoobar270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  0000ff12Arialfoobar270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  0000ff12Arialfoobar270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  0000ff12Arialfoobar270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo  0000ff12Arialbarfoo.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo  0000ff12Arialbarfoo.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -extent 200x200  0000ff12Arialbarfoo200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -extent 200x200  0000ff12Arialbarfoo200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -extent 200x800  0000ff12Arialbarfoo200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -extent 200x800  0000ff12Arialbarfoo200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -extent 800x200  0000ff12Arialbarfoo800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -extent 800x200  0000ff12Arialbarfoo800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0  0000ff12Arialbarfoo0.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0  0000ff12Arialbarfoo0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ff12Arialbarfoo0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ff12Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ff12Arialbarfoo0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ff12Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ff12Arialbarfoo0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ff12Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90  0000ff12Arialbarfoo90.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90  0000ff12Arialbarfoo90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ff12Arialbarfoo90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ff12Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ff12Arialbarfoo90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ff12Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ff12Arialbarfoo90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ff12Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270  0000ff12Arialbarfoo270.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270  0000ff12Arialbarfoo270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ff12Arialbarfoo270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ff12Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ff12Arialbarfoo270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ff12Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ff12Arialbarfoo270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ff12Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar  0000ff18foobar.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar  0000ff18foobar.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -extent 200x200  0000ff18foobar200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -extent 200x200  0000ff18foobar200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -extent 200x800  0000ff18foobar200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -extent 200x800  0000ff18foobar200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -extent 800x200  0000ff18foobar800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -extent 800x200  0000ff18foobar800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 0  0000ff18foobar0.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 0  0000ff18foobar0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 0 -extent 200x200  0000ff18foobar0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 0 -extent 200x200  0000ff18foobar0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 0 -extent 200x800  0000ff18foobar0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 0 -extent 200x800  0000ff18foobar0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 0 -extent 800x200  0000ff18foobar0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 0 -extent 800x200  0000ff18foobar0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 90  0000ff18foobar90.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 90  0000ff18foobar90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 90 -extent 200x200  0000ff18foobar90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 90 -extent 200x200  0000ff18foobar90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 90 -extent 200x800  0000ff18foobar90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 90 -extent 200x800  0000ff18foobar90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 90 -extent 800x200  0000ff18foobar90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 90 -extent 800x200  0000ff18foobar90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 270  0000ff18foobar270.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 270  0000ff18foobar270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 270 -extent 200x200  0000ff18foobar270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 270 -extent 200x200  0000ff18foobar270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 270 -extent 200x800  0000ff18foobar270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 270 -extent 200x800  0000ff18foobar270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 270 -extent 800x200  0000ff18foobar270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:foobar -rotate 270 -extent 800x200  0000ff18foobar270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo  0000ff18barfoo.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo  0000ff18barfoo.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -extent 200x200  0000ff18barfoo200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -extent 200x200  0000ff18barfoo200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -extent 200x800  0000ff18barfoo200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -extent 200x800  0000ff18barfoo200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -extent 800x200  0000ff18barfoo800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -extent 800x200  0000ff18barfoo800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 0  0000ff18barfoo0.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 0  0000ff18barfoo0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 0 -extent 200x200  0000ff18barfoo0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 0 -extent 200x200  0000ff18barfoo0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 0 -extent 200x800  0000ff18barfoo0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 0 -extent 200x800  0000ff18barfoo0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 0 -extent 800x200  0000ff18barfoo0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 0 -extent 800x200  0000ff18barfoo0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 90  0000ff18barfoo90.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 90  0000ff18barfoo90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 90 -extent 200x200  0000ff18barfoo90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 90 -extent 200x200  0000ff18barfoo90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 90 -extent 200x800  0000ff18barfoo90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 90 -extent 200x800  0000ff18barfoo90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 90 -extent 800x200  0000ff18barfoo90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 90 -extent 800x200  0000ff18barfoo90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 270  0000ff18barfoo270.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 270  0000ff18barfoo270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 270 -extent 200x200  0000ff18barfoo270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 270 -extent 200x200  0000ff18barfoo270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 270 -extent 200x800  0000ff18barfoo270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 270 -extent 200x800  0000ff18barfoo270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 270 -extent 800x200  0000ff18barfoo270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18  label:barfoo -rotate 270 -extent 800x200  0000ff18barfoo270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar  0000ff18Arialfoobar.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar  0000ff18Arialfoobar.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -extent 200x200  0000ff18Arialfoobar200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -extent 200x200  0000ff18Arialfoobar200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -extent 200x800  0000ff18Arialfoobar200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -extent 200x800  0000ff18Arialfoobar200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -extent 800x200  0000ff18Arialfoobar800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -extent 800x200  0000ff18Arialfoobar800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0  0000ff18Arialfoobar0.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0  0000ff18Arialfoobar0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  0000ff18Arialfoobar0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  0000ff18Arialfoobar0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  0000ff18Arialfoobar0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  0000ff18Arialfoobar0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  0000ff18Arialfoobar0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  0000ff18Arialfoobar0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90  0000ff18Arialfoobar90.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90  0000ff18Arialfoobar90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  0000ff18Arialfoobar90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  0000ff18Arialfoobar90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  0000ff18Arialfoobar90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  0000ff18Arialfoobar90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  0000ff18Arialfoobar90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  0000ff18Arialfoobar90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270  0000ff18Arialfoobar270.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270  0000ff18Arialfoobar270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  0000ff18Arialfoobar270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  0000ff18Arialfoobar270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  0000ff18Arialfoobar270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  0000ff18Arialfoobar270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  0000ff18Arialfoobar270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  0000ff18Arialfoobar270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo  0000ff18Arialbarfoo.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo  0000ff18Arialbarfoo.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -extent 200x200  0000ff18Arialbarfoo200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -extent 200x200  0000ff18Arialbarfoo200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -extent 200x800  0000ff18Arialbarfoo200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -extent 200x800  0000ff18Arialbarfoo200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -extent 800x200  0000ff18Arialbarfoo800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -extent 800x200  0000ff18Arialbarfoo800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0  0000ff18Arialbarfoo0.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0  0000ff18Arialbarfoo0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ff18Arialbarfoo0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ff18Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ff18Arialbarfoo0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ff18Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ff18Arialbarfoo0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ff18Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90  0000ff18Arialbarfoo90.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90  0000ff18Arialbarfoo90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ff18Arialbarfoo90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ff18Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ff18Arialbarfoo90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ff18Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ff18Arialbarfoo90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ff18Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270  0000ff18Arialbarfoo270.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270  0000ff18Arialbarfoo270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ff18Arialbarfoo270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ff18Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ff18Arialbarfoo270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ff18Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ff18Arialbarfoo270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ff18Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar  0000ff24foobar.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar  0000ff24foobar.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -extent 200x200  0000ff24foobar200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -extent 200x200  0000ff24foobar200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -extent 200x800  0000ff24foobar200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -extent 200x800  0000ff24foobar200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -extent 800x200  0000ff24foobar800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -extent 800x200  0000ff24foobar800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 0  0000ff24foobar0.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 0  0000ff24foobar0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 0 -extent 200x200  0000ff24foobar0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 0 -extent 200x200  0000ff24foobar0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 0 -extent 200x800  0000ff24foobar0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 0 -extent 200x800  0000ff24foobar0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 0 -extent 800x200  0000ff24foobar0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 0 -extent 800x200  0000ff24foobar0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 90  0000ff24foobar90.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 90  0000ff24foobar90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 90 -extent 200x200  0000ff24foobar90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 90 -extent 200x200  0000ff24foobar90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 90 -extent 200x800  0000ff24foobar90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 90 -extent 200x800  0000ff24foobar90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 90 -extent 800x200  0000ff24foobar90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 90 -extent 800x200  0000ff24foobar90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 270  0000ff24foobar270.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 270  0000ff24foobar270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 270 -extent 200x200  0000ff24foobar270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 270 -extent 200x200  0000ff24foobar270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 270 -extent 200x800  0000ff24foobar270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 270 -extent 200x800  0000ff24foobar270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 270 -extent 800x200  0000ff24foobar270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:foobar -rotate 270 -extent 800x200  0000ff24foobar270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo  0000ff24barfoo.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo  0000ff24barfoo.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -extent 200x200  0000ff24barfoo200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -extent 200x200  0000ff24barfoo200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -extent 200x800  0000ff24barfoo200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -extent 200x800  0000ff24barfoo200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -extent 800x200  0000ff24barfoo800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -extent 800x200  0000ff24barfoo800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 0  0000ff24barfoo0.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 0  0000ff24barfoo0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 0 -extent 200x200  0000ff24barfoo0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 0 -extent 200x200  0000ff24barfoo0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 0 -extent 200x800  0000ff24barfoo0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 0 -extent 200x800  0000ff24barfoo0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 0 -extent 800x200  0000ff24barfoo0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 0 -extent 800x200  0000ff24barfoo0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 90  0000ff24barfoo90.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 90  0000ff24barfoo90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 90 -extent 200x200  0000ff24barfoo90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 90 -extent 200x200  0000ff24barfoo90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 90 -extent 200x800  0000ff24barfoo90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 90 -extent 200x800  0000ff24barfoo90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 90 -extent 800x200  0000ff24barfoo90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 90 -extent 800x200  0000ff24barfoo90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 270  0000ff24barfoo270.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 270  0000ff24barfoo270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 270 -extent 200x200  0000ff24barfoo270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 270 -extent 200x200  0000ff24barfoo270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 270 -extent 200x800  0000ff24barfoo270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 270 -extent 200x800  0000ff24barfoo270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 270 -extent 800x200  0000ff24barfoo270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24  label:barfoo -rotate 270 -extent 800x200  0000ff24barfoo270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar  0000ff24Arialfoobar.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar  0000ff24Arialfoobar.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -extent 200x200  0000ff24Arialfoobar200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -extent 200x200  0000ff24Arialfoobar200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -extent 200x800  0000ff24Arialfoobar200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -extent 200x800  0000ff24Arialfoobar200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -extent 800x200  0000ff24Arialfoobar800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -extent 800x200  0000ff24Arialfoobar800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0  0000ff24Arialfoobar0.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0  0000ff24Arialfoobar0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  0000ff24Arialfoobar0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  0000ff24Arialfoobar0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  0000ff24Arialfoobar0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  0000ff24Arialfoobar0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  0000ff24Arialfoobar0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  0000ff24Arialfoobar0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90  0000ff24Arialfoobar90.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90  0000ff24Arialfoobar90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  0000ff24Arialfoobar90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  0000ff24Arialfoobar90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  0000ff24Arialfoobar90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  0000ff24Arialfoobar90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  0000ff24Arialfoobar90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  0000ff24Arialfoobar90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270  0000ff24Arialfoobar270.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270  0000ff24Arialfoobar270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  0000ff24Arialfoobar270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  0000ff24Arialfoobar270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  0000ff24Arialfoobar270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  0000ff24Arialfoobar270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  0000ff24Arialfoobar270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  0000ff24Arialfoobar270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo  0000ff24Arialbarfoo.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo  0000ff24Arialbarfoo.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -extent 200x200  0000ff24Arialbarfoo200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -extent 200x200  0000ff24Arialbarfoo200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -extent 200x800  0000ff24Arialbarfoo200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -extent 200x800  0000ff24Arialbarfoo200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -extent 800x200  0000ff24Arialbarfoo800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -extent 800x200  0000ff24Arialbarfoo800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0  0000ff24Arialbarfoo0.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0  0000ff24Arialbarfoo0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ff24Arialbarfoo0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ff24Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ff24Arialbarfoo0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ff24Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ff24Arialbarfoo0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ff24Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90  0000ff24Arialbarfoo90.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90  0000ff24Arialbarfoo90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ff24Arialbarfoo90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ff24Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ff24Arialbarfoo90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ff24Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ff24Arialbarfoo90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ff24Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270  0000ff24Arialbarfoo270.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270  0000ff24Arialbarfoo270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ff24Arialbarfoo270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ff24Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ff24Arialbarfoo270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ff24Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ff24Arialbarfoo270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ff24Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar  0000ff48foobar.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar  0000ff48foobar.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -extent 200x200  0000ff48foobar200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -extent 200x200  0000ff48foobar200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -extent 200x800  0000ff48foobar200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -extent 200x800  0000ff48foobar200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -extent 800x200  0000ff48foobar800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -extent 800x200  0000ff48foobar800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 0  0000ff48foobar0.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 0  0000ff48foobar0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 0 -extent 200x200  0000ff48foobar0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 0 -extent 200x200  0000ff48foobar0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 0 -extent 200x800  0000ff48foobar0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 0 -extent 200x800  0000ff48foobar0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 0 -extent 800x200  0000ff48foobar0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 0 -extent 800x200  0000ff48foobar0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 90  0000ff48foobar90.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 90  0000ff48foobar90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 90 -extent 200x200  0000ff48foobar90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 90 -extent 200x200  0000ff48foobar90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 90 -extent 200x800  0000ff48foobar90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 90 -extent 200x800  0000ff48foobar90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 90 -extent 800x200  0000ff48foobar90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 90 -extent 800x200  0000ff48foobar90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 270  0000ff48foobar270.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 270  0000ff48foobar270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 270 -extent 200x200  0000ff48foobar270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 270 -extent 200x200  0000ff48foobar270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 270 -extent 200x800  0000ff48foobar270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 270 -extent 200x800  0000ff48foobar270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 270 -extent 800x200  0000ff48foobar270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:foobar -rotate 270 -extent 800x200  0000ff48foobar270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo  0000ff48barfoo.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo  0000ff48barfoo.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -extent 200x200  0000ff48barfoo200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -extent 200x200  0000ff48barfoo200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -extent 200x800  0000ff48barfoo200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -extent 200x800  0000ff48barfoo200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -extent 800x200  0000ff48barfoo800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -extent 800x200  0000ff48barfoo800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 0  0000ff48barfoo0.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 0  0000ff48barfoo0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 0 -extent 200x200  0000ff48barfoo0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 0 -extent 200x200  0000ff48barfoo0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 0 -extent 200x800  0000ff48barfoo0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 0 -extent 200x800  0000ff48barfoo0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 0 -extent 800x200  0000ff48barfoo0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 0 -extent 800x200  0000ff48barfoo0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 90  0000ff48barfoo90.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 90  0000ff48barfoo90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 90 -extent 200x200  0000ff48barfoo90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 90 -extent 200x200  0000ff48barfoo90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 90 -extent 200x800  0000ff48barfoo90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 90 -extent 200x800  0000ff48barfoo90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 90 -extent 800x200  0000ff48barfoo90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 90 -extent 800x200  0000ff48barfoo90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 270  0000ff48barfoo270.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 270  0000ff48barfoo270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 270 -extent 200x200  0000ff48barfoo270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 270 -extent 200x200  0000ff48barfoo270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 270 -extent 200x800  0000ff48barfoo270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 270 -extent 200x800  0000ff48barfoo270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 270 -extent 800x200  0000ff48barfoo270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48  label:barfoo -rotate 270 -extent 800x200  0000ff48barfoo270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar  0000ff48Arialfoobar.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar  0000ff48Arialfoobar.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -extent 200x200  0000ff48Arialfoobar200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -extent 200x200  0000ff48Arialfoobar200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -extent 200x800  0000ff48Arialfoobar200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -extent 200x800  0000ff48Arialfoobar200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -extent 800x200  0000ff48Arialfoobar800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -extent 800x200  0000ff48Arialfoobar800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0  0000ff48Arialfoobar0.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0  0000ff48Arialfoobar0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  0000ff48Arialfoobar0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  0000ff48Arialfoobar0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  0000ff48Arialfoobar0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  0000ff48Arialfoobar0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  0000ff48Arialfoobar0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  0000ff48Arialfoobar0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90  0000ff48Arialfoobar90.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90  0000ff48Arialfoobar90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  0000ff48Arialfoobar90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  0000ff48Arialfoobar90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  0000ff48Arialfoobar90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  0000ff48Arialfoobar90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  0000ff48Arialfoobar90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  0000ff48Arialfoobar90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270  0000ff48Arialfoobar270.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270  0000ff48Arialfoobar270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  0000ff48Arialfoobar270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  0000ff48Arialfoobar270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  0000ff48Arialfoobar270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  0000ff48Arialfoobar270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  0000ff48Arialfoobar270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  0000ff48Arialfoobar270800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo  0000ff48Arialbarfoo.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo  0000ff48Arialbarfoo.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -extent 200x200  0000ff48Arialbarfoo200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -extent 200x200  0000ff48Arialbarfoo200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -extent 200x800  0000ff48Arialbarfoo200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -extent 200x800  0000ff48Arialbarfoo200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -extent 800x200  0000ff48Arialbarfoo800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -extent 800x200  0000ff48Arialbarfoo800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0  0000ff48Arialbarfoo0.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0  0000ff48Arialbarfoo0.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ff48Arialbarfoo0200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  0000ff48Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ff48Arialbarfoo0200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  0000ff48Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ff48Arialbarfoo0800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  0000ff48Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90  0000ff48Arialbarfoo90.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90  0000ff48Arialbarfoo90.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ff48Arialbarfoo90200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  0000ff48Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ff48Arialbarfoo90200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  0000ff48Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ff48Arialbarfoo90800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  0000ff48Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270  0000ff48Arialbarfoo270.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270  0000ff48Arialbarfoo270.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ff48Arialbarfoo270200x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  0000ff48Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ff48Arialbarfoo270200x800.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  0000ff48Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ff48Arialbarfoo270800x200.gif'
convert -verbose -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  0000ff48Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#ff0000'  label:foobar  ff0000foobar.gif'
convert -verbose -background '#ff0000'  label:foobar  ff0000foobar.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -extent 200x200  ff0000foobar200x200.gif'
convert -verbose -background '#ff0000'  label:foobar -extent 200x200  ff0000foobar200x200.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -extent 200x800  ff0000foobar200x800.gif'
convert -verbose -background '#ff0000'  label:foobar -extent 200x800  ff0000foobar200x800.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -extent 800x200  ff0000foobar800x200.gif'
convert -verbose -background '#ff0000'  label:foobar -extent 800x200  ff0000foobar800x200.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -rotate 0  ff0000foobar0.gif'
convert -verbose -background '#ff0000'  label:foobar -rotate 0  ff0000foobar0.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -rotate 0 -extent 200x200  ff0000foobar0200x200.gif'
convert -verbose -background '#ff0000'  label:foobar -rotate 0 -extent 200x200  ff0000foobar0200x200.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -rotate 0 -extent 200x800  ff0000foobar0200x800.gif'
convert -verbose -background '#ff0000'  label:foobar -rotate 0 -extent 200x800  ff0000foobar0200x800.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -rotate 0 -extent 800x200  ff0000foobar0800x200.gif'
convert -verbose -background '#ff0000'  label:foobar -rotate 0 -extent 800x200  ff0000foobar0800x200.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -rotate 90  ff0000foobar90.gif'
convert -verbose -background '#ff0000'  label:foobar -rotate 90  ff0000foobar90.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -rotate 90 -extent 200x200  ff0000foobar90200x200.gif'
convert -verbose -background '#ff0000'  label:foobar -rotate 90 -extent 200x200  ff0000foobar90200x200.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -rotate 90 -extent 200x800  ff0000foobar90200x800.gif'
convert -verbose -background '#ff0000'  label:foobar -rotate 90 -extent 200x800  ff0000foobar90200x800.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -rotate 90 -extent 800x200  ff0000foobar90800x200.gif'
convert -verbose -background '#ff0000'  label:foobar -rotate 90 -extent 800x200  ff0000foobar90800x200.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -rotate 270  ff0000foobar270.gif'
convert -verbose -background '#ff0000'  label:foobar -rotate 270  ff0000foobar270.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -rotate 270 -extent 200x200  ff0000foobar270200x200.gif'
convert -verbose -background '#ff0000'  label:foobar -rotate 270 -extent 200x200  ff0000foobar270200x200.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -rotate 270 -extent 200x800  ff0000foobar270200x800.gif'
convert -verbose -background '#ff0000'  label:foobar -rotate 270 -extent 200x800  ff0000foobar270200x800.gif
echo '

convert -verbose -background '#ff0000'  label:foobar -rotate 270 -extent 800x200  ff0000foobar270800x200.gif'
convert -verbose -background '#ff0000'  label:foobar -rotate 270 -extent 800x200  ff0000foobar270800x200.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo  ff0000barfoo.gif'
convert -verbose -background '#ff0000'  label:barfoo  ff0000barfoo.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -extent 200x200  ff0000barfoo200x200.gif'
convert -verbose -background '#ff0000'  label:barfoo -extent 200x200  ff0000barfoo200x200.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -extent 200x800  ff0000barfoo200x800.gif'
convert -verbose -background '#ff0000'  label:barfoo -extent 200x800  ff0000barfoo200x800.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -extent 800x200  ff0000barfoo800x200.gif'
convert -verbose -background '#ff0000'  label:barfoo -extent 800x200  ff0000barfoo800x200.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -rotate 0  ff0000barfoo0.gif'
convert -verbose -background '#ff0000'  label:barfoo -rotate 0  ff0000barfoo0.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -rotate 0 -extent 200x200  ff0000barfoo0200x200.gif'
convert -verbose -background '#ff0000'  label:barfoo -rotate 0 -extent 200x200  ff0000barfoo0200x200.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -rotate 0 -extent 200x800  ff0000barfoo0200x800.gif'
convert -verbose -background '#ff0000'  label:barfoo -rotate 0 -extent 200x800  ff0000barfoo0200x800.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -rotate 0 -extent 800x200  ff0000barfoo0800x200.gif'
convert -verbose -background '#ff0000'  label:barfoo -rotate 0 -extent 800x200  ff0000barfoo0800x200.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -rotate 90  ff0000barfoo90.gif'
convert -verbose -background '#ff0000'  label:barfoo -rotate 90  ff0000barfoo90.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -rotate 90 -extent 200x200  ff0000barfoo90200x200.gif'
convert -verbose -background '#ff0000'  label:barfoo -rotate 90 -extent 200x200  ff0000barfoo90200x200.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -rotate 90 -extent 200x800  ff0000barfoo90200x800.gif'
convert -verbose -background '#ff0000'  label:barfoo -rotate 90 -extent 200x800  ff0000barfoo90200x800.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -rotate 90 -extent 800x200  ff0000barfoo90800x200.gif'
convert -verbose -background '#ff0000'  label:barfoo -rotate 90 -extent 800x200  ff0000barfoo90800x200.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -rotate 270  ff0000barfoo270.gif'
convert -verbose -background '#ff0000'  label:barfoo -rotate 270  ff0000barfoo270.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -rotate 270 -extent 200x200  ff0000barfoo270200x200.gif'
convert -verbose -background '#ff0000'  label:barfoo -rotate 270 -extent 200x200  ff0000barfoo270200x200.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -rotate 270 -extent 200x800  ff0000barfoo270200x800.gif'
convert -verbose -background '#ff0000'  label:barfoo -rotate 270 -extent 200x800  ff0000barfoo270200x800.gif
echo '

convert -verbose -background '#ff0000'  label:barfoo -rotate 270 -extent 800x200  ff0000barfoo270800x200.gif'
convert -verbose -background '#ff0000'  label:barfoo -rotate 270 -extent 800x200  ff0000barfoo270800x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar  ff0000Arialfoobar.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar  ff0000Arialfoobar.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -extent 200x200  ff0000Arialfoobar200x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -extent 200x200  ff0000Arialfoobar200x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -extent 200x800  ff0000Arialfoobar200x800.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -extent 200x800  ff0000Arialfoobar200x800.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -extent 800x200  ff0000Arialfoobar800x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -extent 800x200  ff0000Arialfoobar800x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 0  ff0000Arialfoobar0.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 0  ff0000Arialfoobar0.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 0 -extent 200x200  ff0000Arialfoobar0200x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 0 -extent 200x200  ff0000Arialfoobar0200x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 0 -extent 200x800  ff0000Arialfoobar0200x800.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 0 -extent 200x800  ff0000Arialfoobar0200x800.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 0 -extent 800x200  ff0000Arialfoobar0800x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 0 -extent 800x200  ff0000Arialfoobar0800x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 90  ff0000Arialfoobar90.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 90  ff0000Arialfoobar90.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 90 -extent 200x200  ff0000Arialfoobar90200x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 90 -extent 200x200  ff0000Arialfoobar90200x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 90 -extent 200x800  ff0000Arialfoobar90200x800.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 90 -extent 200x800  ff0000Arialfoobar90200x800.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 90 -extent 800x200  ff0000Arialfoobar90800x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 90 -extent 800x200  ff0000Arialfoobar90800x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 270  ff0000Arialfoobar270.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 270  ff0000Arialfoobar270.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 270 -extent 200x200  ff0000Arialfoobar270200x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 270 -extent 200x200  ff0000Arialfoobar270200x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 270 -extent 200x800  ff0000Arialfoobar270200x800.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 270 -extent 200x800  ff0000Arialfoobar270200x800.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 270 -extent 800x200  ff0000Arialfoobar270800x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:foobar -rotate 270 -extent 800x200  ff0000Arialfoobar270800x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo  ff0000Arialbarfoo.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo  ff0000Arialbarfoo.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -extent 200x200  ff0000Arialbarfoo200x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -extent 200x200  ff0000Arialbarfoo200x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -extent 200x800  ff0000Arialbarfoo200x800.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -extent 200x800  ff0000Arialbarfoo200x800.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -extent 800x200  ff0000Arialbarfoo800x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -extent 800x200  ff0000Arialbarfoo800x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 0  ff0000Arialbarfoo0.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 0  ff0000Arialbarfoo0.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 0 -extent 200x200  ff0000Arialbarfoo0200x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 0 -extent 200x200  ff0000Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 0 -extent 200x800  ff0000Arialbarfoo0200x800.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 0 -extent 200x800  ff0000Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 0 -extent 800x200  ff0000Arialbarfoo0800x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 0 -extent 800x200  ff0000Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 90  ff0000Arialbarfoo90.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 90  ff0000Arialbarfoo90.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 90 -extent 200x200  ff0000Arialbarfoo90200x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 90 -extent 200x200  ff0000Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 90 -extent 200x800  ff0000Arialbarfoo90200x800.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 90 -extent 200x800  ff0000Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 90 -extent 800x200  ff0000Arialbarfoo90800x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 90 -extent 800x200  ff0000Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 270  ff0000Arialbarfoo270.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 270  ff0000Arialbarfoo270.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 270 -extent 200x200  ff0000Arialbarfoo270200x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 270 -extent 200x200  ff0000Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 270 -extent 200x800  ff0000Arialbarfoo270200x800.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 270 -extent 200x800  ff0000Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 270 -extent 800x200  ff0000Arialbarfoo270800x200.gif'
convert -verbose -background '#ff0000' -font Arial  label:barfoo -rotate 270 -extent 800x200  ff0000Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar  ff00008foobar.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar  ff00008foobar.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -extent 200x200  ff00008foobar200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -extent 200x200  ff00008foobar200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -extent 200x800  ff00008foobar200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -extent 200x800  ff00008foobar200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -extent 800x200  ff00008foobar800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -extent 800x200  ff00008foobar800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 0  ff00008foobar0.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 0  ff00008foobar0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 0 -extent 200x200  ff00008foobar0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 0 -extent 200x200  ff00008foobar0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 0 -extent 200x800  ff00008foobar0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 0 -extent 200x800  ff00008foobar0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 0 -extent 800x200  ff00008foobar0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 0 -extent 800x200  ff00008foobar0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 90  ff00008foobar90.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 90  ff00008foobar90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 90 -extent 200x200  ff00008foobar90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 90 -extent 200x200  ff00008foobar90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 90 -extent 200x800  ff00008foobar90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 90 -extent 200x800  ff00008foobar90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 90 -extent 800x200  ff00008foobar90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 90 -extent 800x200  ff00008foobar90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 270  ff00008foobar270.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 270  ff00008foobar270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 270 -extent 200x200  ff00008foobar270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 270 -extent 200x200  ff00008foobar270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 270 -extent 200x800  ff00008foobar270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 270 -extent 200x800  ff00008foobar270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 270 -extent 800x200  ff00008foobar270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:foobar -rotate 270 -extent 800x200  ff00008foobar270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo  ff00008barfoo.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo  ff00008barfoo.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -extent 200x200  ff00008barfoo200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -extent 200x200  ff00008barfoo200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -extent 200x800  ff00008barfoo200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -extent 200x800  ff00008barfoo200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -extent 800x200  ff00008barfoo800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -extent 800x200  ff00008barfoo800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 0  ff00008barfoo0.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 0  ff00008barfoo0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 0 -extent 200x200  ff00008barfoo0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 0 -extent 200x200  ff00008barfoo0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 0 -extent 200x800  ff00008barfoo0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 0 -extent 200x800  ff00008barfoo0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 0 -extent 800x200  ff00008barfoo0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 0 -extent 800x200  ff00008barfoo0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 90  ff00008barfoo90.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 90  ff00008barfoo90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 90 -extent 200x200  ff00008barfoo90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 90 -extent 200x200  ff00008barfoo90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 90 -extent 200x800  ff00008barfoo90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 90 -extent 200x800  ff00008barfoo90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 90 -extent 800x200  ff00008barfoo90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 90 -extent 800x200  ff00008barfoo90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 270  ff00008barfoo270.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 270  ff00008barfoo270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 270 -extent 200x200  ff00008barfoo270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 270 -extent 200x200  ff00008barfoo270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 270 -extent 200x800  ff00008barfoo270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 270 -extent 200x800  ff00008barfoo270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 270 -extent 800x200  ff00008barfoo270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8  label:barfoo -rotate 270 -extent 800x200  ff00008barfoo270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar  ff00008Arialfoobar.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar  ff00008Arialfoobar.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -extent 200x200  ff00008Arialfoobar200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -extent 200x200  ff00008Arialfoobar200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -extent 200x800  ff00008Arialfoobar200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -extent 200x800  ff00008Arialfoobar200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -extent 800x200  ff00008Arialfoobar800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -extent 800x200  ff00008Arialfoobar800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0  ff00008Arialfoobar0.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0  ff00008Arialfoobar0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  ff00008Arialfoobar0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  ff00008Arialfoobar0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  ff00008Arialfoobar0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  ff00008Arialfoobar0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  ff00008Arialfoobar0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  ff00008Arialfoobar0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90  ff00008Arialfoobar90.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90  ff00008Arialfoobar90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  ff00008Arialfoobar90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  ff00008Arialfoobar90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  ff00008Arialfoobar90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  ff00008Arialfoobar90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  ff00008Arialfoobar90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  ff00008Arialfoobar90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270  ff00008Arialfoobar270.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270  ff00008Arialfoobar270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  ff00008Arialfoobar270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  ff00008Arialfoobar270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  ff00008Arialfoobar270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  ff00008Arialfoobar270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  ff00008Arialfoobar270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  ff00008Arialfoobar270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo  ff00008Arialbarfoo.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo  ff00008Arialbarfoo.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -extent 200x200  ff00008Arialbarfoo200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -extent 200x200  ff00008Arialbarfoo200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -extent 200x800  ff00008Arialbarfoo200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -extent 200x800  ff00008Arialbarfoo200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -extent 800x200  ff00008Arialbarfoo800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -extent 800x200  ff00008Arialbarfoo800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0  ff00008Arialbarfoo0.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0  ff00008Arialbarfoo0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  ff00008Arialbarfoo0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  ff00008Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  ff00008Arialbarfoo0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  ff00008Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  ff00008Arialbarfoo0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  ff00008Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90  ff00008Arialbarfoo90.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90  ff00008Arialbarfoo90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  ff00008Arialbarfoo90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  ff00008Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  ff00008Arialbarfoo90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  ff00008Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  ff00008Arialbarfoo90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  ff00008Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270  ff00008Arialbarfoo270.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270  ff00008Arialbarfoo270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  ff00008Arialbarfoo270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  ff00008Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  ff00008Arialbarfoo270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  ff00008Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  ff00008Arialbarfoo270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  ff00008Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar  ff000010foobar.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar  ff000010foobar.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -extent 200x200  ff000010foobar200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -extent 200x200  ff000010foobar200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -extent 200x800  ff000010foobar200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -extent 200x800  ff000010foobar200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -extent 800x200  ff000010foobar800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -extent 800x200  ff000010foobar800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 0  ff000010foobar0.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 0  ff000010foobar0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 0 -extent 200x200  ff000010foobar0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 0 -extent 200x200  ff000010foobar0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 0 -extent 200x800  ff000010foobar0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 0 -extent 200x800  ff000010foobar0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 0 -extent 800x200  ff000010foobar0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 0 -extent 800x200  ff000010foobar0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 90  ff000010foobar90.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 90  ff000010foobar90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 90 -extent 200x200  ff000010foobar90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 90 -extent 200x200  ff000010foobar90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 90 -extent 200x800  ff000010foobar90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 90 -extent 200x800  ff000010foobar90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 90 -extent 800x200  ff000010foobar90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 90 -extent 800x200  ff000010foobar90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 270  ff000010foobar270.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 270  ff000010foobar270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 270 -extent 200x200  ff000010foobar270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 270 -extent 200x200  ff000010foobar270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 270 -extent 200x800  ff000010foobar270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 270 -extent 200x800  ff000010foobar270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 270 -extent 800x200  ff000010foobar270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:foobar -rotate 270 -extent 800x200  ff000010foobar270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo  ff000010barfoo.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo  ff000010barfoo.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -extent 200x200  ff000010barfoo200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -extent 200x200  ff000010barfoo200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -extent 200x800  ff000010barfoo200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -extent 200x800  ff000010barfoo200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -extent 800x200  ff000010barfoo800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -extent 800x200  ff000010barfoo800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 0  ff000010barfoo0.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 0  ff000010barfoo0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 0 -extent 200x200  ff000010barfoo0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 0 -extent 200x200  ff000010barfoo0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 0 -extent 200x800  ff000010barfoo0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 0 -extent 200x800  ff000010barfoo0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 0 -extent 800x200  ff000010barfoo0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 0 -extent 800x200  ff000010barfoo0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 90  ff000010barfoo90.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 90  ff000010barfoo90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 90 -extent 200x200  ff000010barfoo90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 90 -extent 200x200  ff000010barfoo90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 90 -extent 200x800  ff000010barfoo90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 90 -extent 200x800  ff000010barfoo90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 90 -extent 800x200  ff000010barfoo90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 90 -extent 800x200  ff000010barfoo90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 270  ff000010barfoo270.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 270  ff000010barfoo270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 270 -extent 200x200  ff000010barfoo270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 270 -extent 200x200  ff000010barfoo270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 270 -extent 200x800  ff000010barfoo270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 270 -extent 200x800  ff000010barfoo270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 270 -extent 800x200  ff000010barfoo270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10  label:barfoo -rotate 270 -extent 800x200  ff000010barfoo270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar  ff000010Arialfoobar.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar  ff000010Arialfoobar.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -extent 200x200  ff000010Arialfoobar200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -extent 200x200  ff000010Arialfoobar200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -extent 200x800  ff000010Arialfoobar200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -extent 200x800  ff000010Arialfoobar200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -extent 800x200  ff000010Arialfoobar800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -extent 800x200  ff000010Arialfoobar800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0  ff000010Arialfoobar0.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0  ff000010Arialfoobar0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  ff000010Arialfoobar0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  ff000010Arialfoobar0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  ff000010Arialfoobar0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  ff000010Arialfoobar0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  ff000010Arialfoobar0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  ff000010Arialfoobar0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90  ff000010Arialfoobar90.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90  ff000010Arialfoobar90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  ff000010Arialfoobar90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  ff000010Arialfoobar90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  ff000010Arialfoobar90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  ff000010Arialfoobar90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  ff000010Arialfoobar90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  ff000010Arialfoobar90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270  ff000010Arialfoobar270.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270  ff000010Arialfoobar270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  ff000010Arialfoobar270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  ff000010Arialfoobar270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  ff000010Arialfoobar270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  ff000010Arialfoobar270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  ff000010Arialfoobar270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  ff000010Arialfoobar270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo  ff000010Arialbarfoo.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo  ff000010Arialbarfoo.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -extent 200x200  ff000010Arialbarfoo200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -extent 200x200  ff000010Arialbarfoo200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -extent 200x800  ff000010Arialbarfoo200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -extent 200x800  ff000010Arialbarfoo200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -extent 800x200  ff000010Arialbarfoo800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -extent 800x200  ff000010Arialbarfoo800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0  ff000010Arialbarfoo0.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0  ff000010Arialbarfoo0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  ff000010Arialbarfoo0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  ff000010Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  ff000010Arialbarfoo0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  ff000010Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  ff000010Arialbarfoo0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  ff000010Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90  ff000010Arialbarfoo90.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90  ff000010Arialbarfoo90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  ff000010Arialbarfoo90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  ff000010Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  ff000010Arialbarfoo90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  ff000010Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  ff000010Arialbarfoo90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  ff000010Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270  ff000010Arialbarfoo270.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270  ff000010Arialbarfoo270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  ff000010Arialbarfoo270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  ff000010Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  ff000010Arialbarfoo270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  ff000010Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  ff000010Arialbarfoo270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  ff000010Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar  ff000012foobar.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar  ff000012foobar.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -extent 200x200  ff000012foobar200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -extent 200x200  ff000012foobar200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -extent 200x800  ff000012foobar200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -extent 200x800  ff000012foobar200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -extent 800x200  ff000012foobar800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -extent 800x200  ff000012foobar800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 0  ff000012foobar0.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 0  ff000012foobar0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 0 -extent 200x200  ff000012foobar0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 0 -extent 200x200  ff000012foobar0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 0 -extent 200x800  ff000012foobar0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 0 -extent 200x800  ff000012foobar0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 0 -extent 800x200  ff000012foobar0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 0 -extent 800x200  ff000012foobar0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 90  ff000012foobar90.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 90  ff000012foobar90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 90 -extent 200x200  ff000012foobar90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 90 -extent 200x200  ff000012foobar90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 90 -extent 200x800  ff000012foobar90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 90 -extent 200x800  ff000012foobar90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 90 -extent 800x200  ff000012foobar90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 90 -extent 800x200  ff000012foobar90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 270  ff000012foobar270.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 270  ff000012foobar270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 270 -extent 200x200  ff000012foobar270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 270 -extent 200x200  ff000012foobar270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 270 -extent 200x800  ff000012foobar270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 270 -extent 200x800  ff000012foobar270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 270 -extent 800x200  ff000012foobar270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:foobar -rotate 270 -extent 800x200  ff000012foobar270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo  ff000012barfoo.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo  ff000012barfoo.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -extent 200x200  ff000012barfoo200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -extent 200x200  ff000012barfoo200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -extent 200x800  ff000012barfoo200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -extent 200x800  ff000012barfoo200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -extent 800x200  ff000012barfoo800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -extent 800x200  ff000012barfoo800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 0  ff000012barfoo0.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 0  ff000012barfoo0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 0 -extent 200x200  ff000012barfoo0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 0 -extent 200x200  ff000012barfoo0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 0 -extent 200x800  ff000012barfoo0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 0 -extent 200x800  ff000012barfoo0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 0 -extent 800x200  ff000012barfoo0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 0 -extent 800x200  ff000012barfoo0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 90  ff000012barfoo90.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 90  ff000012barfoo90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 90 -extent 200x200  ff000012barfoo90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 90 -extent 200x200  ff000012barfoo90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 90 -extent 200x800  ff000012barfoo90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 90 -extent 200x800  ff000012barfoo90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 90 -extent 800x200  ff000012barfoo90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 90 -extent 800x200  ff000012barfoo90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 270  ff000012barfoo270.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 270  ff000012barfoo270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 270 -extent 200x200  ff000012barfoo270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 270 -extent 200x200  ff000012barfoo270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 270 -extent 200x800  ff000012barfoo270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 270 -extent 200x800  ff000012barfoo270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 270 -extent 800x200  ff000012barfoo270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12  label:barfoo -rotate 270 -extent 800x200  ff000012barfoo270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar  ff000012Arialfoobar.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar  ff000012Arialfoobar.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -extent 200x200  ff000012Arialfoobar200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -extent 200x200  ff000012Arialfoobar200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -extent 200x800  ff000012Arialfoobar200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -extent 200x800  ff000012Arialfoobar200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -extent 800x200  ff000012Arialfoobar800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -extent 800x200  ff000012Arialfoobar800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0  ff000012Arialfoobar0.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0  ff000012Arialfoobar0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  ff000012Arialfoobar0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  ff000012Arialfoobar0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  ff000012Arialfoobar0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  ff000012Arialfoobar0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  ff000012Arialfoobar0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  ff000012Arialfoobar0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90  ff000012Arialfoobar90.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90  ff000012Arialfoobar90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  ff000012Arialfoobar90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  ff000012Arialfoobar90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  ff000012Arialfoobar90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  ff000012Arialfoobar90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  ff000012Arialfoobar90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  ff000012Arialfoobar90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270  ff000012Arialfoobar270.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270  ff000012Arialfoobar270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  ff000012Arialfoobar270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  ff000012Arialfoobar270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  ff000012Arialfoobar270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  ff000012Arialfoobar270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  ff000012Arialfoobar270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  ff000012Arialfoobar270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo  ff000012Arialbarfoo.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo  ff000012Arialbarfoo.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -extent 200x200  ff000012Arialbarfoo200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -extent 200x200  ff000012Arialbarfoo200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -extent 200x800  ff000012Arialbarfoo200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -extent 200x800  ff000012Arialbarfoo200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -extent 800x200  ff000012Arialbarfoo800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -extent 800x200  ff000012Arialbarfoo800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0  ff000012Arialbarfoo0.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0  ff000012Arialbarfoo0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  ff000012Arialbarfoo0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  ff000012Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  ff000012Arialbarfoo0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  ff000012Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  ff000012Arialbarfoo0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  ff000012Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90  ff000012Arialbarfoo90.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90  ff000012Arialbarfoo90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  ff000012Arialbarfoo90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  ff000012Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  ff000012Arialbarfoo90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  ff000012Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  ff000012Arialbarfoo90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  ff000012Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270  ff000012Arialbarfoo270.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270  ff000012Arialbarfoo270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  ff000012Arialbarfoo270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  ff000012Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  ff000012Arialbarfoo270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  ff000012Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  ff000012Arialbarfoo270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  ff000012Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar  ff000018foobar.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar  ff000018foobar.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -extent 200x200  ff000018foobar200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -extent 200x200  ff000018foobar200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -extent 200x800  ff000018foobar200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -extent 200x800  ff000018foobar200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -extent 800x200  ff000018foobar800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -extent 800x200  ff000018foobar800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 0  ff000018foobar0.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 0  ff000018foobar0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 0 -extent 200x200  ff000018foobar0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 0 -extent 200x200  ff000018foobar0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 0 -extent 200x800  ff000018foobar0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 0 -extent 200x800  ff000018foobar0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 0 -extent 800x200  ff000018foobar0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 0 -extent 800x200  ff000018foobar0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 90  ff000018foobar90.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 90  ff000018foobar90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 90 -extent 200x200  ff000018foobar90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 90 -extent 200x200  ff000018foobar90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 90 -extent 200x800  ff000018foobar90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 90 -extent 200x800  ff000018foobar90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 90 -extent 800x200  ff000018foobar90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 90 -extent 800x200  ff000018foobar90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 270  ff000018foobar270.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 270  ff000018foobar270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 270 -extent 200x200  ff000018foobar270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 270 -extent 200x200  ff000018foobar270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 270 -extent 200x800  ff000018foobar270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 270 -extent 200x800  ff000018foobar270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 270 -extent 800x200  ff000018foobar270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:foobar -rotate 270 -extent 800x200  ff000018foobar270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo  ff000018barfoo.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo  ff000018barfoo.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -extent 200x200  ff000018barfoo200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -extent 200x200  ff000018barfoo200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -extent 200x800  ff000018barfoo200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -extent 200x800  ff000018barfoo200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -extent 800x200  ff000018barfoo800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -extent 800x200  ff000018barfoo800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 0  ff000018barfoo0.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 0  ff000018barfoo0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 0 -extent 200x200  ff000018barfoo0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 0 -extent 200x200  ff000018barfoo0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 0 -extent 200x800  ff000018barfoo0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 0 -extent 200x800  ff000018barfoo0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 0 -extent 800x200  ff000018barfoo0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 0 -extent 800x200  ff000018barfoo0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 90  ff000018barfoo90.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 90  ff000018barfoo90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 90 -extent 200x200  ff000018barfoo90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 90 -extent 200x200  ff000018barfoo90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 90 -extent 200x800  ff000018barfoo90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 90 -extent 200x800  ff000018barfoo90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 90 -extent 800x200  ff000018barfoo90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 90 -extent 800x200  ff000018barfoo90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 270  ff000018barfoo270.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 270  ff000018barfoo270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 270 -extent 200x200  ff000018barfoo270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 270 -extent 200x200  ff000018barfoo270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 270 -extent 200x800  ff000018barfoo270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 270 -extent 200x800  ff000018barfoo270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 270 -extent 800x200  ff000018barfoo270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18  label:barfoo -rotate 270 -extent 800x200  ff000018barfoo270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar  ff000018Arialfoobar.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar  ff000018Arialfoobar.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -extent 200x200  ff000018Arialfoobar200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -extent 200x200  ff000018Arialfoobar200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -extent 200x800  ff000018Arialfoobar200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -extent 200x800  ff000018Arialfoobar200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -extent 800x200  ff000018Arialfoobar800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -extent 800x200  ff000018Arialfoobar800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0  ff000018Arialfoobar0.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0  ff000018Arialfoobar0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  ff000018Arialfoobar0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  ff000018Arialfoobar0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  ff000018Arialfoobar0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  ff000018Arialfoobar0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  ff000018Arialfoobar0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  ff000018Arialfoobar0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90  ff000018Arialfoobar90.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90  ff000018Arialfoobar90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  ff000018Arialfoobar90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  ff000018Arialfoobar90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  ff000018Arialfoobar90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  ff000018Arialfoobar90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  ff000018Arialfoobar90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  ff000018Arialfoobar90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270  ff000018Arialfoobar270.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270  ff000018Arialfoobar270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  ff000018Arialfoobar270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  ff000018Arialfoobar270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  ff000018Arialfoobar270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  ff000018Arialfoobar270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  ff000018Arialfoobar270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  ff000018Arialfoobar270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo  ff000018Arialbarfoo.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo  ff000018Arialbarfoo.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -extent 200x200  ff000018Arialbarfoo200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -extent 200x200  ff000018Arialbarfoo200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -extent 200x800  ff000018Arialbarfoo200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -extent 200x800  ff000018Arialbarfoo200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -extent 800x200  ff000018Arialbarfoo800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -extent 800x200  ff000018Arialbarfoo800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0  ff000018Arialbarfoo0.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0  ff000018Arialbarfoo0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  ff000018Arialbarfoo0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  ff000018Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  ff000018Arialbarfoo0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  ff000018Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  ff000018Arialbarfoo0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  ff000018Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90  ff000018Arialbarfoo90.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90  ff000018Arialbarfoo90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  ff000018Arialbarfoo90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  ff000018Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  ff000018Arialbarfoo90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  ff000018Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  ff000018Arialbarfoo90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  ff000018Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270  ff000018Arialbarfoo270.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270  ff000018Arialbarfoo270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  ff000018Arialbarfoo270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  ff000018Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  ff000018Arialbarfoo270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  ff000018Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  ff000018Arialbarfoo270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  ff000018Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar  ff000024foobar.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar  ff000024foobar.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -extent 200x200  ff000024foobar200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -extent 200x200  ff000024foobar200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -extent 200x800  ff000024foobar200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -extent 200x800  ff000024foobar200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -extent 800x200  ff000024foobar800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -extent 800x200  ff000024foobar800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 0  ff000024foobar0.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 0  ff000024foobar0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 0 -extent 200x200  ff000024foobar0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 0 -extent 200x200  ff000024foobar0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 0 -extent 200x800  ff000024foobar0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 0 -extent 200x800  ff000024foobar0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 0 -extent 800x200  ff000024foobar0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 0 -extent 800x200  ff000024foobar0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 90  ff000024foobar90.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 90  ff000024foobar90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 90 -extent 200x200  ff000024foobar90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 90 -extent 200x200  ff000024foobar90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 90 -extent 200x800  ff000024foobar90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 90 -extent 200x800  ff000024foobar90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 90 -extent 800x200  ff000024foobar90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 90 -extent 800x200  ff000024foobar90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 270  ff000024foobar270.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 270  ff000024foobar270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 270 -extent 200x200  ff000024foobar270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 270 -extent 200x200  ff000024foobar270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 270 -extent 200x800  ff000024foobar270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 270 -extent 200x800  ff000024foobar270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 270 -extent 800x200  ff000024foobar270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:foobar -rotate 270 -extent 800x200  ff000024foobar270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo  ff000024barfoo.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo  ff000024barfoo.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -extent 200x200  ff000024barfoo200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -extent 200x200  ff000024barfoo200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -extent 200x800  ff000024barfoo200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -extent 200x800  ff000024barfoo200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -extent 800x200  ff000024barfoo800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -extent 800x200  ff000024barfoo800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 0  ff000024barfoo0.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 0  ff000024barfoo0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 0 -extent 200x200  ff000024barfoo0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 0 -extent 200x200  ff000024barfoo0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 0 -extent 200x800  ff000024barfoo0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 0 -extent 200x800  ff000024barfoo0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 0 -extent 800x200  ff000024barfoo0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 0 -extent 800x200  ff000024barfoo0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 90  ff000024barfoo90.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 90  ff000024barfoo90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 90 -extent 200x200  ff000024barfoo90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 90 -extent 200x200  ff000024barfoo90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 90 -extent 200x800  ff000024barfoo90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 90 -extent 200x800  ff000024barfoo90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 90 -extent 800x200  ff000024barfoo90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 90 -extent 800x200  ff000024barfoo90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 270  ff000024barfoo270.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 270  ff000024barfoo270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 270 -extent 200x200  ff000024barfoo270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 270 -extent 200x200  ff000024barfoo270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 270 -extent 200x800  ff000024barfoo270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 270 -extent 200x800  ff000024barfoo270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 270 -extent 800x200  ff000024barfoo270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24  label:barfoo -rotate 270 -extent 800x200  ff000024barfoo270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar  ff000024Arialfoobar.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar  ff000024Arialfoobar.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -extent 200x200  ff000024Arialfoobar200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -extent 200x200  ff000024Arialfoobar200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -extent 200x800  ff000024Arialfoobar200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -extent 200x800  ff000024Arialfoobar200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -extent 800x200  ff000024Arialfoobar800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -extent 800x200  ff000024Arialfoobar800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0  ff000024Arialfoobar0.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0  ff000024Arialfoobar0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  ff000024Arialfoobar0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  ff000024Arialfoobar0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  ff000024Arialfoobar0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  ff000024Arialfoobar0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  ff000024Arialfoobar0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  ff000024Arialfoobar0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90  ff000024Arialfoobar90.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90  ff000024Arialfoobar90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  ff000024Arialfoobar90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  ff000024Arialfoobar90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  ff000024Arialfoobar90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  ff000024Arialfoobar90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  ff000024Arialfoobar90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  ff000024Arialfoobar90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270  ff000024Arialfoobar270.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270  ff000024Arialfoobar270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  ff000024Arialfoobar270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  ff000024Arialfoobar270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  ff000024Arialfoobar270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  ff000024Arialfoobar270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  ff000024Arialfoobar270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  ff000024Arialfoobar270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo  ff000024Arialbarfoo.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo  ff000024Arialbarfoo.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -extent 200x200  ff000024Arialbarfoo200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -extent 200x200  ff000024Arialbarfoo200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -extent 200x800  ff000024Arialbarfoo200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -extent 200x800  ff000024Arialbarfoo200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -extent 800x200  ff000024Arialbarfoo800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -extent 800x200  ff000024Arialbarfoo800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0  ff000024Arialbarfoo0.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0  ff000024Arialbarfoo0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  ff000024Arialbarfoo0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  ff000024Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  ff000024Arialbarfoo0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  ff000024Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  ff000024Arialbarfoo0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  ff000024Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90  ff000024Arialbarfoo90.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90  ff000024Arialbarfoo90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  ff000024Arialbarfoo90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  ff000024Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  ff000024Arialbarfoo90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  ff000024Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  ff000024Arialbarfoo90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  ff000024Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270  ff000024Arialbarfoo270.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270  ff000024Arialbarfoo270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  ff000024Arialbarfoo270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  ff000024Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  ff000024Arialbarfoo270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  ff000024Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  ff000024Arialbarfoo270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  ff000024Arialbarfoo270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar  ff000048foobar.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar  ff000048foobar.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -extent 200x200  ff000048foobar200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -extent 200x200  ff000048foobar200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -extent 200x800  ff000048foobar200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -extent 200x800  ff000048foobar200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -extent 800x200  ff000048foobar800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -extent 800x200  ff000048foobar800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 0  ff000048foobar0.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 0  ff000048foobar0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 0 -extent 200x200  ff000048foobar0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 0 -extent 200x200  ff000048foobar0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 0 -extent 200x800  ff000048foobar0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 0 -extent 200x800  ff000048foobar0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 0 -extent 800x200  ff000048foobar0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 0 -extent 800x200  ff000048foobar0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 90  ff000048foobar90.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 90  ff000048foobar90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 90 -extent 200x200  ff000048foobar90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 90 -extent 200x200  ff000048foobar90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 90 -extent 200x800  ff000048foobar90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 90 -extent 200x800  ff000048foobar90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 90 -extent 800x200  ff000048foobar90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 90 -extent 800x200  ff000048foobar90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 270  ff000048foobar270.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 270  ff000048foobar270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 270 -extent 200x200  ff000048foobar270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 270 -extent 200x200  ff000048foobar270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 270 -extent 200x800  ff000048foobar270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 270 -extent 200x800  ff000048foobar270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 270 -extent 800x200  ff000048foobar270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:foobar -rotate 270 -extent 800x200  ff000048foobar270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo  ff000048barfoo.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo  ff000048barfoo.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -extent 200x200  ff000048barfoo200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -extent 200x200  ff000048barfoo200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -extent 200x800  ff000048barfoo200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -extent 200x800  ff000048barfoo200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -extent 800x200  ff000048barfoo800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -extent 800x200  ff000048barfoo800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 0  ff000048barfoo0.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 0  ff000048barfoo0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 0 -extent 200x200  ff000048barfoo0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 0 -extent 200x200  ff000048barfoo0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 0 -extent 200x800  ff000048barfoo0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 0 -extent 200x800  ff000048barfoo0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 0 -extent 800x200  ff000048barfoo0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 0 -extent 800x200  ff000048barfoo0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 90  ff000048barfoo90.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 90  ff000048barfoo90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 90 -extent 200x200  ff000048barfoo90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 90 -extent 200x200  ff000048barfoo90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 90 -extent 200x800  ff000048barfoo90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 90 -extent 200x800  ff000048barfoo90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 90 -extent 800x200  ff000048barfoo90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 90 -extent 800x200  ff000048barfoo90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 270  ff000048barfoo270.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 270  ff000048barfoo270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 270 -extent 200x200  ff000048barfoo270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 270 -extent 200x200  ff000048barfoo270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 270 -extent 200x800  ff000048barfoo270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 270 -extent 200x800  ff000048barfoo270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 270 -extent 800x200  ff000048barfoo270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48  label:barfoo -rotate 270 -extent 800x200  ff000048barfoo270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar  ff000048Arialfoobar.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar  ff000048Arialfoobar.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -extent 200x200  ff000048Arialfoobar200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -extent 200x200  ff000048Arialfoobar200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -extent 200x800  ff000048Arialfoobar200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -extent 200x800  ff000048Arialfoobar200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -extent 800x200  ff000048Arialfoobar800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -extent 800x200  ff000048Arialfoobar800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0  ff000048Arialfoobar0.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0  ff000048Arialfoobar0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  ff000048Arialfoobar0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  ff000048Arialfoobar0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  ff000048Arialfoobar0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  ff000048Arialfoobar0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  ff000048Arialfoobar0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  ff000048Arialfoobar0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90  ff000048Arialfoobar90.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90  ff000048Arialfoobar90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  ff000048Arialfoobar90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  ff000048Arialfoobar90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  ff000048Arialfoobar90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  ff000048Arialfoobar90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  ff000048Arialfoobar90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  ff000048Arialfoobar90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270  ff000048Arialfoobar270.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270  ff000048Arialfoobar270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  ff000048Arialfoobar270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  ff000048Arialfoobar270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  ff000048Arialfoobar270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  ff000048Arialfoobar270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  ff000048Arialfoobar270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  ff000048Arialfoobar270800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo  ff000048Arialbarfoo.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo  ff000048Arialbarfoo.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -extent 200x200  ff000048Arialbarfoo200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -extent 200x200  ff000048Arialbarfoo200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -extent 200x800  ff000048Arialbarfoo200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -extent 200x800  ff000048Arialbarfoo200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -extent 800x200  ff000048Arialbarfoo800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -extent 800x200  ff000048Arialbarfoo800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0  ff000048Arialbarfoo0.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0  ff000048Arialbarfoo0.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  ff000048Arialbarfoo0200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  ff000048Arialbarfoo0200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  ff000048Arialbarfoo0200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  ff000048Arialbarfoo0200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  ff000048Arialbarfoo0800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  ff000048Arialbarfoo0800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90  ff000048Arialbarfoo90.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90  ff000048Arialbarfoo90.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  ff000048Arialbarfoo90200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  ff000048Arialbarfoo90200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  ff000048Arialbarfoo90200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  ff000048Arialbarfoo90200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  ff000048Arialbarfoo90800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  ff000048Arialbarfoo90800x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270  ff000048Arialbarfoo270.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270  ff000048Arialbarfoo270.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  ff000048Arialbarfoo270200x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  ff000048Arialbarfoo270200x200.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  ff000048Arialbarfoo270200x800.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  ff000048Arialbarfoo270200x800.gif
echo '

convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  ff000048Arialbarfoo270800x200.gif'
convert -verbose -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  ff000048Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center  label:foobar  centerfoobar.gif'
convert -verbose -gravity center  label:foobar  centerfoobar.gif
echo '

convert -verbose -gravity center  label:foobar -extent 200x200  centerfoobar200x200.gif'
convert -verbose -gravity center  label:foobar -extent 200x200  centerfoobar200x200.gif
echo '

convert -verbose -gravity center  label:foobar -extent 200x800  centerfoobar200x800.gif'
convert -verbose -gravity center  label:foobar -extent 200x800  centerfoobar200x800.gif
echo '

convert -verbose -gravity center  label:foobar -extent 800x200  centerfoobar800x200.gif'
convert -verbose -gravity center  label:foobar -extent 800x200  centerfoobar800x200.gif
echo '

convert -verbose -gravity center  label:foobar -rotate 0  centerfoobar0.gif'
convert -verbose -gravity center  label:foobar -rotate 0  centerfoobar0.gif
echo '

convert -verbose -gravity center  label:foobar -rotate 0 -extent 200x200  centerfoobar0200x200.gif'
convert -verbose -gravity center  label:foobar -rotate 0 -extent 200x200  centerfoobar0200x200.gif
echo '

convert -verbose -gravity center  label:foobar -rotate 0 -extent 200x800  centerfoobar0200x800.gif'
convert -verbose -gravity center  label:foobar -rotate 0 -extent 200x800  centerfoobar0200x800.gif
echo '

convert -verbose -gravity center  label:foobar -rotate 0 -extent 800x200  centerfoobar0800x200.gif'
convert -verbose -gravity center  label:foobar -rotate 0 -extent 800x200  centerfoobar0800x200.gif
echo '

convert -verbose -gravity center  label:foobar -rotate 90  centerfoobar90.gif'
convert -verbose -gravity center  label:foobar -rotate 90  centerfoobar90.gif
echo '

convert -verbose -gravity center  label:foobar -rotate 90 -extent 200x200  centerfoobar90200x200.gif'
convert -verbose -gravity center  label:foobar -rotate 90 -extent 200x200  centerfoobar90200x200.gif
echo '

convert -verbose -gravity center  label:foobar -rotate 90 -extent 200x800  centerfoobar90200x800.gif'
convert -verbose -gravity center  label:foobar -rotate 90 -extent 200x800  centerfoobar90200x800.gif
echo '

convert -verbose -gravity center  label:foobar -rotate 90 -extent 800x200  centerfoobar90800x200.gif'
convert -verbose -gravity center  label:foobar -rotate 90 -extent 800x200  centerfoobar90800x200.gif
echo '

convert -verbose -gravity center  label:foobar -rotate 270  centerfoobar270.gif'
convert -verbose -gravity center  label:foobar -rotate 270  centerfoobar270.gif
echo '

convert -verbose -gravity center  label:foobar -rotate 270 -extent 200x200  centerfoobar270200x200.gif'
convert -verbose -gravity center  label:foobar -rotate 270 -extent 200x200  centerfoobar270200x200.gif
echo '

convert -verbose -gravity center  label:foobar -rotate 270 -extent 200x800  centerfoobar270200x800.gif'
convert -verbose -gravity center  label:foobar -rotate 270 -extent 200x800  centerfoobar270200x800.gif
echo '

convert -verbose -gravity center  label:foobar -rotate 270 -extent 800x200  centerfoobar270800x200.gif'
convert -verbose -gravity center  label:foobar -rotate 270 -extent 800x200  centerfoobar270800x200.gif
echo '

convert -verbose -gravity center  label:barfoo  centerbarfoo.gif'
convert -verbose -gravity center  label:barfoo  centerbarfoo.gif
echo '

convert -verbose -gravity center  label:barfoo -extent 200x200  centerbarfoo200x200.gif'
convert -verbose -gravity center  label:barfoo -extent 200x200  centerbarfoo200x200.gif
echo '

convert -verbose -gravity center  label:barfoo -extent 200x800  centerbarfoo200x800.gif'
convert -verbose -gravity center  label:barfoo -extent 200x800  centerbarfoo200x800.gif
echo '

convert -verbose -gravity center  label:barfoo -extent 800x200  centerbarfoo800x200.gif'
convert -verbose -gravity center  label:barfoo -extent 800x200  centerbarfoo800x200.gif
echo '

convert -verbose -gravity center  label:barfoo -rotate 0  centerbarfoo0.gif'
convert -verbose -gravity center  label:barfoo -rotate 0  centerbarfoo0.gif
echo '

convert -verbose -gravity center  label:barfoo -rotate 0 -extent 200x200  centerbarfoo0200x200.gif'
convert -verbose -gravity center  label:barfoo -rotate 0 -extent 200x200  centerbarfoo0200x200.gif
echo '

convert -verbose -gravity center  label:barfoo -rotate 0 -extent 200x800  centerbarfoo0200x800.gif'
convert -verbose -gravity center  label:barfoo -rotate 0 -extent 200x800  centerbarfoo0200x800.gif
echo '

convert -verbose -gravity center  label:barfoo -rotate 0 -extent 800x200  centerbarfoo0800x200.gif'
convert -verbose -gravity center  label:barfoo -rotate 0 -extent 800x200  centerbarfoo0800x200.gif
echo '

convert -verbose -gravity center  label:barfoo -rotate 90  centerbarfoo90.gif'
convert -verbose -gravity center  label:barfoo -rotate 90  centerbarfoo90.gif
echo '

convert -verbose -gravity center  label:barfoo -rotate 90 -extent 200x200  centerbarfoo90200x200.gif'
convert -verbose -gravity center  label:barfoo -rotate 90 -extent 200x200  centerbarfoo90200x200.gif
echo '

convert -verbose -gravity center  label:barfoo -rotate 90 -extent 200x800  centerbarfoo90200x800.gif'
convert -verbose -gravity center  label:barfoo -rotate 90 -extent 200x800  centerbarfoo90200x800.gif
echo '

convert -verbose -gravity center  label:barfoo -rotate 90 -extent 800x200  centerbarfoo90800x200.gif'
convert -verbose -gravity center  label:barfoo -rotate 90 -extent 800x200  centerbarfoo90800x200.gif
echo '

convert -verbose -gravity center  label:barfoo -rotate 270  centerbarfoo270.gif'
convert -verbose -gravity center  label:barfoo -rotate 270  centerbarfoo270.gif
echo '

convert -verbose -gravity center  label:barfoo -rotate 270 -extent 200x200  centerbarfoo270200x200.gif'
convert -verbose -gravity center  label:barfoo -rotate 270 -extent 200x200  centerbarfoo270200x200.gif
echo '

convert -verbose -gravity center  label:barfoo -rotate 270 -extent 200x800  centerbarfoo270200x800.gif'
convert -verbose -gravity center  label:barfoo -rotate 270 -extent 200x800  centerbarfoo270200x800.gif
echo '

convert -verbose -gravity center  label:barfoo -rotate 270 -extent 800x200  centerbarfoo270800x200.gif'
convert -verbose -gravity center  label:barfoo -rotate 270 -extent 800x200  centerbarfoo270800x200.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar  centerArialfoobar.gif'
convert -verbose -gravity center -font Arial  label:foobar  centerArialfoobar.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -extent 200x200  centerArialfoobar200x200.gif'
convert -verbose -gravity center -font Arial  label:foobar -extent 200x200  centerArialfoobar200x200.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -extent 200x800  centerArialfoobar200x800.gif'
convert -verbose -gravity center -font Arial  label:foobar -extent 200x800  centerArialfoobar200x800.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -extent 800x200  centerArialfoobar800x200.gif'
convert -verbose -gravity center -font Arial  label:foobar -extent 800x200  centerArialfoobar800x200.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -rotate 0  centerArialfoobar0.gif'
convert -verbose -gravity center -font Arial  label:foobar -rotate 0  centerArialfoobar0.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -rotate 0 -extent 200x200  centerArialfoobar0200x200.gif'
convert -verbose -gravity center -font Arial  label:foobar -rotate 0 -extent 200x200  centerArialfoobar0200x200.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -rotate 0 -extent 200x800  centerArialfoobar0200x800.gif'
convert -verbose -gravity center -font Arial  label:foobar -rotate 0 -extent 200x800  centerArialfoobar0200x800.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -rotate 0 -extent 800x200  centerArialfoobar0800x200.gif'
convert -verbose -gravity center -font Arial  label:foobar -rotate 0 -extent 800x200  centerArialfoobar0800x200.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -rotate 90  centerArialfoobar90.gif'
convert -verbose -gravity center -font Arial  label:foobar -rotate 90  centerArialfoobar90.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -rotate 90 -extent 200x200  centerArialfoobar90200x200.gif'
convert -verbose -gravity center -font Arial  label:foobar -rotate 90 -extent 200x200  centerArialfoobar90200x200.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -rotate 90 -extent 200x800  centerArialfoobar90200x800.gif'
convert -verbose -gravity center -font Arial  label:foobar -rotate 90 -extent 200x800  centerArialfoobar90200x800.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -rotate 90 -extent 800x200  centerArialfoobar90800x200.gif'
convert -verbose -gravity center -font Arial  label:foobar -rotate 90 -extent 800x200  centerArialfoobar90800x200.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -rotate 270  centerArialfoobar270.gif'
convert -verbose -gravity center -font Arial  label:foobar -rotate 270  centerArialfoobar270.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -rotate 270 -extent 200x200  centerArialfoobar270200x200.gif'
convert -verbose -gravity center -font Arial  label:foobar -rotate 270 -extent 200x200  centerArialfoobar270200x200.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -rotate 270 -extent 200x800  centerArialfoobar270200x800.gif'
convert -verbose -gravity center -font Arial  label:foobar -rotate 270 -extent 200x800  centerArialfoobar270200x800.gif
echo '

convert -verbose -gravity center -font Arial  label:foobar -rotate 270 -extent 800x200  centerArialfoobar270800x200.gif'
convert -verbose -gravity center -font Arial  label:foobar -rotate 270 -extent 800x200  centerArialfoobar270800x200.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo  centerArialbarfoo.gif'
convert -verbose -gravity center -font Arial  label:barfoo  centerArialbarfoo.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -extent 200x200  centerArialbarfoo200x200.gif'
convert -verbose -gravity center -font Arial  label:barfoo -extent 200x200  centerArialbarfoo200x200.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -extent 200x800  centerArialbarfoo200x800.gif'
convert -verbose -gravity center -font Arial  label:barfoo -extent 200x800  centerArialbarfoo200x800.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -extent 800x200  centerArialbarfoo800x200.gif'
convert -verbose -gravity center -font Arial  label:barfoo -extent 800x200  centerArialbarfoo800x200.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -rotate 0  centerArialbarfoo0.gif'
convert -verbose -gravity center -font Arial  label:barfoo -rotate 0  centerArialbarfoo0.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -rotate 0 -extent 200x200  centerArialbarfoo0200x200.gif'
convert -verbose -gravity center -font Arial  label:barfoo -rotate 0 -extent 200x200  centerArialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -rotate 0 -extent 200x800  centerArialbarfoo0200x800.gif'
convert -verbose -gravity center -font Arial  label:barfoo -rotate 0 -extent 200x800  centerArialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -rotate 0 -extent 800x200  centerArialbarfoo0800x200.gif'
convert -verbose -gravity center -font Arial  label:barfoo -rotate 0 -extent 800x200  centerArialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -rotate 90  centerArialbarfoo90.gif'
convert -verbose -gravity center -font Arial  label:barfoo -rotate 90  centerArialbarfoo90.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -rotate 90 -extent 200x200  centerArialbarfoo90200x200.gif'
convert -verbose -gravity center -font Arial  label:barfoo -rotate 90 -extent 200x200  centerArialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -rotate 90 -extent 200x800  centerArialbarfoo90200x800.gif'
convert -verbose -gravity center -font Arial  label:barfoo -rotate 90 -extent 200x800  centerArialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -rotate 90 -extent 800x200  centerArialbarfoo90800x200.gif'
convert -verbose -gravity center -font Arial  label:barfoo -rotate 90 -extent 800x200  centerArialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -rotate 270  centerArialbarfoo270.gif'
convert -verbose -gravity center -font Arial  label:barfoo -rotate 270  centerArialbarfoo270.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -rotate 270 -extent 200x200  centerArialbarfoo270200x200.gif'
convert -verbose -gravity center -font Arial  label:barfoo -rotate 270 -extent 200x200  centerArialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -rotate 270 -extent 200x800  centerArialbarfoo270200x800.gif'
convert -verbose -gravity center -font Arial  label:barfoo -rotate 270 -extent 200x800  centerArialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -font Arial  label:barfoo -rotate 270 -extent 800x200  centerArialbarfoo270800x200.gif'
convert -verbose -gravity center -font Arial  label:barfoo -rotate 270 -extent 800x200  centerArialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar  center8foobar.gif'
convert -verbose -gravity center -pointsize 8  label:foobar  center8foobar.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -extent 200x200  center8foobar200x200.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -extent 200x200  center8foobar200x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -extent 200x800  center8foobar200x800.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -extent 200x800  center8foobar200x800.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -extent 800x200  center8foobar800x200.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -extent 800x200  center8foobar800x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -rotate 0  center8foobar0.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -rotate 0  center8foobar0.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -rotate 0 -extent 200x200  center8foobar0200x200.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -rotate 0 -extent 200x200  center8foobar0200x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -rotate 0 -extent 200x800  center8foobar0200x800.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -rotate 0 -extent 200x800  center8foobar0200x800.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -rotate 0 -extent 800x200  center8foobar0800x200.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -rotate 0 -extent 800x200  center8foobar0800x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -rotate 90  center8foobar90.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -rotate 90  center8foobar90.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -rotate 90 -extent 200x200  center8foobar90200x200.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -rotate 90 -extent 200x200  center8foobar90200x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -rotate 90 -extent 200x800  center8foobar90200x800.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -rotate 90 -extent 200x800  center8foobar90200x800.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -rotate 90 -extent 800x200  center8foobar90800x200.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -rotate 90 -extent 800x200  center8foobar90800x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -rotate 270  center8foobar270.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -rotate 270  center8foobar270.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -rotate 270 -extent 200x200  center8foobar270200x200.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -rotate 270 -extent 200x200  center8foobar270200x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -rotate 270 -extent 200x800  center8foobar270200x800.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -rotate 270 -extent 200x800  center8foobar270200x800.gif
echo '

convert -verbose -gravity center -pointsize 8  label:foobar -rotate 270 -extent 800x200  center8foobar270800x200.gif'
convert -verbose -gravity center -pointsize 8  label:foobar -rotate 270 -extent 800x200  center8foobar270800x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo  center8barfoo.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo  center8barfoo.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -extent 200x200  center8barfoo200x200.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -extent 200x200  center8barfoo200x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -extent 200x800  center8barfoo200x800.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -extent 200x800  center8barfoo200x800.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -extent 800x200  center8barfoo800x200.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -extent 800x200  center8barfoo800x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 0  center8barfoo0.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 0  center8barfoo0.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 0 -extent 200x200  center8barfoo0200x200.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 0 -extent 200x200  center8barfoo0200x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 0 -extent 200x800  center8barfoo0200x800.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 0 -extent 200x800  center8barfoo0200x800.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 0 -extent 800x200  center8barfoo0800x200.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 0 -extent 800x200  center8barfoo0800x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 90  center8barfoo90.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 90  center8barfoo90.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 90 -extent 200x200  center8barfoo90200x200.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 90 -extent 200x200  center8barfoo90200x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 90 -extent 200x800  center8barfoo90200x800.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 90 -extent 200x800  center8barfoo90200x800.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 90 -extent 800x200  center8barfoo90800x200.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 90 -extent 800x200  center8barfoo90800x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 270  center8barfoo270.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 270  center8barfoo270.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 270 -extent 200x200  center8barfoo270200x200.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 270 -extent 200x200  center8barfoo270200x200.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 270 -extent 200x800  center8barfoo270200x800.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 270 -extent 200x800  center8barfoo270200x800.gif
echo '

convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 270 -extent 800x200  center8barfoo270800x200.gif'
convert -verbose -gravity center -pointsize 8  label:barfoo -rotate 270 -extent 800x200  center8barfoo270800x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar  center8Arialfoobar.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar  center8Arialfoobar.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -extent 200x200  center8Arialfoobar200x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -extent 200x200  center8Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -extent 200x800  center8Arialfoobar200x800.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -extent 200x800  center8Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -extent 800x200  center8Arialfoobar800x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -extent 800x200  center8Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 0  center8Arialfoobar0.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 0  center8Arialfoobar0.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  center8Arialfoobar0200x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  center8Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  center8Arialfoobar0200x800.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  center8Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  center8Arialfoobar0800x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  center8Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 90  center8Arialfoobar90.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 90  center8Arialfoobar90.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  center8Arialfoobar90200x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  center8Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  center8Arialfoobar90200x800.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  center8Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  center8Arialfoobar90800x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  center8Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 270  center8Arialfoobar270.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 270  center8Arialfoobar270.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  center8Arialfoobar270200x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  center8Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  center8Arialfoobar270200x800.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  center8Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  center8Arialfoobar270800x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  center8Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo  center8Arialbarfoo.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo  center8Arialbarfoo.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -extent 200x200  center8Arialbarfoo200x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -extent 200x200  center8Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -extent 200x800  center8Arialbarfoo200x800.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -extent 200x800  center8Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -extent 800x200  center8Arialbarfoo800x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -extent 800x200  center8Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 0  center8Arialbarfoo0.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 0  center8Arialbarfoo0.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  center8Arialbarfoo0200x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  center8Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  center8Arialbarfoo0200x800.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  center8Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  center8Arialbarfoo0800x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  center8Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 90  center8Arialbarfoo90.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 90  center8Arialbarfoo90.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  center8Arialbarfoo90200x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  center8Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  center8Arialbarfoo90200x800.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  center8Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  center8Arialbarfoo90800x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  center8Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 270  center8Arialbarfoo270.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 270  center8Arialbarfoo270.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  center8Arialbarfoo270200x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  center8Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  center8Arialbarfoo270200x800.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  center8Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  center8Arialbarfoo270800x200.gif'
convert -verbose -gravity center -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  center8Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar  center10foobar.gif'
convert -verbose -gravity center -pointsize 10  label:foobar  center10foobar.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -extent 200x200  center10foobar200x200.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -extent 200x200  center10foobar200x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -extent 200x800  center10foobar200x800.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -extent 200x800  center10foobar200x800.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -extent 800x200  center10foobar800x200.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -extent 800x200  center10foobar800x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -rotate 0  center10foobar0.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -rotate 0  center10foobar0.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -rotate 0 -extent 200x200  center10foobar0200x200.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -rotate 0 -extent 200x200  center10foobar0200x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -rotate 0 -extent 200x800  center10foobar0200x800.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -rotate 0 -extent 200x800  center10foobar0200x800.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -rotate 0 -extent 800x200  center10foobar0800x200.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -rotate 0 -extent 800x200  center10foobar0800x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -rotate 90  center10foobar90.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -rotate 90  center10foobar90.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -rotate 90 -extent 200x200  center10foobar90200x200.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -rotate 90 -extent 200x200  center10foobar90200x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -rotate 90 -extent 200x800  center10foobar90200x800.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -rotate 90 -extent 200x800  center10foobar90200x800.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -rotate 90 -extent 800x200  center10foobar90800x200.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -rotate 90 -extent 800x200  center10foobar90800x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -rotate 270  center10foobar270.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -rotate 270  center10foobar270.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -rotate 270 -extent 200x200  center10foobar270200x200.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -rotate 270 -extent 200x200  center10foobar270200x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -rotate 270 -extent 200x800  center10foobar270200x800.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -rotate 270 -extent 200x800  center10foobar270200x800.gif
echo '

convert -verbose -gravity center -pointsize 10  label:foobar -rotate 270 -extent 800x200  center10foobar270800x200.gif'
convert -verbose -gravity center -pointsize 10  label:foobar -rotate 270 -extent 800x200  center10foobar270800x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo  center10barfoo.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo  center10barfoo.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -extent 200x200  center10barfoo200x200.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -extent 200x200  center10barfoo200x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -extent 200x800  center10barfoo200x800.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -extent 200x800  center10barfoo200x800.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -extent 800x200  center10barfoo800x200.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -extent 800x200  center10barfoo800x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 0  center10barfoo0.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 0  center10barfoo0.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 0 -extent 200x200  center10barfoo0200x200.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 0 -extent 200x200  center10barfoo0200x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 0 -extent 200x800  center10barfoo0200x800.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 0 -extent 200x800  center10barfoo0200x800.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 0 -extent 800x200  center10barfoo0800x200.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 0 -extent 800x200  center10barfoo0800x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 90  center10barfoo90.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 90  center10barfoo90.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 90 -extent 200x200  center10barfoo90200x200.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 90 -extent 200x200  center10barfoo90200x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 90 -extent 200x800  center10barfoo90200x800.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 90 -extent 200x800  center10barfoo90200x800.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 90 -extent 800x200  center10barfoo90800x200.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 90 -extent 800x200  center10barfoo90800x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 270  center10barfoo270.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 270  center10barfoo270.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 270 -extent 200x200  center10barfoo270200x200.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 270 -extent 200x200  center10barfoo270200x200.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 270 -extent 200x800  center10barfoo270200x800.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 270 -extent 200x800  center10barfoo270200x800.gif
echo '

convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 270 -extent 800x200  center10barfoo270800x200.gif'
convert -verbose -gravity center -pointsize 10  label:barfoo -rotate 270 -extent 800x200  center10barfoo270800x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar  center10Arialfoobar.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar  center10Arialfoobar.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -extent 200x200  center10Arialfoobar200x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -extent 200x200  center10Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -extent 200x800  center10Arialfoobar200x800.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -extent 200x800  center10Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -extent 800x200  center10Arialfoobar800x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -extent 800x200  center10Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 0  center10Arialfoobar0.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 0  center10Arialfoobar0.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  center10Arialfoobar0200x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  center10Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  center10Arialfoobar0200x800.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  center10Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  center10Arialfoobar0800x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  center10Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 90  center10Arialfoobar90.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 90  center10Arialfoobar90.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  center10Arialfoobar90200x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  center10Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  center10Arialfoobar90200x800.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  center10Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  center10Arialfoobar90800x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  center10Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 270  center10Arialfoobar270.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 270  center10Arialfoobar270.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  center10Arialfoobar270200x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  center10Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  center10Arialfoobar270200x800.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  center10Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  center10Arialfoobar270800x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  center10Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo  center10Arialbarfoo.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo  center10Arialbarfoo.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -extent 200x200  center10Arialbarfoo200x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -extent 200x200  center10Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -extent 200x800  center10Arialbarfoo200x800.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -extent 200x800  center10Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -extent 800x200  center10Arialbarfoo800x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -extent 800x200  center10Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 0  center10Arialbarfoo0.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 0  center10Arialbarfoo0.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  center10Arialbarfoo0200x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  center10Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  center10Arialbarfoo0200x800.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  center10Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  center10Arialbarfoo0800x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  center10Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 90  center10Arialbarfoo90.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 90  center10Arialbarfoo90.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  center10Arialbarfoo90200x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  center10Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  center10Arialbarfoo90200x800.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  center10Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  center10Arialbarfoo90800x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  center10Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 270  center10Arialbarfoo270.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 270  center10Arialbarfoo270.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  center10Arialbarfoo270200x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  center10Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  center10Arialbarfoo270200x800.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  center10Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  center10Arialbarfoo270800x200.gif'
convert -verbose -gravity center -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  center10Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar  center12foobar.gif'
convert -verbose -gravity center -pointsize 12  label:foobar  center12foobar.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -extent 200x200  center12foobar200x200.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -extent 200x200  center12foobar200x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -extent 200x800  center12foobar200x800.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -extent 200x800  center12foobar200x800.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -extent 800x200  center12foobar800x200.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -extent 800x200  center12foobar800x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -rotate 0  center12foobar0.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -rotate 0  center12foobar0.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -rotate 0 -extent 200x200  center12foobar0200x200.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -rotate 0 -extent 200x200  center12foobar0200x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -rotate 0 -extent 200x800  center12foobar0200x800.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -rotate 0 -extent 200x800  center12foobar0200x800.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -rotate 0 -extent 800x200  center12foobar0800x200.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -rotate 0 -extent 800x200  center12foobar0800x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -rotate 90  center12foobar90.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -rotate 90  center12foobar90.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -rotate 90 -extent 200x200  center12foobar90200x200.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -rotate 90 -extent 200x200  center12foobar90200x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -rotate 90 -extent 200x800  center12foobar90200x800.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -rotate 90 -extent 200x800  center12foobar90200x800.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -rotate 90 -extent 800x200  center12foobar90800x200.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -rotate 90 -extent 800x200  center12foobar90800x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -rotate 270  center12foobar270.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -rotate 270  center12foobar270.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -rotate 270 -extent 200x200  center12foobar270200x200.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -rotate 270 -extent 200x200  center12foobar270200x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -rotate 270 -extent 200x800  center12foobar270200x800.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -rotate 270 -extent 200x800  center12foobar270200x800.gif
echo '

convert -verbose -gravity center -pointsize 12  label:foobar -rotate 270 -extent 800x200  center12foobar270800x200.gif'
convert -verbose -gravity center -pointsize 12  label:foobar -rotate 270 -extent 800x200  center12foobar270800x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo  center12barfoo.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo  center12barfoo.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -extent 200x200  center12barfoo200x200.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -extent 200x200  center12barfoo200x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -extent 200x800  center12barfoo200x800.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -extent 200x800  center12barfoo200x800.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -extent 800x200  center12barfoo800x200.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -extent 800x200  center12barfoo800x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 0  center12barfoo0.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 0  center12barfoo0.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 0 -extent 200x200  center12barfoo0200x200.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 0 -extent 200x200  center12barfoo0200x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 0 -extent 200x800  center12barfoo0200x800.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 0 -extent 200x800  center12barfoo0200x800.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 0 -extent 800x200  center12barfoo0800x200.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 0 -extent 800x200  center12barfoo0800x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 90  center12barfoo90.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 90  center12barfoo90.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 90 -extent 200x200  center12barfoo90200x200.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 90 -extent 200x200  center12barfoo90200x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 90 -extent 200x800  center12barfoo90200x800.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 90 -extent 200x800  center12barfoo90200x800.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 90 -extent 800x200  center12barfoo90800x200.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 90 -extent 800x200  center12barfoo90800x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 270  center12barfoo270.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 270  center12barfoo270.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 270 -extent 200x200  center12barfoo270200x200.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 270 -extent 200x200  center12barfoo270200x200.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 270 -extent 200x800  center12barfoo270200x800.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 270 -extent 200x800  center12barfoo270200x800.gif
echo '

convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 270 -extent 800x200  center12barfoo270800x200.gif'
convert -verbose -gravity center -pointsize 12  label:barfoo -rotate 270 -extent 800x200  center12barfoo270800x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar  center12Arialfoobar.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar  center12Arialfoobar.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -extent 200x200  center12Arialfoobar200x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -extent 200x200  center12Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -extent 200x800  center12Arialfoobar200x800.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -extent 200x800  center12Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -extent 800x200  center12Arialfoobar800x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -extent 800x200  center12Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 0  center12Arialfoobar0.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 0  center12Arialfoobar0.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  center12Arialfoobar0200x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  center12Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  center12Arialfoobar0200x800.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  center12Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  center12Arialfoobar0800x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  center12Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 90  center12Arialfoobar90.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 90  center12Arialfoobar90.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  center12Arialfoobar90200x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  center12Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  center12Arialfoobar90200x800.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  center12Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  center12Arialfoobar90800x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  center12Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 270  center12Arialfoobar270.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 270  center12Arialfoobar270.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  center12Arialfoobar270200x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  center12Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  center12Arialfoobar270200x800.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  center12Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  center12Arialfoobar270800x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  center12Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo  center12Arialbarfoo.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo  center12Arialbarfoo.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -extent 200x200  center12Arialbarfoo200x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -extent 200x200  center12Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -extent 200x800  center12Arialbarfoo200x800.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -extent 200x800  center12Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -extent 800x200  center12Arialbarfoo800x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -extent 800x200  center12Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 0  center12Arialbarfoo0.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 0  center12Arialbarfoo0.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  center12Arialbarfoo0200x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  center12Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  center12Arialbarfoo0200x800.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  center12Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  center12Arialbarfoo0800x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  center12Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 90  center12Arialbarfoo90.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 90  center12Arialbarfoo90.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  center12Arialbarfoo90200x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  center12Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  center12Arialbarfoo90200x800.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  center12Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  center12Arialbarfoo90800x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  center12Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 270  center12Arialbarfoo270.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 270  center12Arialbarfoo270.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  center12Arialbarfoo270200x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  center12Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  center12Arialbarfoo270200x800.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  center12Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  center12Arialbarfoo270800x200.gif'
convert -verbose -gravity center -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  center12Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar  center18foobar.gif'
convert -verbose -gravity center -pointsize 18  label:foobar  center18foobar.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -extent 200x200  center18foobar200x200.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -extent 200x200  center18foobar200x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -extent 200x800  center18foobar200x800.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -extent 200x800  center18foobar200x800.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -extent 800x200  center18foobar800x200.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -extent 800x200  center18foobar800x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -rotate 0  center18foobar0.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -rotate 0  center18foobar0.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -rotate 0 -extent 200x200  center18foobar0200x200.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -rotate 0 -extent 200x200  center18foobar0200x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -rotate 0 -extent 200x800  center18foobar0200x800.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -rotate 0 -extent 200x800  center18foobar0200x800.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -rotate 0 -extent 800x200  center18foobar0800x200.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -rotate 0 -extent 800x200  center18foobar0800x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -rotate 90  center18foobar90.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -rotate 90  center18foobar90.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -rotate 90 -extent 200x200  center18foobar90200x200.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -rotate 90 -extent 200x200  center18foobar90200x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -rotate 90 -extent 200x800  center18foobar90200x800.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -rotate 90 -extent 200x800  center18foobar90200x800.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -rotate 90 -extent 800x200  center18foobar90800x200.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -rotate 90 -extent 800x200  center18foobar90800x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -rotate 270  center18foobar270.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -rotate 270  center18foobar270.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -rotate 270 -extent 200x200  center18foobar270200x200.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -rotate 270 -extent 200x200  center18foobar270200x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -rotate 270 -extent 200x800  center18foobar270200x800.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -rotate 270 -extent 200x800  center18foobar270200x800.gif
echo '

convert -verbose -gravity center -pointsize 18  label:foobar -rotate 270 -extent 800x200  center18foobar270800x200.gif'
convert -verbose -gravity center -pointsize 18  label:foobar -rotate 270 -extent 800x200  center18foobar270800x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo  center18barfoo.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo  center18barfoo.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -extent 200x200  center18barfoo200x200.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -extent 200x200  center18barfoo200x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -extent 200x800  center18barfoo200x800.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -extent 200x800  center18barfoo200x800.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -extent 800x200  center18barfoo800x200.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -extent 800x200  center18barfoo800x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 0  center18barfoo0.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 0  center18barfoo0.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 0 -extent 200x200  center18barfoo0200x200.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 0 -extent 200x200  center18barfoo0200x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 0 -extent 200x800  center18barfoo0200x800.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 0 -extent 200x800  center18barfoo0200x800.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 0 -extent 800x200  center18barfoo0800x200.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 0 -extent 800x200  center18barfoo0800x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 90  center18barfoo90.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 90  center18barfoo90.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 90 -extent 200x200  center18barfoo90200x200.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 90 -extent 200x200  center18barfoo90200x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 90 -extent 200x800  center18barfoo90200x800.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 90 -extent 200x800  center18barfoo90200x800.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 90 -extent 800x200  center18barfoo90800x200.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 90 -extent 800x200  center18barfoo90800x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 270  center18barfoo270.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 270  center18barfoo270.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 270 -extent 200x200  center18barfoo270200x200.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 270 -extent 200x200  center18barfoo270200x200.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 270 -extent 200x800  center18barfoo270200x800.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 270 -extent 200x800  center18barfoo270200x800.gif
echo '

convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 270 -extent 800x200  center18barfoo270800x200.gif'
convert -verbose -gravity center -pointsize 18  label:barfoo -rotate 270 -extent 800x200  center18barfoo270800x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar  center18Arialfoobar.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar  center18Arialfoobar.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -extent 200x200  center18Arialfoobar200x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -extent 200x200  center18Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -extent 200x800  center18Arialfoobar200x800.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -extent 200x800  center18Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -extent 800x200  center18Arialfoobar800x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -extent 800x200  center18Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 0  center18Arialfoobar0.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 0  center18Arialfoobar0.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  center18Arialfoobar0200x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  center18Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  center18Arialfoobar0200x800.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  center18Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  center18Arialfoobar0800x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  center18Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 90  center18Arialfoobar90.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 90  center18Arialfoobar90.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  center18Arialfoobar90200x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  center18Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  center18Arialfoobar90200x800.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  center18Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  center18Arialfoobar90800x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  center18Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 270  center18Arialfoobar270.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 270  center18Arialfoobar270.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  center18Arialfoobar270200x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  center18Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  center18Arialfoobar270200x800.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  center18Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  center18Arialfoobar270800x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  center18Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo  center18Arialbarfoo.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo  center18Arialbarfoo.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -extent 200x200  center18Arialbarfoo200x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -extent 200x200  center18Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -extent 200x800  center18Arialbarfoo200x800.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -extent 200x800  center18Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -extent 800x200  center18Arialbarfoo800x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -extent 800x200  center18Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 0  center18Arialbarfoo0.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 0  center18Arialbarfoo0.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  center18Arialbarfoo0200x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  center18Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  center18Arialbarfoo0200x800.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  center18Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  center18Arialbarfoo0800x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  center18Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 90  center18Arialbarfoo90.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 90  center18Arialbarfoo90.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  center18Arialbarfoo90200x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  center18Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  center18Arialbarfoo90200x800.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  center18Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  center18Arialbarfoo90800x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  center18Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 270  center18Arialbarfoo270.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 270  center18Arialbarfoo270.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  center18Arialbarfoo270200x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  center18Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  center18Arialbarfoo270200x800.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  center18Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  center18Arialbarfoo270800x200.gif'
convert -verbose -gravity center -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  center18Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar  center24foobar.gif'
convert -verbose -gravity center -pointsize 24  label:foobar  center24foobar.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -extent 200x200  center24foobar200x200.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -extent 200x200  center24foobar200x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -extent 200x800  center24foobar200x800.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -extent 200x800  center24foobar200x800.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -extent 800x200  center24foobar800x200.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -extent 800x200  center24foobar800x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -rotate 0  center24foobar0.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -rotate 0  center24foobar0.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -rotate 0 -extent 200x200  center24foobar0200x200.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -rotate 0 -extent 200x200  center24foobar0200x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -rotate 0 -extent 200x800  center24foobar0200x800.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -rotate 0 -extent 200x800  center24foobar0200x800.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -rotate 0 -extent 800x200  center24foobar0800x200.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -rotate 0 -extent 800x200  center24foobar0800x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -rotate 90  center24foobar90.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -rotate 90  center24foobar90.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -rotate 90 -extent 200x200  center24foobar90200x200.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -rotate 90 -extent 200x200  center24foobar90200x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -rotate 90 -extent 200x800  center24foobar90200x800.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -rotate 90 -extent 200x800  center24foobar90200x800.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -rotate 90 -extent 800x200  center24foobar90800x200.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -rotate 90 -extent 800x200  center24foobar90800x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -rotate 270  center24foobar270.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -rotate 270  center24foobar270.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -rotate 270 -extent 200x200  center24foobar270200x200.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -rotate 270 -extent 200x200  center24foobar270200x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -rotate 270 -extent 200x800  center24foobar270200x800.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -rotate 270 -extent 200x800  center24foobar270200x800.gif
echo '

convert -verbose -gravity center -pointsize 24  label:foobar -rotate 270 -extent 800x200  center24foobar270800x200.gif'
convert -verbose -gravity center -pointsize 24  label:foobar -rotate 270 -extent 800x200  center24foobar270800x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo  center24barfoo.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo  center24barfoo.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -extent 200x200  center24barfoo200x200.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -extent 200x200  center24barfoo200x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -extent 200x800  center24barfoo200x800.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -extent 200x800  center24barfoo200x800.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -extent 800x200  center24barfoo800x200.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -extent 800x200  center24barfoo800x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 0  center24barfoo0.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 0  center24barfoo0.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 0 -extent 200x200  center24barfoo0200x200.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 0 -extent 200x200  center24barfoo0200x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 0 -extent 200x800  center24barfoo0200x800.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 0 -extent 200x800  center24barfoo0200x800.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 0 -extent 800x200  center24barfoo0800x200.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 0 -extent 800x200  center24barfoo0800x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 90  center24barfoo90.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 90  center24barfoo90.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 90 -extent 200x200  center24barfoo90200x200.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 90 -extent 200x200  center24barfoo90200x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 90 -extent 200x800  center24barfoo90200x800.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 90 -extent 200x800  center24barfoo90200x800.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 90 -extent 800x200  center24barfoo90800x200.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 90 -extent 800x200  center24barfoo90800x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 270  center24barfoo270.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 270  center24barfoo270.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 270 -extent 200x200  center24barfoo270200x200.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 270 -extent 200x200  center24barfoo270200x200.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 270 -extent 200x800  center24barfoo270200x800.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 270 -extent 200x800  center24barfoo270200x800.gif
echo '

convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 270 -extent 800x200  center24barfoo270800x200.gif'
convert -verbose -gravity center -pointsize 24  label:barfoo -rotate 270 -extent 800x200  center24barfoo270800x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar  center24Arialfoobar.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar  center24Arialfoobar.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -extent 200x200  center24Arialfoobar200x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -extent 200x200  center24Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -extent 200x800  center24Arialfoobar200x800.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -extent 200x800  center24Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -extent 800x200  center24Arialfoobar800x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -extent 800x200  center24Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 0  center24Arialfoobar0.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 0  center24Arialfoobar0.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  center24Arialfoobar0200x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  center24Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  center24Arialfoobar0200x800.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  center24Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  center24Arialfoobar0800x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  center24Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 90  center24Arialfoobar90.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 90  center24Arialfoobar90.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  center24Arialfoobar90200x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  center24Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  center24Arialfoobar90200x800.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  center24Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  center24Arialfoobar90800x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  center24Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 270  center24Arialfoobar270.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 270  center24Arialfoobar270.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  center24Arialfoobar270200x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  center24Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  center24Arialfoobar270200x800.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  center24Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  center24Arialfoobar270800x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  center24Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo  center24Arialbarfoo.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo  center24Arialbarfoo.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -extent 200x200  center24Arialbarfoo200x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -extent 200x200  center24Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -extent 200x800  center24Arialbarfoo200x800.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -extent 200x800  center24Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -extent 800x200  center24Arialbarfoo800x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -extent 800x200  center24Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 0  center24Arialbarfoo0.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 0  center24Arialbarfoo0.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  center24Arialbarfoo0200x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  center24Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  center24Arialbarfoo0200x800.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  center24Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  center24Arialbarfoo0800x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  center24Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 90  center24Arialbarfoo90.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 90  center24Arialbarfoo90.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  center24Arialbarfoo90200x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  center24Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  center24Arialbarfoo90200x800.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  center24Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  center24Arialbarfoo90800x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  center24Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 270  center24Arialbarfoo270.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 270  center24Arialbarfoo270.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  center24Arialbarfoo270200x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  center24Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  center24Arialbarfoo270200x800.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  center24Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  center24Arialbarfoo270800x200.gif'
convert -verbose -gravity center -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  center24Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar  center48foobar.gif'
convert -verbose -gravity center -pointsize 48  label:foobar  center48foobar.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -extent 200x200  center48foobar200x200.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -extent 200x200  center48foobar200x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -extent 200x800  center48foobar200x800.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -extent 200x800  center48foobar200x800.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -extent 800x200  center48foobar800x200.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -extent 800x200  center48foobar800x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -rotate 0  center48foobar0.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -rotate 0  center48foobar0.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -rotate 0 -extent 200x200  center48foobar0200x200.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -rotate 0 -extent 200x200  center48foobar0200x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -rotate 0 -extent 200x800  center48foobar0200x800.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -rotate 0 -extent 200x800  center48foobar0200x800.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -rotate 0 -extent 800x200  center48foobar0800x200.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -rotate 0 -extent 800x200  center48foobar0800x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -rotate 90  center48foobar90.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -rotate 90  center48foobar90.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -rotate 90 -extent 200x200  center48foobar90200x200.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -rotate 90 -extent 200x200  center48foobar90200x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -rotate 90 -extent 200x800  center48foobar90200x800.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -rotate 90 -extent 200x800  center48foobar90200x800.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -rotate 90 -extent 800x200  center48foobar90800x200.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -rotate 90 -extent 800x200  center48foobar90800x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -rotate 270  center48foobar270.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -rotate 270  center48foobar270.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -rotate 270 -extent 200x200  center48foobar270200x200.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -rotate 270 -extent 200x200  center48foobar270200x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -rotate 270 -extent 200x800  center48foobar270200x800.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -rotate 270 -extent 200x800  center48foobar270200x800.gif
echo '

convert -verbose -gravity center -pointsize 48  label:foobar -rotate 270 -extent 800x200  center48foobar270800x200.gif'
convert -verbose -gravity center -pointsize 48  label:foobar -rotate 270 -extent 800x200  center48foobar270800x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo  center48barfoo.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo  center48barfoo.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -extent 200x200  center48barfoo200x200.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -extent 200x200  center48barfoo200x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -extent 200x800  center48barfoo200x800.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -extent 200x800  center48barfoo200x800.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -extent 800x200  center48barfoo800x200.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -extent 800x200  center48barfoo800x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 0  center48barfoo0.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 0  center48barfoo0.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 0 -extent 200x200  center48barfoo0200x200.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 0 -extent 200x200  center48barfoo0200x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 0 -extent 200x800  center48barfoo0200x800.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 0 -extent 200x800  center48barfoo0200x800.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 0 -extent 800x200  center48barfoo0800x200.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 0 -extent 800x200  center48barfoo0800x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 90  center48barfoo90.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 90  center48barfoo90.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 90 -extent 200x200  center48barfoo90200x200.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 90 -extent 200x200  center48barfoo90200x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 90 -extent 200x800  center48barfoo90200x800.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 90 -extent 200x800  center48barfoo90200x800.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 90 -extent 800x200  center48barfoo90800x200.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 90 -extent 800x200  center48barfoo90800x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 270  center48barfoo270.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 270  center48barfoo270.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 270 -extent 200x200  center48barfoo270200x200.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 270 -extent 200x200  center48barfoo270200x200.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 270 -extent 200x800  center48barfoo270200x800.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 270 -extent 200x800  center48barfoo270200x800.gif
echo '

convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 270 -extent 800x200  center48barfoo270800x200.gif'
convert -verbose -gravity center -pointsize 48  label:barfoo -rotate 270 -extent 800x200  center48barfoo270800x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar  center48Arialfoobar.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar  center48Arialfoobar.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -extent 200x200  center48Arialfoobar200x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -extent 200x200  center48Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -extent 200x800  center48Arialfoobar200x800.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -extent 200x800  center48Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -extent 800x200  center48Arialfoobar800x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -extent 800x200  center48Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 0  center48Arialfoobar0.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 0  center48Arialfoobar0.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  center48Arialfoobar0200x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  center48Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  center48Arialfoobar0200x800.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  center48Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  center48Arialfoobar0800x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  center48Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 90  center48Arialfoobar90.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 90  center48Arialfoobar90.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  center48Arialfoobar90200x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  center48Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  center48Arialfoobar90200x800.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  center48Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  center48Arialfoobar90800x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  center48Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 270  center48Arialfoobar270.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 270  center48Arialfoobar270.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  center48Arialfoobar270200x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  center48Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  center48Arialfoobar270200x800.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  center48Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  center48Arialfoobar270800x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  center48Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo  center48Arialbarfoo.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo  center48Arialbarfoo.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -extent 200x200  center48Arialbarfoo200x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -extent 200x200  center48Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -extent 200x800  center48Arialbarfoo200x800.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -extent 200x800  center48Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -extent 800x200  center48Arialbarfoo800x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -extent 800x200  center48Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 0  center48Arialbarfoo0.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 0  center48Arialbarfoo0.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  center48Arialbarfoo0200x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  center48Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  center48Arialbarfoo0200x800.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  center48Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  center48Arialbarfoo0800x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  center48Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 90  center48Arialbarfoo90.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 90  center48Arialbarfoo90.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  center48Arialbarfoo90200x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  center48Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  center48Arialbarfoo90200x800.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  center48Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  center48Arialbarfoo90800x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  center48Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 270  center48Arialbarfoo270.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 270  center48Arialbarfoo270.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  center48Arialbarfoo270200x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  center48Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  center48Arialbarfoo270200x800.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  center48Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  center48Arialbarfoo270800x200.gif'
convert -verbose -gravity center -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  center48Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar  centerd6d2d0foobar.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar  centerd6d2d0foobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -extent 200x200  centerd6d2d0foobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -extent 200x200  centerd6d2d0foobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -extent 200x800  centerd6d2d0foobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -extent 200x800  centerd6d2d0foobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -extent 800x200  centerd6d2d0foobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -extent 800x200  centerd6d2d0foobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 0  centerd6d2d0foobar0.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 0  centerd6d2d0foobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 0 -extent 200x200  centerd6d2d0foobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 0 -extent 200x200  centerd6d2d0foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 0 -extent 200x800  centerd6d2d0foobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 0 -extent 200x800  centerd6d2d0foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 0 -extent 800x200  centerd6d2d0foobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 0 -extent 800x200  centerd6d2d0foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 90  centerd6d2d0foobar90.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 90  centerd6d2d0foobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 90 -extent 200x200  centerd6d2d0foobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 90 -extent 200x200  centerd6d2d0foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 90 -extent 200x800  centerd6d2d0foobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 90 -extent 200x800  centerd6d2d0foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 90 -extent 800x200  centerd6d2d0foobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 90 -extent 800x200  centerd6d2d0foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 270  centerd6d2d0foobar270.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 270  centerd6d2d0foobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 270 -extent 200x200  centerd6d2d0foobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 270 -extent 200x200  centerd6d2d0foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 270 -extent 200x800  centerd6d2d0foobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 270 -extent 200x800  centerd6d2d0foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 270 -extent 800x200  centerd6d2d0foobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:foobar -rotate 270 -extent 800x200  centerd6d2d0foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo  centerd6d2d0barfoo.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo  centerd6d2d0barfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -extent 200x200  centerd6d2d0barfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -extent 200x200  centerd6d2d0barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -extent 200x800  centerd6d2d0barfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -extent 200x800  centerd6d2d0barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -extent 800x200  centerd6d2d0barfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -extent 800x200  centerd6d2d0barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 0  centerd6d2d0barfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 0  centerd6d2d0barfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 0 -extent 200x200  centerd6d2d0barfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 0 -extent 200x200  centerd6d2d0barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 0 -extent 200x800  centerd6d2d0barfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 0 -extent 200x800  centerd6d2d0barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 0 -extent 800x200  centerd6d2d0barfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 0 -extent 800x200  centerd6d2d0barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 90  centerd6d2d0barfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 90  centerd6d2d0barfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 90 -extent 200x200  centerd6d2d0barfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 90 -extent 200x200  centerd6d2d0barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 90 -extent 200x800  centerd6d2d0barfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 90 -extent 200x800  centerd6d2d0barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 90 -extent 800x200  centerd6d2d0barfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 90 -extent 800x200  centerd6d2d0barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 270  centerd6d2d0barfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 270  centerd6d2d0barfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 270 -extent 200x200  centerd6d2d0barfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 270 -extent 200x200  centerd6d2d0barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 270 -extent 200x800  centerd6d2d0barfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 270 -extent 200x800  centerd6d2d0barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 270 -extent 800x200  centerd6d2d0barfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0'  label:barfoo -rotate 270 -extent 800x200  centerd6d2d0barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar  centerd6d2d0Arialfoobar.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar  centerd6d2d0Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -extent 200x200  centerd6d2d0Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -extent 200x200  centerd6d2d0Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -extent 200x800  centerd6d2d0Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -extent 200x800  centerd6d2d0Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -extent 800x200  centerd6d2d0Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -extent 800x200  centerd6d2d0Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 0  centerd6d2d0Arialfoobar0.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 0  centerd6d2d0Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d0Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d0Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d0Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d0Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d0Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d0Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 90  centerd6d2d0Arialfoobar90.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 90  centerd6d2d0Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d0Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d0Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d0Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d0Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d0Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d0Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 270  centerd6d2d0Arialfoobar270.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 270  centerd6d2d0Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d0Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d0Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d0Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d0Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d0Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d0Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo  centerd6d2d0Arialbarfoo.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo  centerd6d2d0Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -extent 200x200  centerd6d2d0Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -extent 200x200  centerd6d2d0Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -extent 200x800  centerd6d2d0Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -extent 200x800  centerd6d2d0Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -extent 800x200  centerd6d2d0Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -extent 800x200  centerd6d2d0Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 0  centerd6d2d0Arialbarfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 0  centerd6d2d0Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d0Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d0Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d0Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d0Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d0Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d0Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 90  centerd6d2d0Arialbarfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 90  centerd6d2d0Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d0Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d0Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d0Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d0Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d0Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d0Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 270  centerd6d2d0Arialbarfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 270  centerd6d2d0Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d0Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d0Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d0Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d0Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d0Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d0Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar  centerd6d2d08foobar.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar  centerd6d2d08foobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -extent 200x200  centerd6d2d08foobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -extent 200x200  centerd6d2d08foobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -extent 200x800  centerd6d2d08foobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -extent 200x800  centerd6d2d08foobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -extent 800x200  centerd6d2d08foobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -extent 800x200  centerd6d2d08foobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0  centerd6d2d08foobar0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0  centerd6d2d08foobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0 -extent 200x200  centerd6d2d08foobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0 -extent 200x200  centerd6d2d08foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0 -extent 200x800  centerd6d2d08foobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0 -extent 200x800  centerd6d2d08foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0 -extent 800x200  centerd6d2d08foobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 0 -extent 800x200  centerd6d2d08foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90  centerd6d2d08foobar90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90  centerd6d2d08foobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90 -extent 200x200  centerd6d2d08foobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90 -extent 200x200  centerd6d2d08foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90 -extent 200x800  centerd6d2d08foobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90 -extent 200x800  centerd6d2d08foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90 -extent 800x200  centerd6d2d08foobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 90 -extent 800x200  centerd6d2d08foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270  centerd6d2d08foobar270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270  centerd6d2d08foobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270 -extent 200x200  centerd6d2d08foobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270 -extent 200x200  centerd6d2d08foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270 -extent 200x800  centerd6d2d08foobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270 -extent 200x800  centerd6d2d08foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270 -extent 800x200  centerd6d2d08foobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:foobar -rotate 270 -extent 800x200  centerd6d2d08foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo  centerd6d2d08barfoo.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo  centerd6d2d08barfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -extent 200x200  centerd6d2d08barfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -extent 200x200  centerd6d2d08barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -extent 200x800  centerd6d2d08barfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -extent 200x800  centerd6d2d08barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -extent 800x200  centerd6d2d08barfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -extent 800x200  centerd6d2d08barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0  centerd6d2d08barfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0  centerd6d2d08barfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0 -extent 200x200  centerd6d2d08barfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0 -extent 200x200  centerd6d2d08barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0 -extent 200x800  centerd6d2d08barfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0 -extent 200x800  centerd6d2d08barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0 -extent 800x200  centerd6d2d08barfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 0 -extent 800x200  centerd6d2d08barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90  centerd6d2d08barfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90  centerd6d2d08barfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90 -extent 200x200  centerd6d2d08barfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90 -extent 200x200  centerd6d2d08barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90 -extent 200x800  centerd6d2d08barfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90 -extent 200x800  centerd6d2d08barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90 -extent 800x200  centerd6d2d08barfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 90 -extent 800x200  centerd6d2d08barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270  centerd6d2d08barfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270  centerd6d2d08barfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270 -extent 200x200  centerd6d2d08barfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270 -extent 200x200  centerd6d2d08barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270 -extent 200x800  centerd6d2d08barfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270 -extent 200x800  centerd6d2d08barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270 -extent 800x200  centerd6d2d08barfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8  label:barfoo -rotate 270 -extent 800x200  centerd6d2d08barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar  centerd6d2d08Arialfoobar.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar  centerd6d2d08Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -extent 200x200  centerd6d2d08Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -extent 200x200  centerd6d2d08Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -extent 200x800  centerd6d2d08Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -extent 200x800  centerd6d2d08Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -extent 800x200  centerd6d2d08Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -extent 800x200  centerd6d2d08Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0  centerd6d2d08Arialfoobar0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0  centerd6d2d08Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d08Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d08Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d08Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d08Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d08Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d08Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90  centerd6d2d08Arialfoobar90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90  centerd6d2d08Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d08Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d08Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d08Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d08Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d08Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d08Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270  centerd6d2d08Arialfoobar270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270  centerd6d2d08Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d08Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d08Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d08Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d08Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d08Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d08Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo  centerd6d2d08Arialbarfoo.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo  centerd6d2d08Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -extent 200x200  centerd6d2d08Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -extent 200x200  centerd6d2d08Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -extent 200x800  centerd6d2d08Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -extent 200x800  centerd6d2d08Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -extent 800x200  centerd6d2d08Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -extent 800x200  centerd6d2d08Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0  centerd6d2d08Arialbarfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0  centerd6d2d08Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d08Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d08Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d08Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d08Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d08Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d08Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90  centerd6d2d08Arialbarfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90  centerd6d2d08Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d08Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d08Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d08Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d08Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d08Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d08Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270  centerd6d2d08Arialbarfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270  centerd6d2d08Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d08Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d08Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d08Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d08Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d08Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d08Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar  centerd6d2d010foobar.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar  centerd6d2d010foobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -extent 200x200  centerd6d2d010foobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -extent 200x200  centerd6d2d010foobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -extent 200x800  centerd6d2d010foobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -extent 200x800  centerd6d2d010foobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -extent 800x200  centerd6d2d010foobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -extent 800x200  centerd6d2d010foobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0  centerd6d2d010foobar0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0  centerd6d2d010foobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0 -extent 200x200  centerd6d2d010foobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0 -extent 200x200  centerd6d2d010foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0 -extent 200x800  centerd6d2d010foobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0 -extent 200x800  centerd6d2d010foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0 -extent 800x200  centerd6d2d010foobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 0 -extent 800x200  centerd6d2d010foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90  centerd6d2d010foobar90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90  centerd6d2d010foobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90 -extent 200x200  centerd6d2d010foobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90 -extent 200x200  centerd6d2d010foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90 -extent 200x800  centerd6d2d010foobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90 -extent 200x800  centerd6d2d010foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90 -extent 800x200  centerd6d2d010foobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 90 -extent 800x200  centerd6d2d010foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270  centerd6d2d010foobar270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270  centerd6d2d010foobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270 -extent 200x200  centerd6d2d010foobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270 -extent 200x200  centerd6d2d010foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270 -extent 200x800  centerd6d2d010foobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270 -extent 200x800  centerd6d2d010foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270 -extent 800x200  centerd6d2d010foobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:foobar -rotate 270 -extent 800x200  centerd6d2d010foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo  centerd6d2d010barfoo.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo  centerd6d2d010barfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -extent 200x200  centerd6d2d010barfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -extent 200x200  centerd6d2d010barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -extent 200x800  centerd6d2d010barfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -extent 200x800  centerd6d2d010barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -extent 800x200  centerd6d2d010barfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -extent 800x200  centerd6d2d010barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0  centerd6d2d010barfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0  centerd6d2d010barfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0 -extent 200x200  centerd6d2d010barfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0 -extent 200x200  centerd6d2d010barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0 -extent 200x800  centerd6d2d010barfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0 -extent 200x800  centerd6d2d010barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0 -extent 800x200  centerd6d2d010barfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 0 -extent 800x200  centerd6d2d010barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90  centerd6d2d010barfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90  centerd6d2d010barfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90 -extent 200x200  centerd6d2d010barfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90 -extent 200x200  centerd6d2d010barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90 -extent 200x800  centerd6d2d010barfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90 -extent 200x800  centerd6d2d010barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90 -extent 800x200  centerd6d2d010barfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 90 -extent 800x200  centerd6d2d010barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270  centerd6d2d010barfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270  centerd6d2d010barfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270 -extent 200x200  centerd6d2d010barfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270 -extent 200x200  centerd6d2d010barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270 -extent 200x800  centerd6d2d010barfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270 -extent 200x800  centerd6d2d010barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270 -extent 800x200  centerd6d2d010barfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10  label:barfoo -rotate 270 -extent 800x200  centerd6d2d010barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar  centerd6d2d010Arialfoobar.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar  centerd6d2d010Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -extent 200x200  centerd6d2d010Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -extent 200x200  centerd6d2d010Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -extent 200x800  centerd6d2d010Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -extent 200x800  centerd6d2d010Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -extent 800x200  centerd6d2d010Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -extent 800x200  centerd6d2d010Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0  centerd6d2d010Arialfoobar0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0  centerd6d2d010Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d010Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d010Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d010Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d010Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d010Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d010Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90  centerd6d2d010Arialfoobar90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90  centerd6d2d010Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d010Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d010Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d010Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d010Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d010Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d010Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270  centerd6d2d010Arialfoobar270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270  centerd6d2d010Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d010Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d010Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d010Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d010Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d010Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d010Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo  centerd6d2d010Arialbarfoo.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo  centerd6d2d010Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -extent 200x200  centerd6d2d010Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -extent 200x200  centerd6d2d010Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -extent 200x800  centerd6d2d010Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -extent 200x800  centerd6d2d010Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -extent 800x200  centerd6d2d010Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -extent 800x200  centerd6d2d010Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0  centerd6d2d010Arialbarfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0  centerd6d2d010Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d010Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d010Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d010Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d010Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d010Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d010Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90  centerd6d2d010Arialbarfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90  centerd6d2d010Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d010Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d010Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d010Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d010Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d010Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d010Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270  centerd6d2d010Arialbarfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270  centerd6d2d010Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d010Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d010Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d010Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d010Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d010Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d010Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar  centerd6d2d012foobar.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar  centerd6d2d012foobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -extent 200x200  centerd6d2d012foobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -extent 200x200  centerd6d2d012foobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -extent 200x800  centerd6d2d012foobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -extent 200x800  centerd6d2d012foobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -extent 800x200  centerd6d2d012foobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -extent 800x200  centerd6d2d012foobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0  centerd6d2d012foobar0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0  centerd6d2d012foobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0 -extent 200x200  centerd6d2d012foobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0 -extent 200x200  centerd6d2d012foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0 -extent 200x800  centerd6d2d012foobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0 -extent 200x800  centerd6d2d012foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0 -extent 800x200  centerd6d2d012foobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 0 -extent 800x200  centerd6d2d012foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90  centerd6d2d012foobar90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90  centerd6d2d012foobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90 -extent 200x200  centerd6d2d012foobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90 -extent 200x200  centerd6d2d012foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90 -extent 200x800  centerd6d2d012foobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90 -extent 200x800  centerd6d2d012foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90 -extent 800x200  centerd6d2d012foobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 90 -extent 800x200  centerd6d2d012foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270  centerd6d2d012foobar270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270  centerd6d2d012foobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270 -extent 200x200  centerd6d2d012foobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270 -extent 200x200  centerd6d2d012foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270 -extent 200x800  centerd6d2d012foobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270 -extent 200x800  centerd6d2d012foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270 -extent 800x200  centerd6d2d012foobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:foobar -rotate 270 -extent 800x200  centerd6d2d012foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo  centerd6d2d012barfoo.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo  centerd6d2d012barfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -extent 200x200  centerd6d2d012barfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -extent 200x200  centerd6d2d012barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -extent 200x800  centerd6d2d012barfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -extent 200x800  centerd6d2d012barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -extent 800x200  centerd6d2d012barfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -extent 800x200  centerd6d2d012barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0  centerd6d2d012barfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0  centerd6d2d012barfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0 -extent 200x200  centerd6d2d012barfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0 -extent 200x200  centerd6d2d012barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0 -extent 200x800  centerd6d2d012barfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0 -extent 200x800  centerd6d2d012barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0 -extent 800x200  centerd6d2d012barfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 0 -extent 800x200  centerd6d2d012barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90  centerd6d2d012barfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90  centerd6d2d012barfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90 -extent 200x200  centerd6d2d012barfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90 -extent 200x200  centerd6d2d012barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90 -extent 200x800  centerd6d2d012barfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90 -extent 200x800  centerd6d2d012barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90 -extent 800x200  centerd6d2d012barfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 90 -extent 800x200  centerd6d2d012barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270  centerd6d2d012barfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270  centerd6d2d012barfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270 -extent 200x200  centerd6d2d012barfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270 -extent 200x200  centerd6d2d012barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270 -extent 200x800  centerd6d2d012barfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270 -extent 200x800  centerd6d2d012barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270 -extent 800x200  centerd6d2d012barfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12  label:barfoo -rotate 270 -extent 800x200  centerd6d2d012barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar  centerd6d2d012Arialfoobar.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar  centerd6d2d012Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -extent 200x200  centerd6d2d012Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -extent 200x200  centerd6d2d012Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -extent 200x800  centerd6d2d012Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -extent 200x800  centerd6d2d012Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -extent 800x200  centerd6d2d012Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -extent 800x200  centerd6d2d012Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0  centerd6d2d012Arialfoobar0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0  centerd6d2d012Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d012Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d012Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d012Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d012Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d012Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d012Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90  centerd6d2d012Arialfoobar90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90  centerd6d2d012Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d012Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d012Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d012Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d012Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d012Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d012Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270  centerd6d2d012Arialfoobar270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270  centerd6d2d012Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d012Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d012Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d012Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d012Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d012Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d012Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo  centerd6d2d012Arialbarfoo.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo  centerd6d2d012Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -extent 200x200  centerd6d2d012Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -extent 200x200  centerd6d2d012Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -extent 200x800  centerd6d2d012Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -extent 200x800  centerd6d2d012Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -extent 800x200  centerd6d2d012Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -extent 800x200  centerd6d2d012Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0  centerd6d2d012Arialbarfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0  centerd6d2d012Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d012Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d012Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d012Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d012Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d012Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d012Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90  centerd6d2d012Arialbarfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90  centerd6d2d012Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d012Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d012Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d012Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d012Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d012Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d012Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270  centerd6d2d012Arialbarfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270  centerd6d2d012Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d012Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d012Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d012Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d012Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d012Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d012Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar  centerd6d2d018foobar.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar  centerd6d2d018foobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -extent 200x200  centerd6d2d018foobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -extent 200x200  centerd6d2d018foobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -extent 200x800  centerd6d2d018foobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -extent 200x800  centerd6d2d018foobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -extent 800x200  centerd6d2d018foobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -extent 800x200  centerd6d2d018foobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0  centerd6d2d018foobar0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0  centerd6d2d018foobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0 -extent 200x200  centerd6d2d018foobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0 -extent 200x200  centerd6d2d018foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0 -extent 200x800  centerd6d2d018foobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0 -extent 200x800  centerd6d2d018foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0 -extent 800x200  centerd6d2d018foobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 0 -extent 800x200  centerd6d2d018foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90  centerd6d2d018foobar90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90  centerd6d2d018foobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90 -extent 200x200  centerd6d2d018foobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90 -extent 200x200  centerd6d2d018foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90 -extent 200x800  centerd6d2d018foobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90 -extent 200x800  centerd6d2d018foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90 -extent 800x200  centerd6d2d018foobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 90 -extent 800x200  centerd6d2d018foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270  centerd6d2d018foobar270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270  centerd6d2d018foobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270 -extent 200x200  centerd6d2d018foobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270 -extent 200x200  centerd6d2d018foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270 -extent 200x800  centerd6d2d018foobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270 -extent 200x800  centerd6d2d018foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270 -extent 800x200  centerd6d2d018foobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:foobar -rotate 270 -extent 800x200  centerd6d2d018foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo  centerd6d2d018barfoo.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo  centerd6d2d018barfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -extent 200x200  centerd6d2d018barfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -extent 200x200  centerd6d2d018barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -extent 200x800  centerd6d2d018barfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -extent 200x800  centerd6d2d018barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -extent 800x200  centerd6d2d018barfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -extent 800x200  centerd6d2d018barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0  centerd6d2d018barfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0  centerd6d2d018barfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0 -extent 200x200  centerd6d2d018barfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0 -extent 200x200  centerd6d2d018barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0 -extent 200x800  centerd6d2d018barfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0 -extent 200x800  centerd6d2d018barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0 -extent 800x200  centerd6d2d018barfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 0 -extent 800x200  centerd6d2d018barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90  centerd6d2d018barfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90  centerd6d2d018barfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90 -extent 200x200  centerd6d2d018barfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90 -extent 200x200  centerd6d2d018barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90 -extent 200x800  centerd6d2d018barfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90 -extent 200x800  centerd6d2d018barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90 -extent 800x200  centerd6d2d018barfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 90 -extent 800x200  centerd6d2d018barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270  centerd6d2d018barfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270  centerd6d2d018barfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270 -extent 200x200  centerd6d2d018barfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270 -extent 200x200  centerd6d2d018barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270 -extent 200x800  centerd6d2d018barfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270 -extent 200x800  centerd6d2d018barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270 -extent 800x200  centerd6d2d018barfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18  label:barfoo -rotate 270 -extent 800x200  centerd6d2d018barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar  centerd6d2d018Arialfoobar.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar  centerd6d2d018Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -extent 200x200  centerd6d2d018Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -extent 200x200  centerd6d2d018Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -extent 200x800  centerd6d2d018Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -extent 200x800  centerd6d2d018Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -extent 800x200  centerd6d2d018Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -extent 800x200  centerd6d2d018Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0  centerd6d2d018Arialfoobar0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0  centerd6d2d018Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d018Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d018Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d018Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d018Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d018Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d018Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90  centerd6d2d018Arialfoobar90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90  centerd6d2d018Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d018Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d018Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d018Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d018Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d018Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d018Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270  centerd6d2d018Arialfoobar270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270  centerd6d2d018Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d018Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d018Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d018Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d018Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d018Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d018Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo  centerd6d2d018Arialbarfoo.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo  centerd6d2d018Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -extent 200x200  centerd6d2d018Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -extent 200x200  centerd6d2d018Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -extent 200x800  centerd6d2d018Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -extent 200x800  centerd6d2d018Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -extent 800x200  centerd6d2d018Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -extent 800x200  centerd6d2d018Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0  centerd6d2d018Arialbarfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0  centerd6d2d018Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d018Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d018Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d018Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d018Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d018Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d018Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90  centerd6d2d018Arialbarfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90  centerd6d2d018Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d018Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d018Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d018Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d018Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d018Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d018Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270  centerd6d2d018Arialbarfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270  centerd6d2d018Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d018Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d018Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d018Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d018Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d018Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d018Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar  centerd6d2d024foobar.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar  centerd6d2d024foobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -extent 200x200  centerd6d2d024foobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -extent 200x200  centerd6d2d024foobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -extent 200x800  centerd6d2d024foobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -extent 200x800  centerd6d2d024foobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -extent 800x200  centerd6d2d024foobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -extent 800x200  centerd6d2d024foobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0  centerd6d2d024foobar0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0  centerd6d2d024foobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0 -extent 200x200  centerd6d2d024foobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0 -extent 200x200  centerd6d2d024foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0 -extent 200x800  centerd6d2d024foobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0 -extent 200x800  centerd6d2d024foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0 -extent 800x200  centerd6d2d024foobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 0 -extent 800x200  centerd6d2d024foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90  centerd6d2d024foobar90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90  centerd6d2d024foobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90 -extent 200x200  centerd6d2d024foobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90 -extent 200x200  centerd6d2d024foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90 -extent 200x800  centerd6d2d024foobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90 -extent 200x800  centerd6d2d024foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90 -extent 800x200  centerd6d2d024foobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 90 -extent 800x200  centerd6d2d024foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270  centerd6d2d024foobar270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270  centerd6d2d024foobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270 -extent 200x200  centerd6d2d024foobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270 -extent 200x200  centerd6d2d024foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270 -extent 200x800  centerd6d2d024foobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270 -extent 200x800  centerd6d2d024foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270 -extent 800x200  centerd6d2d024foobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:foobar -rotate 270 -extent 800x200  centerd6d2d024foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo  centerd6d2d024barfoo.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo  centerd6d2d024barfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -extent 200x200  centerd6d2d024barfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -extent 200x200  centerd6d2d024barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -extent 200x800  centerd6d2d024barfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -extent 200x800  centerd6d2d024barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -extent 800x200  centerd6d2d024barfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -extent 800x200  centerd6d2d024barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0  centerd6d2d024barfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0  centerd6d2d024barfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0 -extent 200x200  centerd6d2d024barfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0 -extent 200x200  centerd6d2d024barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0 -extent 200x800  centerd6d2d024barfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0 -extent 200x800  centerd6d2d024barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0 -extent 800x200  centerd6d2d024barfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 0 -extent 800x200  centerd6d2d024barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90  centerd6d2d024barfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90  centerd6d2d024barfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90 -extent 200x200  centerd6d2d024barfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90 -extent 200x200  centerd6d2d024barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90 -extent 200x800  centerd6d2d024barfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90 -extent 200x800  centerd6d2d024barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90 -extent 800x200  centerd6d2d024barfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 90 -extent 800x200  centerd6d2d024barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270  centerd6d2d024barfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270  centerd6d2d024barfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270 -extent 200x200  centerd6d2d024barfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270 -extent 200x200  centerd6d2d024barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270 -extent 200x800  centerd6d2d024barfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270 -extent 200x800  centerd6d2d024barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270 -extent 800x200  centerd6d2d024barfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24  label:barfoo -rotate 270 -extent 800x200  centerd6d2d024barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar  centerd6d2d024Arialfoobar.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar  centerd6d2d024Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -extent 200x200  centerd6d2d024Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -extent 200x200  centerd6d2d024Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -extent 200x800  centerd6d2d024Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -extent 200x800  centerd6d2d024Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -extent 800x200  centerd6d2d024Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -extent 800x200  centerd6d2d024Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0  centerd6d2d024Arialfoobar0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0  centerd6d2d024Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d024Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d024Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d024Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d024Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d024Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d024Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90  centerd6d2d024Arialfoobar90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90  centerd6d2d024Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d024Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d024Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d024Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d024Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d024Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d024Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270  centerd6d2d024Arialfoobar270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270  centerd6d2d024Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d024Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d024Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d024Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d024Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d024Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d024Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo  centerd6d2d024Arialbarfoo.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo  centerd6d2d024Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -extent 200x200  centerd6d2d024Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -extent 200x200  centerd6d2d024Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -extent 200x800  centerd6d2d024Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -extent 200x800  centerd6d2d024Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -extent 800x200  centerd6d2d024Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -extent 800x200  centerd6d2d024Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0  centerd6d2d024Arialbarfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0  centerd6d2d024Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d024Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d024Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d024Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d024Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d024Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d024Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90  centerd6d2d024Arialbarfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90  centerd6d2d024Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d024Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d024Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d024Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d024Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d024Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d024Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270  centerd6d2d024Arialbarfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270  centerd6d2d024Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d024Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d024Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d024Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d024Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d024Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d024Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar  centerd6d2d048foobar.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar  centerd6d2d048foobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -extent 200x200  centerd6d2d048foobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -extent 200x200  centerd6d2d048foobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -extent 200x800  centerd6d2d048foobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -extent 200x800  centerd6d2d048foobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -extent 800x200  centerd6d2d048foobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -extent 800x200  centerd6d2d048foobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0  centerd6d2d048foobar0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0  centerd6d2d048foobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0 -extent 200x200  centerd6d2d048foobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0 -extent 200x200  centerd6d2d048foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0 -extent 200x800  centerd6d2d048foobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0 -extent 200x800  centerd6d2d048foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0 -extent 800x200  centerd6d2d048foobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 0 -extent 800x200  centerd6d2d048foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90  centerd6d2d048foobar90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90  centerd6d2d048foobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90 -extent 200x200  centerd6d2d048foobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90 -extent 200x200  centerd6d2d048foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90 -extent 200x800  centerd6d2d048foobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90 -extent 200x800  centerd6d2d048foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90 -extent 800x200  centerd6d2d048foobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 90 -extent 800x200  centerd6d2d048foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270  centerd6d2d048foobar270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270  centerd6d2d048foobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270 -extent 200x200  centerd6d2d048foobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270 -extent 200x200  centerd6d2d048foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270 -extent 200x800  centerd6d2d048foobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270 -extent 200x800  centerd6d2d048foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270 -extent 800x200  centerd6d2d048foobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:foobar -rotate 270 -extent 800x200  centerd6d2d048foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo  centerd6d2d048barfoo.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo  centerd6d2d048barfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -extent 200x200  centerd6d2d048barfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -extent 200x200  centerd6d2d048barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -extent 200x800  centerd6d2d048barfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -extent 200x800  centerd6d2d048barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -extent 800x200  centerd6d2d048barfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -extent 800x200  centerd6d2d048barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0  centerd6d2d048barfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0  centerd6d2d048barfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0 -extent 200x200  centerd6d2d048barfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0 -extent 200x200  centerd6d2d048barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0 -extent 200x800  centerd6d2d048barfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0 -extent 200x800  centerd6d2d048barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0 -extent 800x200  centerd6d2d048barfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 0 -extent 800x200  centerd6d2d048barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90  centerd6d2d048barfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90  centerd6d2d048barfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90 -extent 200x200  centerd6d2d048barfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90 -extent 200x200  centerd6d2d048barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90 -extent 200x800  centerd6d2d048barfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90 -extent 200x800  centerd6d2d048barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90 -extent 800x200  centerd6d2d048barfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 90 -extent 800x200  centerd6d2d048barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270  centerd6d2d048barfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270  centerd6d2d048barfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270 -extent 200x200  centerd6d2d048barfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270 -extent 200x200  centerd6d2d048barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270 -extent 200x800  centerd6d2d048barfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270 -extent 200x800  centerd6d2d048barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270 -extent 800x200  centerd6d2d048barfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48  label:barfoo -rotate 270 -extent 800x200  centerd6d2d048barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar  centerd6d2d048Arialfoobar.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar  centerd6d2d048Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -extent 200x200  centerd6d2d048Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -extent 200x200  centerd6d2d048Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -extent 200x800  centerd6d2d048Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -extent 200x800  centerd6d2d048Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -extent 800x200  centerd6d2d048Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -extent 800x200  centerd6d2d048Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0  centerd6d2d048Arialfoobar0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0  centerd6d2d048Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d048Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  centerd6d2d048Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d048Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  centerd6d2d048Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d048Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  centerd6d2d048Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90  centerd6d2d048Arialfoobar90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90  centerd6d2d048Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d048Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  centerd6d2d048Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d048Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  centerd6d2d048Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d048Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  centerd6d2d048Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270  centerd6d2d048Arialfoobar270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270  centerd6d2d048Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d048Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  centerd6d2d048Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d048Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  centerd6d2d048Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d048Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  centerd6d2d048Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo  centerd6d2d048Arialbarfoo.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo  centerd6d2d048Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -extent 200x200  centerd6d2d048Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -extent 200x200  centerd6d2d048Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -extent 200x800  centerd6d2d048Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -extent 200x800  centerd6d2d048Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -extent 800x200  centerd6d2d048Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -extent 800x200  centerd6d2d048Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0  centerd6d2d048Arialbarfoo0.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0  centerd6d2d048Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d048Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerd6d2d048Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d048Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerd6d2d048Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d048Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerd6d2d048Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90  centerd6d2d048Arialbarfoo90.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90  centerd6d2d048Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d048Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerd6d2d048Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d048Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerd6d2d048Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d048Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerd6d2d048Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270  centerd6d2d048Arialbarfoo270.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270  centerd6d2d048Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d048Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerd6d2d048Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d048Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerd6d2d048Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d048Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#d6d2d0' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerd6d2d048Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar  center0000fffoobar.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar  center0000fffoobar.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -extent 200x200  center0000fffoobar200x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -extent 200x200  center0000fffoobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -extent 200x800  center0000fffoobar200x800.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -extent 200x800  center0000fffoobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -extent 800x200  center0000fffoobar800x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -extent 800x200  center0000fffoobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 0  center0000fffoobar0.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 0  center0000fffoobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 0 -extent 200x200  center0000fffoobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 0 -extent 200x200  center0000fffoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 0 -extent 200x800  center0000fffoobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 0 -extent 200x800  center0000fffoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 0 -extent 800x200  center0000fffoobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 0 -extent 800x200  center0000fffoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 90  center0000fffoobar90.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 90  center0000fffoobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 90 -extent 200x200  center0000fffoobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 90 -extent 200x200  center0000fffoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 90 -extent 200x800  center0000fffoobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 90 -extent 200x800  center0000fffoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 90 -extent 800x200  center0000fffoobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 90 -extent 800x200  center0000fffoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 270  center0000fffoobar270.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 270  center0000fffoobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 270 -extent 200x200  center0000fffoobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 270 -extent 200x200  center0000fffoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 270 -extent 200x800  center0000fffoobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 270 -extent 200x800  center0000fffoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 270 -extent 800x200  center0000fffoobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:foobar -rotate 270 -extent 800x200  center0000fffoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo  center0000ffbarfoo.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo  center0000ffbarfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -extent 200x200  center0000ffbarfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -extent 200x200  center0000ffbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -extent 200x800  center0000ffbarfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -extent 200x800  center0000ffbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -extent 800x200  center0000ffbarfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -extent 800x200  center0000ffbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 0  center0000ffbarfoo0.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 0  center0000ffbarfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 0 -extent 200x200  center0000ffbarfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 0 -extent 200x200  center0000ffbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 0 -extent 200x800  center0000ffbarfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 0 -extent 200x800  center0000ffbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 0 -extent 800x200  center0000ffbarfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 0 -extent 800x200  center0000ffbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 90  center0000ffbarfoo90.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 90  center0000ffbarfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 90 -extent 200x200  center0000ffbarfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 90 -extent 200x200  center0000ffbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 90 -extent 200x800  center0000ffbarfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 90 -extent 200x800  center0000ffbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 90 -extent 800x200  center0000ffbarfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 90 -extent 800x200  center0000ffbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 270  center0000ffbarfoo270.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 270  center0000ffbarfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 270 -extent 200x200  center0000ffbarfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 270 -extent 200x200  center0000ffbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 270 -extent 200x800  center0000ffbarfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 270 -extent 200x800  center0000ffbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 270 -extent 800x200  center0000ffbarfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff'  label:barfoo -rotate 270 -extent 800x200  center0000ffbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar  center0000ffArialfoobar.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar  center0000ffArialfoobar.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -extent 200x200  center0000ffArialfoobar200x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -extent 200x200  center0000ffArialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -extent 200x800  center0000ffArialfoobar200x800.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -extent 200x800  center0000ffArialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -extent 800x200  center0000ffArialfoobar800x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -extent 800x200  center0000ffArialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 0  center0000ffArialfoobar0.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 0  center0000ffArialfoobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ffArialfoobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ffArialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ffArialfoobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ffArialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ffArialfoobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ffArialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 90  center0000ffArialfoobar90.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 90  center0000ffArialfoobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ffArialfoobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ffArialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ffArialfoobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ffArialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ffArialfoobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ffArialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 270  center0000ffArialfoobar270.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 270  center0000ffArialfoobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ffArialfoobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ffArialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ffArialfoobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ffArialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ffArialfoobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ffArialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo  center0000ffArialbarfoo.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo  center0000ffArialbarfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -extent 200x200  center0000ffArialbarfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -extent 200x200  center0000ffArialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -extent 200x800  center0000ffArialbarfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -extent 200x800  center0000ffArialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -extent 800x200  center0000ffArialbarfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -extent 800x200  center0000ffArialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 0  center0000ffArialbarfoo0.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 0  center0000ffArialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ffArialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ffArialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ffArialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ffArialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ffArialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ffArialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 90  center0000ffArialbarfoo90.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 90  center0000ffArialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ffArialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ffArialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ffArialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ffArialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ffArialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ffArialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 270  center0000ffArialbarfoo270.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 270  center0000ffArialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ffArialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ffArialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ffArialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ffArialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ffArialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ffArialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar  center0000ff8foobar.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar  center0000ff8foobar.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -extent 200x200  center0000ff8foobar200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -extent 200x200  center0000ff8foobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -extent 200x800  center0000ff8foobar200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -extent 200x800  center0000ff8foobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -extent 800x200  center0000ff8foobar800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -extent 800x200  center0000ff8foobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 0  center0000ff8foobar0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 0  center0000ff8foobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 0 -extent 200x200  center0000ff8foobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 0 -extent 200x200  center0000ff8foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 0 -extent 200x800  center0000ff8foobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 0 -extent 200x800  center0000ff8foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 0 -extent 800x200  center0000ff8foobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 0 -extent 800x200  center0000ff8foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 90  center0000ff8foobar90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 90  center0000ff8foobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 90 -extent 200x200  center0000ff8foobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 90 -extent 200x200  center0000ff8foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 90 -extent 200x800  center0000ff8foobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 90 -extent 200x800  center0000ff8foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 90 -extent 800x200  center0000ff8foobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 90 -extent 800x200  center0000ff8foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 270  center0000ff8foobar270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 270  center0000ff8foobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 270 -extent 200x200  center0000ff8foobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 270 -extent 200x200  center0000ff8foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 270 -extent 200x800  center0000ff8foobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 270 -extent 200x800  center0000ff8foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 270 -extent 800x200  center0000ff8foobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:foobar -rotate 270 -extent 800x200  center0000ff8foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo  center0000ff8barfoo.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo  center0000ff8barfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -extent 200x200  center0000ff8barfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -extent 200x200  center0000ff8barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -extent 200x800  center0000ff8barfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -extent 200x800  center0000ff8barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -extent 800x200  center0000ff8barfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -extent 800x200  center0000ff8barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 0  center0000ff8barfoo0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 0  center0000ff8barfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 0 -extent 200x200  center0000ff8barfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 0 -extent 200x200  center0000ff8barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 0 -extent 200x800  center0000ff8barfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 0 -extent 200x800  center0000ff8barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 0 -extent 800x200  center0000ff8barfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 0 -extent 800x200  center0000ff8barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 90  center0000ff8barfoo90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 90  center0000ff8barfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 90 -extent 200x200  center0000ff8barfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 90 -extent 200x200  center0000ff8barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 90 -extent 200x800  center0000ff8barfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 90 -extent 200x800  center0000ff8barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 90 -extent 800x200  center0000ff8barfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 90 -extent 800x200  center0000ff8barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 270  center0000ff8barfoo270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 270  center0000ff8barfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 270 -extent 200x200  center0000ff8barfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 270 -extent 200x200  center0000ff8barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 270 -extent 200x800  center0000ff8barfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 270 -extent 200x800  center0000ff8barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 270 -extent 800x200  center0000ff8barfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8  label:barfoo -rotate 270 -extent 800x200  center0000ff8barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar  center0000ff8Arialfoobar.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar  center0000ff8Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -extent 200x200  center0000ff8Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -extent 200x200  center0000ff8Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -extent 200x800  center0000ff8Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -extent 200x800  center0000ff8Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -extent 800x200  center0000ff8Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -extent 800x200  center0000ff8Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0  center0000ff8Arialfoobar0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0  center0000ff8Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ff8Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ff8Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ff8Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ff8Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ff8Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ff8Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90  center0000ff8Arialfoobar90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90  center0000ff8Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ff8Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ff8Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ff8Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ff8Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ff8Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ff8Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270  center0000ff8Arialfoobar270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270  center0000ff8Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ff8Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ff8Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ff8Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ff8Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ff8Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ff8Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo  center0000ff8Arialbarfoo.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo  center0000ff8Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -extent 200x200  center0000ff8Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -extent 200x200  center0000ff8Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -extent 200x800  center0000ff8Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -extent 200x800  center0000ff8Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -extent 800x200  center0000ff8Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -extent 800x200  center0000ff8Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0  center0000ff8Arialbarfoo0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0  center0000ff8Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ff8Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ff8Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ff8Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ff8Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ff8Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ff8Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90  center0000ff8Arialbarfoo90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90  center0000ff8Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ff8Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ff8Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ff8Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ff8Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ff8Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ff8Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270  center0000ff8Arialbarfoo270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270  center0000ff8Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ff8Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ff8Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ff8Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ff8Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ff8Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ff8Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar  center0000ff10foobar.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar  center0000ff10foobar.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -extent 200x200  center0000ff10foobar200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -extent 200x200  center0000ff10foobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -extent 200x800  center0000ff10foobar200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -extent 200x800  center0000ff10foobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -extent 800x200  center0000ff10foobar800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -extent 800x200  center0000ff10foobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 0  center0000ff10foobar0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 0  center0000ff10foobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 0 -extent 200x200  center0000ff10foobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 0 -extent 200x200  center0000ff10foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 0 -extent 200x800  center0000ff10foobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 0 -extent 200x800  center0000ff10foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 0 -extent 800x200  center0000ff10foobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 0 -extent 800x200  center0000ff10foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 90  center0000ff10foobar90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 90  center0000ff10foobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 90 -extent 200x200  center0000ff10foobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 90 -extent 200x200  center0000ff10foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 90 -extent 200x800  center0000ff10foobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 90 -extent 200x800  center0000ff10foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 90 -extent 800x200  center0000ff10foobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 90 -extent 800x200  center0000ff10foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 270  center0000ff10foobar270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 270  center0000ff10foobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 270 -extent 200x200  center0000ff10foobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 270 -extent 200x200  center0000ff10foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 270 -extent 200x800  center0000ff10foobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 270 -extent 200x800  center0000ff10foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 270 -extent 800x200  center0000ff10foobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:foobar -rotate 270 -extent 800x200  center0000ff10foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo  center0000ff10barfoo.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo  center0000ff10barfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -extent 200x200  center0000ff10barfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -extent 200x200  center0000ff10barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -extent 200x800  center0000ff10barfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -extent 200x800  center0000ff10barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -extent 800x200  center0000ff10barfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -extent 800x200  center0000ff10barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 0  center0000ff10barfoo0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 0  center0000ff10barfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 0 -extent 200x200  center0000ff10barfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 0 -extent 200x200  center0000ff10barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 0 -extent 200x800  center0000ff10barfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 0 -extent 200x800  center0000ff10barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 0 -extent 800x200  center0000ff10barfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 0 -extent 800x200  center0000ff10barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 90  center0000ff10barfoo90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 90  center0000ff10barfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 90 -extent 200x200  center0000ff10barfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 90 -extent 200x200  center0000ff10barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 90 -extent 200x800  center0000ff10barfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 90 -extent 200x800  center0000ff10barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 90 -extent 800x200  center0000ff10barfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 90 -extent 800x200  center0000ff10barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 270  center0000ff10barfoo270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 270  center0000ff10barfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 270 -extent 200x200  center0000ff10barfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 270 -extent 200x200  center0000ff10barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 270 -extent 200x800  center0000ff10barfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 270 -extent 200x800  center0000ff10barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 270 -extent 800x200  center0000ff10barfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10  label:barfoo -rotate 270 -extent 800x200  center0000ff10barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar  center0000ff10Arialfoobar.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar  center0000ff10Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -extent 200x200  center0000ff10Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -extent 200x200  center0000ff10Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -extent 200x800  center0000ff10Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -extent 200x800  center0000ff10Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -extent 800x200  center0000ff10Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -extent 800x200  center0000ff10Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0  center0000ff10Arialfoobar0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0  center0000ff10Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ff10Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ff10Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ff10Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ff10Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ff10Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ff10Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90  center0000ff10Arialfoobar90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90  center0000ff10Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ff10Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ff10Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ff10Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ff10Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ff10Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ff10Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270  center0000ff10Arialfoobar270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270  center0000ff10Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ff10Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ff10Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ff10Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ff10Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ff10Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ff10Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo  center0000ff10Arialbarfoo.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo  center0000ff10Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -extent 200x200  center0000ff10Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -extent 200x200  center0000ff10Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -extent 200x800  center0000ff10Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -extent 200x800  center0000ff10Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -extent 800x200  center0000ff10Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -extent 800x200  center0000ff10Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0  center0000ff10Arialbarfoo0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0  center0000ff10Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ff10Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ff10Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ff10Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ff10Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ff10Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ff10Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90  center0000ff10Arialbarfoo90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90  center0000ff10Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ff10Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ff10Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ff10Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ff10Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ff10Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ff10Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270  center0000ff10Arialbarfoo270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270  center0000ff10Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ff10Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ff10Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ff10Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ff10Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ff10Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ff10Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar  center0000ff12foobar.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar  center0000ff12foobar.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -extent 200x200  center0000ff12foobar200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -extent 200x200  center0000ff12foobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -extent 200x800  center0000ff12foobar200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -extent 200x800  center0000ff12foobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -extent 800x200  center0000ff12foobar800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -extent 800x200  center0000ff12foobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 0  center0000ff12foobar0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 0  center0000ff12foobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 0 -extent 200x200  center0000ff12foobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 0 -extent 200x200  center0000ff12foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 0 -extent 200x800  center0000ff12foobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 0 -extent 200x800  center0000ff12foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 0 -extent 800x200  center0000ff12foobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 0 -extent 800x200  center0000ff12foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 90  center0000ff12foobar90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 90  center0000ff12foobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 90 -extent 200x200  center0000ff12foobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 90 -extent 200x200  center0000ff12foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 90 -extent 200x800  center0000ff12foobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 90 -extent 200x800  center0000ff12foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 90 -extent 800x200  center0000ff12foobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 90 -extent 800x200  center0000ff12foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 270  center0000ff12foobar270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 270  center0000ff12foobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 270 -extent 200x200  center0000ff12foobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 270 -extent 200x200  center0000ff12foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 270 -extent 200x800  center0000ff12foobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 270 -extent 200x800  center0000ff12foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 270 -extent 800x200  center0000ff12foobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:foobar -rotate 270 -extent 800x200  center0000ff12foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo  center0000ff12barfoo.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo  center0000ff12barfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -extent 200x200  center0000ff12barfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -extent 200x200  center0000ff12barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -extent 200x800  center0000ff12barfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -extent 200x800  center0000ff12barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -extent 800x200  center0000ff12barfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -extent 800x200  center0000ff12barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 0  center0000ff12barfoo0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 0  center0000ff12barfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 0 -extent 200x200  center0000ff12barfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 0 -extent 200x200  center0000ff12barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 0 -extent 200x800  center0000ff12barfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 0 -extent 200x800  center0000ff12barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 0 -extent 800x200  center0000ff12barfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 0 -extent 800x200  center0000ff12barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 90  center0000ff12barfoo90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 90  center0000ff12barfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 90 -extent 200x200  center0000ff12barfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 90 -extent 200x200  center0000ff12barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 90 -extent 200x800  center0000ff12barfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 90 -extent 200x800  center0000ff12barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 90 -extent 800x200  center0000ff12barfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 90 -extent 800x200  center0000ff12barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 270  center0000ff12barfoo270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 270  center0000ff12barfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 270 -extent 200x200  center0000ff12barfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 270 -extent 200x200  center0000ff12barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 270 -extent 200x800  center0000ff12barfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 270 -extent 200x800  center0000ff12barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 270 -extent 800x200  center0000ff12barfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12  label:barfoo -rotate 270 -extent 800x200  center0000ff12barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar  center0000ff12Arialfoobar.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar  center0000ff12Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -extent 200x200  center0000ff12Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -extent 200x200  center0000ff12Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -extent 200x800  center0000ff12Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -extent 200x800  center0000ff12Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -extent 800x200  center0000ff12Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -extent 800x200  center0000ff12Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0  center0000ff12Arialfoobar0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0  center0000ff12Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ff12Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ff12Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ff12Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ff12Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ff12Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ff12Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90  center0000ff12Arialfoobar90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90  center0000ff12Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ff12Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ff12Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ff12Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ff12Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ff12Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ff12Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270  center0000ff12Arialfoobar270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270  center0000ff12Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ff12Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ff12Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ff12Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ff12Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ff12Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ff12Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo  center0000ff12Arialbarfoo.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo  center0000ff12Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -extent 200x200  center0000ff12Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -extent 200x200  center0000ff12Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -extent 200x800  center0000ff12Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -extent 200x800  center0000ff12Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -extent 800x200  center0000ff12Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -extent 800x200  center0000ff12Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0  center0000ff12Arialbarfoo0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0  center0000ff12Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ff12Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ff12Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ff12Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ff12Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ff12Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ff12Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90  center0000ff12Arialbarfoo90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90  center0000ff12Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ff12Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ff12Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ff12Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ff12Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ff12Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ff12Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270  center0000ff12Arialbarfoo270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270  center0000ff12Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ff12Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ff12Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ff12Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ff12Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ff12Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ff12Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar  center0000ff18foobar.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar  center0000ff18foobar.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -extent 200x200  center0000ff18foobar200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -extent 200x200  center0000ff18foobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -extent 200x800  center0000ff18foobar200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -extent 200x800  center0000ff18foobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -extent 800x200  center0000ff18foobar800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -extent 800x200  center0000ff18foobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 0  center0000ff18foobar0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 0  center0000ff18foobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 0 -extent 200x200  center0000ff18foobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 0 -extent 200x200  center0000ff18foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 0 -extent 200x800  center0000ff18foobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 0 -extent 200x800  center0000ff18foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 0 -extent 800x200  center0000ff18foobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 0 -extent 800x200  center0000ff18foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 90  center0000ff18foobar90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 90  center0000ff18foobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 90 -extent 200x200  center0000ff18foobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 90 -extent 200x200  center0000ff18foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 90 -extent 200x800  center0000ff18foobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 90 -extent 200x800  center0000ff18foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 90 -extent 800x200  center0000ff18foobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 90 -extent 800x200  center0000ff18foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 270  center0000ff18foobar270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 270  center0000ff18foobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 270 -extent 200x200  center0000ff18foobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 270 -extent 200x200  center0000ff18foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 270 -extent 200x800  center0000ff18foobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 270 -extent 200x800  center0000ff18foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 270 -extent 800x200  center0000ff18foobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:foobar -rotate 270 -extent 800x200  center0000ff18foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo  center0000ff18barfoo.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo  center0000ff18barfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -extent 200x200  center0000ff18barfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -extent 200x200  center0000ff18barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -extent 200x800  center0000ff18barfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -extent 200x800  center0000ff18barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -extent 800x200  center0000ff18barfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -extent 800x200  center0000ff18barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 0  center0000ff18barfoo0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 0  center0000ff18barfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 0 -extent 200x200  center0000ff18barfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 0 -extent 200x200  center0000ff18barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 0 -extent 200x800  center0000ff18barfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 0 -extent 200x800  center0000ff18barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 0 -extent 800x200  center0000ff18barfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 0 -extent 800x200  center0000ff18barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 90  center0000ff18barfoo90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 90  center0000ff18barfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 90 -extent 200x200  center0000ff18barfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 90 -extent 200x200  center0000ff18barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 90 -extent 200x800  center0000ff18barfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 90 -extent 200x800  center0000ff18barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 90 -extent 800x200  center0000ff18barfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 90 -extent 800x200  center0000ff18barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 270  center0000ff18barfoo270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 270  center0000ff18barfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 270 -extent 200x200  center0000ff18barfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 270 -extent 200x200  center0000ff18barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 270 -extent 200x800  center0000ff18barfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 270 -extent 200x800  center0000ff18barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 270 -extent 800x200  center0000ff18barfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18  label:barfoo -rotate 270 -extent 800x200  center0000ff18barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar  center0000ff18Arialfoobar.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar  center0000ff18Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -extent 200x200  center0000ff18Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -extent 200x200  center0000ff18Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -extent 200x800  center0000ff18Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -extent 200x800  center0000ff18Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -extent 800x200  center0000ff18Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -extent 800x200  center0000ff18Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0  center0000ff18Arialfoobar0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0  center0000ff18Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ff18Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ff18Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ff18Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ff18Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ff18Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ff18Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90  center0000ff18Arialfoobar90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90  center0000ff18Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ff18Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ff18Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ff18Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ff18Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ff18Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ff18Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270  center0000ff18Arialfoobar270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270  center0000ff18Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ff18Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ff18Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ff18Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ff18Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ff18Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ff18Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo  center0000ff18Arialbarfoo.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo  center0000ff18Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -extent 200x200  center0000ff18Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -extent 200x200  center0000ff18Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -extent 200x800  center0000ff18Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -extent 200x800  center0000ff18Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -extent 800x200  center0000ff18Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -extent 800x200  center0000ff18Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0  center0000ff18Arialbarfoo0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0  center0000ff18Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ff18Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ff18Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ff18Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ff18Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ff18Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ff18Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90  center0000ff18Arialbarfoo90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90  center0000ff18Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ff18Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ff18Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ff18Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ff18Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ff18Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ff18Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270  center0000ff18Arialbarfoo270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270  center0000ff18Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ff18Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ff18Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ff18Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ff18Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ff18Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ff18Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar  center0000ff24foobar.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar  center0000ff24foobar.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -extent 200x200  center0000ff24foobar200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -extent 200x200  center0000ff24foobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -extent 200x800  center0000ff24foobar200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -extent 200x800  center0000ff24foobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -extent 800x200  center0000ff24foobar800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -extent 800x200  center0000ff24foobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 0  center0000ff24foobar0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 0  center0000ff24foobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 0 -extent 200x200  center0000ff24foobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 0 -extent 200x200  center0000ff24foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 0 -extent 200x800  center0000ff24foobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 0 -extent 200x800  center0000ff24foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 0 -extent 800x200  center0000ff24foobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 0 -extent 800x200  center0000ff24foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 90  center0000ff24foobar90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 90  center0000ff24foobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 90 -extent 200x200  center0000ff24foobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 90 -extent 200x200  center0000ff24foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 90 -extent 200x800  center0000ff24foobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 90 -extent 200x800  center0000ff24foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 90 -extent 800x200  center0000ff24foobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 90 -extent 800x200  center0000ff24foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 270  center0000ff24foobar270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 270  center0000ff24foobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 270 -extent 200x200  center0000ff24foobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 270 -extent 200x200  center0000ff24foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 270 -extent 200x800  center0000ff24foobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 270 -extent 200x800  center0000ff24foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 270 -extent 800x200  center0000ff24foobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:foobar -rotate 270 -extent 800x200  center0000ff24foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo  center0000ff24barfoo.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo  center0000ff24barfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -extent 200x200  center0000ff24barfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -extent 200x200  center0000ff24barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -extent 200x800  center0000ff24barfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -extent 200x800  center0000ff24barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -extent 800x200  center0000ff24barfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -extent 800x200  center0000ff24barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 0  center0000ff24barfoo0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 0  center0000ff24barfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 0 -extent 200x200  center0000ff24barfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 0 -extent 200x200  center0000ff24barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 0 -extent 200x800  center0000ff24barfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 0 -extent 200x800  center0000ff24barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 0 -extent 800x200  center0000ff24barfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 0 -extent 800x200  center0000ff24barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 90  center0000ff24barfoo90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 90  center0000ff24barfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 90 -extent 200x200  center0000ff24barfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 90 -extent 200x200  center0000ff24barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 90 -extent 200x800  center0000ff24barfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 90 -extent 200x800  center0000ff24barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 90 -extent 800x200  center0000ff24barfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 90 -extent 800x200  center0000ff24barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 270  center0000ff24barfoo270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 270  center0000ff24barfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 270 -extent 200x200  center0000ff24barfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 270 -extent 200x200  center0000ff24barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 270 -extent 200x800  center0000ff24barfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 270 -extent 200x800  center0000ff24barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 270 -extent 800x200  center0000ff24barfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24  label:barfoo -rotate 270 -extent 800x200  center0000ff24barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar  center0000ff24Arialfoobar.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar  center0000ff24Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -extent 200x200  center0000ff24Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -extent 200x200  center0000ff24Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -extent 200x800  center0000ff24Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -extent 200x800  center0000ff24Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -extent 800x200  center0000ff24Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -extent 800x200  center0000ff24Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0  center0000ff24Arialfoobar0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0  center0000ff24Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ff24Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ff24Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ff24Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ff24Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ff24Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ff24Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90  center0000ff24Arialfoobar90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90  center0000ff24Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ff24Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ff24Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ff24Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ff24Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ff24Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ff24Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270  center0000ff24Arialfoobar270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270  center0000ff24Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ff24Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ff24Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ff24Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ff24Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ff24Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ff24Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo  center0000ff24Arialbarfoo.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo  center0000ff24Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -extent 200x200  center0000ff24Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -extent 200x200  center0000ff24Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -extent 200x800  center0000ff24Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -extent 200x800  center0000ff24Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -extent 800x200  center0000ff24Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -extent 800x200  center0000ff24Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0  center0000ff24Arialbarfoo0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0  center0000ff24Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ff24Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ff24Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ff24Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ff24Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ff24Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ff24Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90  center0000ff24Arialbarfoo90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90  center0000ff24Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ff24Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ff24Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ff24Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ff24Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ff24Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ff24Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270  center0000ff24Arialbarfoo270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270  center0000ff24Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ff24Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ff24Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ff24Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ff24Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ff24Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ff24Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar  center0000ff48foobar.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar  center0000ff48foobar.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -extent 200x200  center0000ff48foobar200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -extent 200x200  center0000ff48foobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -extent 200x800  center0000ff48foobar200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -extent 200x800  center0000ff48foobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -extent 800x200  center0000ff48foobar800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -extent 800x200  center0000ff48foobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 0  center0000ff48foobar0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 0  center0000ff48foobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 0 -extent 200x200  center0000ff48foobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 0 -extent 200x200  center0000ff48foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 0 -extent 200x800  center0000ff48foobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 0 -extent 200x800  center0000ff48foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 0 -extent 800x200  center0000ff48foobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 0 -extent 800x200  center0000ff48foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 90  center0000ff48foobar90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 90  center0000ff48foobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 90 -extent 200x200  center0000ff48foobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 90 -extent 200x200  center0000ff48foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 90 -extent 200x800  center0000ff48foobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 90 -extent 200x800  center0000ff48foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 90 -extent 800x200  center0000ff48foobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 90 -extent 800x200  center0000ff48foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 270  center0000ff48foobar270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 270  center0000ff48foobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 270 -extent 200x200  center0000ff48foobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 270 -extent 200x200  center0000ff48foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 270 -extent 200x800  center0000ff48foobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 270 -extent 200x800  center0000ff48foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 270 -extent 800x200  center0000ff48foobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:foobar -rotate 270 -extent 800x200  center0000ff48foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo  center0000ff48barfoo.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo  center0000ff48barfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -extent 200x200  center0000ff48barfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -extent 200x200  center0000ff48barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -extent 200x800  center0000ff48barfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -extent 200x800  center0000ff48barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -extent 800x200  center0000ff48barfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -extent 800x200  center0000ff48barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 0  center0000ff48barfoo0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 0  center0000ff48barfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 0 -extent 200x200  center0000ff48barfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 0 -extent 200x200  center0000ff48barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 0 -extent 200x800  center0000ff48barfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 0 -extent 200x800  center0000ff48barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 0 -extent 800x200  center0000ff48barfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 0 -extent 800x200  center0000ff48barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 90  center0000ff48barfoo90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 90  center0000ff48barfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 90 -extent 200x200  center0000ff48barfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 90 -extent 200x200  center0000ff48barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 90 -extent 200x800  center0000ff48barfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 90 -extent 200x800  center0000ff48barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 90 -extent 800x200  center0000ff48barfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 90 -extent 800x200  center0000ff48barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 270  center0000ff48barfoo270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 270  center0000ff48barfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 270 -extent 200x200  center0000ff48barfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 270 -extent 200x200  center0000ff48barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 270 -extent 200x800  center0000ff48barfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 270 -extent 200x800  center0000ff48barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 270 -extent 800x200  center0000ff48barfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48  label:barfoo -rotate 270 -extent 800x200  center0000ff48barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar  center0000ff48Arialfoobar.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar  center0000ff48Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -extent 200x200  center0000ff48Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -extent 200x200  center0000ff48Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -extent 200x800  center0000ff48Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -extent 200x800  center0000ff48Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -extent 800x200  center0000ff48Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -extent 800x200  center0000ff48Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0  center0000ff48Arialfoobar0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0  center0000ff48Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ff48Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  center0000ff48Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ff48Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  center0000ff48Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ff48Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  center0000ff48Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90  center0000ff48Arialfoobar90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90  center0000ff48Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ff48Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  center0000ff48Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ff48Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  center0000ff48Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ff48Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  center0000ff48Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270  center0000ff48Arialfoobar270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270  center0000ff48Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ff48Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  center0000ff48Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ff48Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  center0000ff48Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ff48Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  center0000ff48Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo  center0000ff48Arialbarfoo.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo  center0000ff48Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -extent 200x200  center0000ff48Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -extent 200x200  center0000ff48Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -extent 200x800  center0000ff48Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -extent 200x800  center0000ff48Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -extent 800x200  center0000ff48Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -extent 800x200  center0000ff48Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0  center0000ff48Arialbarfoo0.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0  center0000ff48Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ff48Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  center0000ff48Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ff48Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  center0000ff48Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ff48Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  center0000ff48Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90  center0000ff48Arialbarfoo90.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90  center0000ff48Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ff48Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  center0000ff48Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ff48Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  center0000ff48Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ff48Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  center0000ff48Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270  center0000ff48Arialbarfoo270.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270  center0000ff48Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ff48Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  center0000ff48Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ff48Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  center0000ff48Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ff48Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#0000ff' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  center0000ff48Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar  centerff0000foobar.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar  centerff0000foobar.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -extent 200x200  centerff0000foobar200x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -extent 200x200  centerff0000foobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -extent 200x800  centerff0000foobar200x800.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -extent 200x800  centerff0000foobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -extent 800x200  centerff0000foobar800x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -extent 800x200  centerff0000foobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 0  centerff0000foobar0.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 0  centerff0000foobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 0 -extent 200x200  centerff0000foobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 0 -extent 200x200  centerff0000foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 0 -extent 200x800  centerff0000foobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 0 -extent 200x800  centerff0000foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 0 -extent 800x200  centerff0000foobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 0 -extent 800x200  centerff0000foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 90  centerff0000foobar90.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 90  centerff0000foobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 90 -extent 200x200  centerff0000foobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 90 -extent 200x200  centerff0000foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 90 -extent 200x800  centerff0000foobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 90 -extent 200x800  centerff0000foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 90 -extent 800x200  centerff0000foobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 90 -extent 800x200  centerff0000foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 270  centerff0000foobar270.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 270  centerff0000foobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 270 -extent 200x200  centerff0000foobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 270 -extent 200x200  centerff0000foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 270 -extent 200x800  centerff0000foobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 270 -extent 200x800  centerff0000foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 270 -extent 800x200  centerff0000foobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:foobar -rotate 270 -extent 800x200  centerff0000foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo  centerff0000barfoo.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo  centerff0000barfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -extent 200x200  centerff0000barfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -extent 200x200  centerff0000barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -extent 200x800  centerff0000barfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -extent 200x800  centerff0000barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -extent 800x200  centerff0000barfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -extent 800x200  centerff0000barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 0  centerff0000barfoo0.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 0  centerff0000barfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 0 -extent 200x200  centerff0000barfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 0 -extent 200x200  centerff0000barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 0 -extent 200x800  centerff0000barfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 0 -extent 200x800  centerff0000barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 0 -extent 800x200  centerff0000barfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 0 -extent 800x200  centerff0000barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 90  centerff0000barfoo90.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 90  centerff0000barfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 90 -extent 200x200  centerff0000barfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 90 -extent 200x200  centerff0000barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 90 -extent 200x800  centerff0000barfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 90 -extent 200x800  centerff0000barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 90 -extent 800x200  centerff0000barfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 90 -extent 800x200  centerff0000barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 270  centerff0000barfoo270.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 270  centerff0000barfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 270 -extent 200x200  centerff0000barfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 270 -extent 200x200  centerff0000barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 270 -extent 200x800  centerff0000barfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 270 -extent 200x800  centerff0000barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 270 -extent 800x200  centerff0000barfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000'  label:barfoo -rotate 270 -extent 800x200  centerff0000barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar  centerff0000Arialfoobar.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar  centerff0000Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -extent 200x200  centerff0000Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -extent 200x200  centerff0000Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -extent 200x800  centerff0000Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -extent 200x800  centerff0000Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -extent 800x200  centerff0000Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -extent 800x200  centerff0000Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 0  centerff0000Arialfoobar0.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 0  centerff0000Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 0 -extent 200x200  centerff0000Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 0 -extent 200x200  centerff0000Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 0 -extent 200x800  centerff0000Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 0 -extent 200x800  centerff0000Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 0 -extent 800x200  centerff0000Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 0 -extent 800x200  centerff0000Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 90  centerff0000Arialfoobar90.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 90  centerff0000Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 90 -extent 200x200  centerff0000Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 90 -extent 200x200  centerff0000Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 90 -extent 200x800  centerff0000Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 90 -extent 200x800  centerff0000Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 90 -extent 800x200  centerff0000Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 90 -extent 800x200  centerff0000Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 270  centerff0000Arialfoobar270.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 270  centerff0000Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 270 -extent 200x200  centerff0000Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 270 -extent 200x200  centerff0000Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 270 -extent 200x800  centerff0000Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 270 -extent 200x800  centerff0000Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 270 -extent 800x200  centerff0000Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:foobar -rotate 270 -extent 800x200  centerff0000Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo  centerff0000Arialbarfoo.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo  centerff0000Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -extent 200x200  centerff0000Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -extent 200x200  centerff0000Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -extent 200x800  centerff0000Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -extent 200x800  centerff0000Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -extent 800x200  centerff0000Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -extent 800x200  centerff0000Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 0  centerff0000Arialbarfoo0.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 0  centerff0000Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff0000Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff0000Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff0000Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff0000Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff0000Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff0000Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 90  centerff0000Arialbarfoo90.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 90  centerff0000Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff0000Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff0000Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff0000Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff0000Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff0000Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff0000Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 270  centerff0000Arialbarfoo270.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 270  centerff0000Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff0000Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff0000Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff0000Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff0000Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff0000Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff0000Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar  centerff00008foobar.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar  centerff00008foobar.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -extent 200x200  centerff00008foobar200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -extent 200x200  centerff00008foobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -extent 200x800  centerff00008foobar200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -extent 200x800  centerff00008foobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -extent 800x200  centerff00008foobar800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -extent 800x200  centerff00008foobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 0  centerff00008foobar0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 0  centerff00008foobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 0 -extent 200x200  centerff00008foobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 0 -extent 200x200  centerff00008foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 0 -extent 200x800  centerff00008foobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 0 -extent 200x800  centerff00008foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 0 -extent 800x200  centerff00008foobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 0 -extent 800x200  centerff00008foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 90  centerff00008foobar90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 90  centerff00008foobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 90 -extent 200x200  centerff00008foobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 90 -extent 200x200  centerff00008foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 90 -extent 200x800  centerff00008foobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 90 -extent 200x800  centerff00008foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 90 -extent 800x200  centerff00008foobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 90 -extent 800x200  centerff00008foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 270  centerff00008foobar270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 270  centerff00008foobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 270 -extent 200x200  centerff00008foobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 270 -extent 200x200  centerff00008foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 270 -extent 200x800  centerff00008foobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 270 -extent 200x800  centerff00008foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 270 -extent 800x200  centerff00008foobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:foobar -rotate 270 -extent 800x200  centerff00008foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo  centerff00008barfoo.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo  centerff00008barfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -extent 200x200  centerff00008barfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -extent 200x200  centerff00008barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -extent 200x800  centerff00008barfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -extent 200x800  centerff00008barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -extent 800x200  centerff00008barfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -extent 800x200  centerff00008barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 0  centerff00008barfoo0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 0  centerff00008barfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 0 -extent 200x200  centerff00008barfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 0 -extent 200x200  centerff00008barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 0 -extent 200x800  centerff00008barfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 0 -extent 200x800  centerff00008barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 0 -extent 800x200  centerff00008barfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 0 -extent 800x200  centerff00008barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 90  centerff00008barfoo90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 90  centerff00008barfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 90 -extent 200x200  centerff00008barfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 90 -extent 200x200  centerff00008barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 90 -extent 200x800  centerff00008barfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 90 -extent 200x800  centerff00008barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 90 -extent 800x200  centerff00008barfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 90 -extent 800x200  centerff00008barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 270  centerff00008barfoo270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 270  centerff00008barfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 270 -extent 200x200  centerff00008barfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 270 -extent 200x200  centerff00008barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 270 -extent 200x800  centerff00008barfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 270 -extent 200x800  centerff00008barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 270 -extent 800x200  centerff00008barfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8  label:barfoo -rotate 270 -extent 800x200  centerff00008barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar  centerff00008Arialfoobar.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar  centerff00008Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -extent 200x200  centerff00008Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -extent 200x200  centerff00008Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -extent 200x800  centerff00008Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -extent 200x800  centerff00008Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -extent 800x200  centerff00008Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -extent 800x200  centerff00008Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0  centerff00008Arialfoobar0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0  centerff00008Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  centerff00008Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x200  centerff00008Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  centerff00008Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 200x800  centerff00008Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  centerff00008Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 0 -extent 800x200  centerff00008Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90  centerff00008Arialfoobar90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90  centerff00008Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  centerff00008Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x200  centerff00008Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  centerff00008Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 200x800  centerff00008Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  centerff00008Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 90 -extent 800x200  centerff00008Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270  centerff00008Arialfoobar270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270  centerff00008Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  centerff00008Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x200  centerff00008Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  centerff00008Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 200x800  centerff00008Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  centerff00008Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:foobar -rotate 270 -extent 800x200  centerff00008Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo  centerff00008Arialbarfoo.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo  centerff00008Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -extent 200x200  centerff00008Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -extent 200x200  centerff00008Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -extent 200x800  centerff00008Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -extent 200x800  centerff00008Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -extent 800x200  centerff00008Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -extent 800x200  centerff00008Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0  centerff00008Arialbarfoo0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0  centerff00008Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff00008Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff00008Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff00008Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff00008Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff00008Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff00008Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90  centerff00008Arialbarfoo90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90  centerff00008Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff00008Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff00008Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff00008Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff00008Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff00008Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff00008Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270  centerff00008Arialbarfoo270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270  centerff00008Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff00008Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff00008Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff00008Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff00008Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff00008Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 8 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff00008Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar  centerff000010foobar.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar  centerff000010foobar.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -extent 200x200  centerff000010foobar200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -extent 200x200  centerff000010foobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -extent 200x800  centerff000010foobar200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -extent 200x800  centerff000010foobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -extent 800x200  centerff000010foobar800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -extent 800x200  centerff000010foobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 0  centerff000010foobar0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 0  centerff000010foobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 0 -extent 200x200  centerff000010foobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 0 -extent 200x200  centerff000010foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 0 -extent 200x800  centerff000010foobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 0 -extent 200x800  centerff000010foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 0 -extent 800x200  centerff000010foobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 0 -extent 800x200  centerff000010foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 90  centerff000010foobar90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 90  centerff000010foobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 90 -extent 200x200  centerff000010foobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 90 -extent 200x200  centerff000010foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 90 -extent 200x800  centerff000010foobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 90 -extent 200x800  centerff000010foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 90 -extent 800x200  centerff000010foobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 90 -extent 800x200  centerff000010foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 270  centerff000010foobar270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 270  centerff000010foobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 270 -extent 200x200  centerff000010foobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 270 -extent 200x200  centerff000010foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 270 -extent 200x800  centerff000010foobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 270 -extent 200x800  centerff000010foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 270 -extent 800x200  centerff000010foobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:foobar -rotate 270 -extent 800x200  centerff000010foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo  centerff000010barfoo.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo  centerff000010barfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -extent 200x200  centerff000010barfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -extent 200x200  centerff000010barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -extent 200x800  centerff000010barfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -extent 200x800  centerff000010barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -extent 800x200  centerff000010barfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -extent 800x200  centerff000010barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 0  centerff000010barfoo0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 0  centerff000010barfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 0 -extent 200x200  centerff000010barfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 0 -extent 200x200  centerff000010barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 0 -extent 200x800  centerff000010barfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 0 -extent 200x800  centerff000010barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 0 -extent 800x200  centerff000010barfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 0 -extent 800x200  centerff000010barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 90  centerff000010barfoo90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 90  centerff000010barfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 90 -extent 200x200  centerff000010barfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 90 -extent 200x200  centerff000010barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 90 -extent 200x800  centerff000010barfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 90 -extent 200x800  centerff000010barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 90 -extent 800x200  centerff000010barfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 90 -extent 800x200  centerff000010barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 270  centerff000010barfoo270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 270  centerff000010barfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 270 -extent 200x200  centerff000010barfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 270 -extent 200x200  centerff000010barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 270 -extent 200x800  centerff000010barfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 270 -extent 200x800  centerff000010barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 270 -extent 800x200  centerff000010barfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10  label:barfoo -rotate 270 -extent 800x200  centerff000010barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar  centerff000010Arialfoobar.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar  centerff000010Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -extent 200x200  centerff000010Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -extent 200x200  centerff000010Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -extent 200x800  centerff000010Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -extent 200x800  centerff000010Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -extent 800x200  centerff000010Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -extent 800x200  centerff000010Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0  centerff000010Arialfoobar0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0  centerff000010Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  centerff000010Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x200  centerff000010Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  centerff000010Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 200x800  centerff000010Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  centerff000010Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 0 -extent 800x200  centerff000010Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90  centerff000010Arialfoobar90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90  centerff000010Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  centerff000010Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x200  centerff000010Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  centerff000010Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 200x800  centerff000010Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  centerff000010Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 90 -extent 800x200  centerff000010Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270  centerff000010Arialfoobar270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270  centerff000010Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  centerff000010Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x200  centerff000010Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  centerff000010Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 200x800  centerff000010Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  centerff000010Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:foobar -rotate 270 -extent 800x200  centerff000010Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo  centerff000010Arialbarfoo.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo  centerff000010Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -extent 200x200  centerff000010Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -extent 200x200  centerff000010Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -extent 200x800  centerff000010Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -extent 200x800  centerff000010Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -extent 800x200  centerff000010Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -extent 800x200  centerff000010Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0  centerff000010Arialbarfoo0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0  centerff000010Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff000010Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff000010Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff000010Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff000010Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff000010Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff000010Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90  centerff000010Arialbarfoo90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90  centerff000010Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff000010Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff000010Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff000010Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff000010Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff000010Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff000010Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270  centerff000010Arialbarfoo270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270  centerff000010Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff000010Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff000010Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff000010Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff000010Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff000010Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 10 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff000010Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar  centerff000012foobar.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar  centerff000012foobar.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -extent 200x200  centerff000012foobar200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -extent 200x200  centerff000012foobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -extent 200x800  centerff000012foobar200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -extent 200x800  centerff000012foobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -extent 800x200  centerff000012foobar800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -extent 800x200  centerff000012foobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 0  centerff000012foobar0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 0  centerff000012foobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 0 -extent 200x200  centerff000012foobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 0 -extent 200x200  centerff000012foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 0 -extent 200x800  centerff000012foobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 0 -extent 200x800  centerff000012foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 0 -extent 800x200  centerff000012foobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 0 -extent 800x200  centerff000012foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 90  centerff000012foobar90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 90  centerff000012foobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 90 -extent 200x200  centerff000012foobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 90 -extent 200x200  centerff000012foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 90 -extent 200x800  centerff000012foobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 90 -extent 200x800  centerff000012foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 90 -extent 800x200  centerff000012foobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 90 -extent 800x200  centerff000012foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 270  centerff000012foobar270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 270  centerff000012foobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 270 -extent 200x200  centerff000012foobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 270 -extent 200x200  centerff000012foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 270 -extent 200x800  centerff000012foobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 270 -extent 200x800  centerff000012foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 270 -extent 800x200  centerff000012foobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:foobar -rotate 270 -extent 800x200  centerff000012foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo  centerff000012barfoo.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo  centerff000012barfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -extent 200x200  centerff000012barfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -extent 200x200  centerff000012barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -extent 200x800  centerff000012barfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -extent 200x800  centerff000012barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -extent 800x200  centerff000012barfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -extent 800x200  centerff000012barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 0  centerff000012barfoo0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 0  centerff000012barfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 0 -extent 200x200  centerff000012barfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 0 -extent 200x200  centerff000012barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 0 -extent 200x800  centerff000012barfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 0 -extent 200x800  centerff000012barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 0 -extent 800x200  centerff000012barfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 0 -extent 800x200  centerff000012barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 90  centerff000012barfoo90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 90  centerff000012barfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 90 -extent 200x200  centerff000012barfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 90 -extent 200x200  centerff000012barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 90 -extent 200x800  centerff000012barfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 90 -extent 200x800  centerff000012barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 90 -extent 800x200  centerff000012barfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 90 -extent 800x200  centerff000012barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 270  centerff000012barfoo270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 270  centerff000012barfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 270 -extent 200x200  centerff000012barfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 270 -extent 200x200  centerff000012barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 270 -extent 200x800  centerff000012barfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 270 -extent 200x800  centerff000012barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 270 -extent 800x200  centerff000012barfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12  label:barfoo -rotate 270 -extent 800x200  centerff000012barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar  centerff000012Arialfoobar.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar  centerff000012Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -extent 200x200  centerff000012Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -extent 200x200  centerff000012Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -extent 200x800  centerff000012Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -extent 200x800  centerff000012Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -extent 800x200  centerff000012Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -extent 800x200  centerff000012Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0  centerff000012Arialfoobar0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0  centerff000012Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  centerff000012Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x200  centerff000012Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  centerff000012Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 200x800  centerff000012Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  centerff000012Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 0 -extent 800x200  centerff000012Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90  centerff000012Arialfoobar90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90  centerff000012Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  centerff000012Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x200  centerff000012Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  centerff000012Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 200x800  centerff000012Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  centerff000012Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 90 -extent 800x200  centerff000012Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270  centerff000012Arialfoobar270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270  centerff000012Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  centerff000012Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x200  centerff000012Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  centerff000012Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 200x800  centerff000012Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  centerff000012Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:foobar -rotate 270 -extent 800x200  centerff000012Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo  centerff000012Arialbarfoo.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo  centerff000012Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -extent 200x200  centerff000012Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -extent 200x200  centerff000012Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -extent 200x800  centerff000012Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -extent 200x800  centerff000012Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -extent 800x200  centerff000012Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -extent 800x200  centerff000012Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0  centerff000012Arialbarfoo0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0  centerff000012Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff000012Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff000012Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff000012Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff000012Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff000012Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff000012Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90  centerff000012Arialbarfoo90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90  centerff000012Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff000012Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff000012Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff000012Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff000012Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff000012Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff000012Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270  centerff000012Arialbarfoo270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270  centerff000012Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff000012Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff000012Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff000012Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff000012Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff000012Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 12 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff000012Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar  centerff000018foobar.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar  centerff000018foobar.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -extent 200x200  centerff000018foobar200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -extent 200x200  centerff000018foobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -extent 200x800  centerff000018foobar200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -extent 200x800  centerff000018foobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -extent 800x200  centerff000018foobar800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -extent 800x200  centerff000018foobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 0  centerff000018foobar0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 0  centerff000018foobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 0 -extent 200x200  centerff000018foobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 0 -extent 200x200  centerff000018foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 0 -extent 200x800  centerff000018foobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 0 -extent 200x800  centerff000018foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 0 -extent 800x200  centerff000018foobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 0 -extent 800x200  centerff000018foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 90  centerff000018foobar90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 90  centerff000018foobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 90 -extent 200x200  centerff000018foobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 90 -extent 200x200  centerff000018foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 90 -extent 200x800  centerff000018foobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 90 -extent 200x800  centerff000018foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 90 -extent 800x200  centerff000018foobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 90 -extent 800x200  centerff000018foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 270  centerff000018foobar270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 270  centerff000018foobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 270 -extent 200x200  centerff000018foobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 270 -extent 200x200  centerff000018foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 270 -extent 200x800  centerff000018foobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 270 -extent 200x800  centerff000018foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 270 -extent 800x200  centerff000018foobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:foobar -rotate 270 -extent 800x200  centerff000018foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo  centerff000018barfoo.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo  centerff000018barfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -extent 200x200  centerff000018barfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -extent 200x200  centerff000018barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -extent 200x800  centerff000018barfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -extent 200x800  centerff000018barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -extent 800x200  centerff000018barfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -extent 800x200  centerff000018barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 0  centerff000018barfoo0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 0  centerff000018barfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 0 -extent 200x200  centerff000018barfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 0 -extent 200x200  centerff000018barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 0 -extent 200x800  centerff000018barfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 0 -extent 200x800  centerff000018barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 0 -extent 800x200  centerff000018barfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 0 -extent 800x200  centerff000018barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 90  centerff000018barfoo90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 90  centerff000018barfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 90 -extent 200x200  centerff000018barfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 90 -extent 200x200  centerff000018barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 90 -extent 200x800  centerff000018barfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 90 -extent 200x800  centerff000018barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 90 -extent 800x200  centerff000018barfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 90 -extent 800x200  centerff000018barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 270  centerff000018barfoo270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 270  centerff000018barfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 270 -extent 200x200  centerff000018barfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 270 -extent 200x200  centerff000018barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 270 -extent 200x800  centerff000018barfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 270 -extent 200x800  centerff000018barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 270 -extent 800x200  centerff000018barfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18  label:barfoo -rotate 270 -extent 800x200  centerff000018barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar  centerff000018Arialfoobar.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar  centerff000018Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -extent 200x200  centerff000018Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -extent 200x200  centerff000018Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -extent 200x800  centerff000018Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -extent 200x800  centerff000018Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -extent 800x200  centerff000018Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -extent 800x200  centerff000018Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0  centerff000018Arialfoobar0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0  centerff000018Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  centerff000018Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x200  centerff000018Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  centerff000018Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 200x800  centerff000018Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  centerff000018Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 0 -extent 800x200  centerff000018Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90  centerff000018Arialfoobar90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90  centerff000018Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  centerff000018Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x200  centerff000018Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  centerff000018Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 200x800  centerff000018Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  centerff000018Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 90 -extent 800x200  centerff000018Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270  centerff000018Arialfoobar270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270  centerff000018Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  centerff000018Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x200  centerff000018Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  centerff000018Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 200x800  centerff000018Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  centerff000018Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:foobar -rotate 270 -extent 800x200  centerff000018Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo  centerff000018Arialbarfoo.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo  centerff000018Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -extent 200x200  centerff000018Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -extent 200x200  centerff000018Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -extent 200x800  centerff000018Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -extent 200x800  centerff000018Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -extent 800x200  centerff000018Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -extent 800x200  centerff000018Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0  centerff000018Arialbarfoo0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0  centerff000018Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff000018Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff000018Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff000018Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff000018Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff000018Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff000018Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90  centerff000018Arialbarfoo90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90  centerff000018Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff000018Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff000018Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff000018Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff000018Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff000018Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff000018Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270  centerff000018Arialbarfoo270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270  centerff000018Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff000018Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff000018Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff000018Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff000018Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff000018Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 18 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff000018Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar  centerff000024foobar.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar  centerff000024foobar.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -extent 200x200  centerff000024foobar200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -extent 200x200  centerff000024foobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -extent 200x800  centerff000024foobar200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -extent 200x800  centerff000024foobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -extent 800x200  centerff000024foobar800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -extent 800x200  centerff000024foobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 0  centerff000024foobar0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 0  centerff000024foobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 0 -extent 200x200  centerff000024foobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 0 -extent 200x200  centerff000024foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 0 -extent 200x800  centerff000024foobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 0 -extent 200x800  centerff000024foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 0 -extent 800x200  centerff000024foobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 0 -extent 800x200  centerff000024foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 90  centerff000024foobar90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 90  centerff000024foobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 90 -extent 200x200  centerff000024foobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 90 -extent 200x200  centerff000024foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 90 -extent 200x800  centerff000024foobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 90 -extent 200x800  centerff000024foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 90 -extent 800x200  centerff000024foobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 90 -extent 800x200  centerff000024foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 270  centerff000024foobar270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 270  centerff000024foobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 270 -extent 200x200  centerff000024foobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 270 -extent 200x200  centerff000024foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 270 -extent 200x800  centerff000024foobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 270 -extent 200x800  centerff000024foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 270 -extent 800x200  centerff000024foobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:foobar -rotate 270 -extent 800x200  centerff000024foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo  centerff000024barfoo.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo  centerff000024barfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -extent 200x200  centerff000024barfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -extent 200x200  centerff000024barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -extent 200x800  centerff000024barfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -extent 200x800  centerff000024barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -extent 800x200  centerff000024barfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -extent 800x200  centerff000024barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 0  centerff000024barfoo0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 0  centerff000024barfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 0 -extent 200x200  centerff000024barfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 0 -extent 200x200  centerff000024barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 0 -extent 200x800  centerff000024barfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 0 -extent 200x800  centerff000024barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 0 -extent 800x200  centerff000024barfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 0 -extent 800x200  centerff000024barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 90  centerff000024barfoo90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 90  centerff000024barfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 90 -extent 200x200  centerff000024barfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 90 -extent 200x200  centerff000024barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 90 -extent 200x800  centerff000024barfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 90 -extent 200x800  centerff000024barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 90 -extent 800x200  centerff000024barfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 90 -extent 800x200  centerff000024barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 270  centerff000024barfoo270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 270  centerff000024barfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 270 -extent 200x200  centerff000024barfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 270 -extent 200x200  centerff000024barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 270 -extent 200x800  centerff000024barfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 270 -extent 200x800  centerff000024barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 270 -extent 800x200  centerff000024barfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24  label:barfoo -rotate 270 -extent 800x200  centerff000024barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar  centerff000024Arialfoobar.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar  centerff000024Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -extent 200x200  centerff000024Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -extent 200x200  centerff000024Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -extent 200x800  centerff000024Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -extent 200x800  centerff000024Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -extent 800x200  centerff000024Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -extent 800x200  centerff000024Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0  centerff000024Arialfoobar0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0  centerff000024Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  centerff000024Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x200  centerff000024Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  centerff000024Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 200x800  centerff000024Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  centerff000024Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 0 -extent 800x200  centerff000024Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90  centerff000024Arialfoobar90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90  centerff000024Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  centerff000024Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x200  centerff000024Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  centerff000024Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 200x800  centerff000024Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  centerff000024Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 90 -extent 800x200  centerff000024Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270  centerff000024Arialfoobar270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270  centerff000024Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  centerff000024Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x200  centerff000024Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  centerff000024Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 200x800  centerff000024Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  centerff000024Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:foobar -rotate 270 -extent 800x200  centerff000024Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo  centerff000024Arialbarfoo.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo  centerff000024Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -extent 200x200  centerff000024Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -extent 200x200  centerff000024Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -extent 200x800  centerff000024Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -extent 200x800  centerff000024Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -extent 800x200  centerff000024Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -extent 800x200  centerff000024Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0  centerff000024Arialbarfoo0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0  centerff000024Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff000024Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff000024Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff000024Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff000024Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff000024Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff000024Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90  centerff000024Arialbarfoo90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90  centerff000024Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff000024Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff000024Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff000024Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff000024Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff000024Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff000024Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270  centerff000024Arialbarfoo270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270  centerff000024Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff000024Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff000024Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff000024Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff000024Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff000024Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 24 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff000024Arialbarfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar  centerff000048foobar.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar  centerff000048foobar.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -extent 200x200  centerff000048foobar200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -extent 200x200  centerff000048foobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -extent 200x800  centerff000048foobar200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -extent 200x800  centerff000048foobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -extent 800x200  centerff000048foobar800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -extent 800x200  centerff000048foobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 0  centerff000048foobar0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 0  centerff000048foobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 0 -extent 200x200  centerff000048foobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 0 -extent 200x200  centerff000048foobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 0 -extent 200x800  centerff000048foobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 0 -extent 200x800  centerff000048foobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 0 -extent 800x200  centerff000048foobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 0 -extent 800x200  centerff000048foobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 90  centerff000048foobar90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 90  centerff000048foobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 90 -extent 200x200  centerff000048foobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 90 -extent 200x200  centerff000048foobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 90 -extent 200x800  centerff000048foobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 90 -extent 200x800  centerff000048foobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 90 -extent 800x200  centerff000048foobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 90 -extent 800x200  centerff000048foobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 270  centerff000048foobar270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 270  centerff000048foobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 270 -extent 200x200  centerff000048foobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 270 -extent 200x200  centerff000048foobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 270 -extent 200x800  centerff000048foobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 270 -extent 200x800  centerff000048foobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 270 -extent 800x200  centerff000048foobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:foobar -rotate 270 -extent 800x200  centerff000048foobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo  centerff000048barfoo.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo  centerff000048barfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -extent 200x200  centerff000048barfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -extent 200x200  centerff000048barfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -extent 200x800  centerff000048barfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -extent 200x800  centerff000048barfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -extent 800x200  centerff000048barfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -extent 800x200  centerff000048barfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 0  centerff000048barfoo0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 0  centerff000048barfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 0 -extent 200x200  centerff000048barfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 0 -extent 200x200  centerff000048barfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 0 -extent 200x800  centerff000048barfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 0 -extent 200x800  centerff000048barfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 0 -extent 800x200  centerff000048barfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 0 -extent 800x200  centerff000048barfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 90  centerff000048barfoo90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 90  centerff000048barfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 90 -extent 200x200  centerff000048barfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 90 -extent 200x200  centerff000048barfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 90 -extent 200x800  centerff000048barfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 90 -extent 200x800  centerff000048barfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 90 -extent 800x200  centerff000048barfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 90 -extent 800x200  centerff000048barfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 270  centerff000048barfoo270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 270  centerff000048barfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 270 -extent 200x200  centerff000048barfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 270 -extent 200x200  centerff000048barfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 270 -extent 200x800  centerff000048barfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 270 -extent 200x800  centerff000048barfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 270 -extent 800x200  centerff000048barfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48  label:barfoo -rotate 270 -extent 800x200  centerff000048barfoo270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar  centerff000048Arialfoobar.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar  centerff000048Arialfoobar.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -extent 200x200  centerff000048Arialfoobar200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -extent 200x200  centerff000048Arialfoobar200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -extent 200x800  centerff000048Arialfoobar200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -extent 200x800  centerff000048Arialfoobar200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -extent 800x200  centerff000048Arialfoobar800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -extent 800x200  centerff000048Arialfoobar800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0  centerff000048Arialfoobar0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0  centerff000048Arialfoobar0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  centerff000048Arialfoobar0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x200  centerff000048Arialfoobar0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  centerff000048Arialfoobar0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 200x800  centerff000048Arialfoobar0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  centerff000048Arialfoobar0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 0 -extent 800x200  centerff000048Arialfoobar0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90  centerff000048Arialfoobar90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90  centerff000048Arialfoobar90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  centerff000048Arialfoobar90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x200  centerff000048Arialfoobar90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  centerff000048Arialfoobar90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 200x800  centerff000048Arialfoobar90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  centerff000048Arialfoobar90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 90 -extent 800x200  centerff000048Arialfoobar90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270  centerff000048Arialfoobar270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270  centerff000048Arialfoobar270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  centerff000048Arialfoobar270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x200  centerff000048Arialfoobar270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  centerff000048Arialfoobar270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 200x800  centerff000048Arialfoobar270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  centerff000048Arialfoobar270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:foobar -rotate 270 -extent 800x200  centerff000048Arialfoobar270800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo  centerff000048Arialbarfoo.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo  centerff000048Arialbarfoo.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -extent 200x200  centerff000048Arialbarfoo200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -extent 200x200  centerff000048Arialbarfoo200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -extent 200x800  centerff000048Arialbarfoo200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -extent 200x800  centerff000048Arialbarfoo200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -extent 800x200  centerff000048Arialbarfoo800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -extent 800x200  centerff000048Arialbarfoo800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0  centerff000048Arialbarfoo0.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0  centerff000048Arialbarfoo0.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff000048Arialbarfoo0200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x200  centerff000048Arialbarfoo0200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff000048Arialbarfoo0200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 200x800  centerff000048Arialbarfoo0200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff000048Arialbarfoo0800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 0 -extent 800x200  centerff000048Arialbarfoo0800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90  centerff000048Arialbarfoo90.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90  centerff000048Arialbarfoo90.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff000048Arialbarfoo90200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x200  centerff000048Arialbarfoo90200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff000048Arialbarfoo90200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 200x800  centerff000048Arialbarfoo90200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff000048Arialbarfoo90800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 90 -extent 800x200  centerff000048Arialbarfoo90800x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270  centerff000048Arialbarfoo270.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270  centerff000048Arialbarfoo270.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff000048Arialbarfoo270200x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x200  centerff000048Arialbarfoo270200x200.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff000048Arialbarfoo270200x800.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 200x800  centerff000048Arialbarfoo270200x800.gif
echo '

convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff000048Arialbarfoo270800x200.gif'
convert -verbose -gravity center -background '#ff0000' -pointsize 48 -font Arial  label:barfoo -rotate 270 -extent 800x200  centerff000048Arialbarfoo270800x200.gif
