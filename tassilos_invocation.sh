#!/bin/bash

# rm -rf testdata/2del/*

# create the output directory (and parents):


# get help on the following parameters: «python ./lazyblorg.py --help»

# when setting up your own system, you might want to:
# 1. have separate directories for generating your blog and staging/publishing your blog
# 2. rename everything with «2del» to an appropriate name
# 3. copy generated blog data to staging/publishing directory
# 4. point --previous-metadata to the corresponding pk-file in your staging/publishing directory
# 5. modify --orgfiles so that your org-mode files are parsed
#    don't forget to include your version of «about-placeholder.org» and «blog-format.org»

PYTHONPATH="$HOME/repos/lazyblorg" #not sure whether this has any purpose
blogpath="$HOME/repos/thoughts/"
set -e
cd $PYTHONPATH || (echo "$blogpath was not found aborted running the lazyblorg script"; exit)

rgrep ":blog:" ~/org-roam/* | awk -F ':' '{print $1}' | uniq | paste -d " " | tee /dev/tty | xargs "$PYTHONPATH/lazyblorg.py" \
    --targetdir ~/repos/thoughts/ \
    --previous-metadata ~/repos/thoughts/metadata.pk \
    --new-metadata ~/repos/thoughts/metadata.pk \
    --logfile ~/repos/lazyblorg/2del-logfile.org \
    --orgfiles testdata/end_to_end_test/orgfiles/about-placeholder.org | tee /dev/tty | grep Generated | awk '{print $3}'

cd "$blogpath" || (echo "$blogpath was not found aborted staging changes"; exit) 
echo "staging and pushing changes to remote..."
git add --all
git commit -m "Update blog"
git push origin

#TODO only push and commit if there are substantial changes
#TODO check for major mishaps
#TODO investigate whether blogposts were removed and ask if this was intentional.




#END
