#!/bin/zsh
 #preview_blogentry.sh


## check for host name and show warning when not my own host:
##[ "x${HOSTNAME}" = "xfloyd" -o "x${HOSTNAME}" = "xsting" ] || warn_and_exit

cd ~/repos/lazyblorg
rm -rf testdata/2del/*
mkdir testdata/2del/blog

PYTHONPATH="$HOME/repos/lazyblorg"

"$PYTHONPATH/lazyblorg.py" --quiet \
    --ignore-missing-ids \
    --targetdir testdata/2del/blog \
    --previous-metadata NONEXISTING-preview-metadata-REPLACE_WITH_YOUR_PREVIOUS_METADATA_FILE.pk \
    --new-metadata testdata/2del/blog/preview-metadata.pk \
    --logfile testdata/2del/errors.org \
    --orgfiles templates/blog-format.org\
 testdata/end_to_end_test/orgfiles/about-placeholder.org \
 /tmp/lazyblorg-preview.org;
# xdg-open "/home/tassilo/repos/lazyblorg/testdata/2del/blog/index.html"
# output=$(find testdata/2del/ -name '*.html' -exec xdg-open "{}" \; 2>&1)
# echo "$output" > /tmp/xdg-open.log
find testdata/2del -name '*.html' \
  -not -path 'testdata/2del/blog/tags/*' \
  -a -not -path 'testdata/2del/blog/about/*' \
  -a -not -path 'testdata/2del/blog/how-to-use-this-blog/*' \
  -a -not -path 'testdata/2del/blog/2016/*' \
  -a -not -wholename 'testdata/2del/blog/index.html' \
  -exec firefox "{}" \;
    #I'm not sure what the \; is for, but it makes -exec work don't mess with it future me.

#end
