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

PYTHONPATH="~/repos/lazyblorg:" #not sure whether this has any purpose
blogpath="$HOME/repos/thoughts/"

rgrep ":blog:" ~/org-roam/* | awk -F ':' '{print $1}' | uniq | paste -d " " | xargs ./lazyblorg.py \
    --targetdir ~/repos/thoughts/ \
    --previous-metadata ~/repos/thoughts/metadata.pk \
    --new-metadata ~/repos/thoughts/metadata.pk \
    --logfile ~/repos/lazyblorg/2del-logfile.org \
    --orgfiles testdata/end_to_end_test/orgfiles/about-placeholder.org \

cd "$blogpath" || (echo "$blogpath was not found aborted staging changes"; exit) 
echo "staging and pushing changes to remote..."
git commit --all -m "Update blog"
git push origin





#END
