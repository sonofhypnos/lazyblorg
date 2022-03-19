 #!/bin/zsh
 #preview_blogentry.sh


## check for host name and show warning when not my own host:
##[ "x${HOSTNAME}" = "xfloyd" -o "x${HOSTNAME}" = "xsting" ] || warn_and_exit

cd ~/repos/lazyblorg
rm -rf testdata/2del/*
mkdir testdata/2del/blog

## This script provides a quick preview of the current blog entry in your local browser.
## You will need a LISP function similar to the one below:
##
##    (defun my-lazyblorg-test()
## 	"Saves current blog entry to file and invoke lazyblorg process with it"
## 	(interactive)
## 	(save-excursion
## 	  (search-backward ":blog:");; search begin of current (previous) blog entry
## 	  (beginning-of-line nil)
## 	  (set-mark-command nil);; set mark
## 	  (org-cycle);; close org-mode heading and sub-headings
## 	  (next-line);; goto next org-mode heading (this should be next line after blog entry)
## 	  (beginning-of-line nil)
## 	  (let ((p (point));; copy region
## 		(m (mark)))
## 	    (if (< p m)
## 		(kill-ring-save p m)
## 	      (kill-ring-save m p)))
## 	  (find-file "/tmp/lazyblorg-preview.org");; hard coded temporary file (will be overwritten)
## 	  (erase-buffer);; I told you!
## 	  (yank);; paste region from above
## 	  (save-buffer);; save to disk
## 	  (kill-buffer "lazyblorg-preview.org");; destroy last evidence
## 	  (previous-line);;
## 	  (org-cycle);; close org-mode heading and sub-headings
## 	  ;; invoke lazyblorg:
## 	  (shell-command-to-string "/home/vk/src/lazyblorg/preview_blogentry.sh");; invoke shell script
## 	  )
## 	)

PYTHONPATH="$HOME/repos/lazyblorg"

"$PYTHONPATH/lazyblorg.py" --quiet \
    --ignore-missing-ids \
    --targetdir testdata/2del/blog \
    --previous-metadata NONEXISTING-preview-metadata-REPLACE_WITH_YOUR_PREVIOUS_METADATA_FILE.pk \
    --new-metadata testdata/2del/blog/preview-metadata.pk \
    --logfile testdata/2del/errors.org \
    --orgfiles /home/tassilo/org-roam/20210502170155-project_blog_writing.org\
    /home/tassilo/org-roam/blog-format.org\
    /home/tassilo/org-roam/lazyblorg_manual.org\
    /home/tassilo/org-roam/notes.org\
    /home/tassilo/org-roam/the_pragmatist_s_guide_to_live.org\
    /home/tassilo/org-roam/20210508185546-things_to_write_about.org\
    /home/tassilo/org-roam/information_all_the_way_down.org\
    /tmp/lazyblorg-preview.org && find testdata/2del -name '*.html' -exec xdg-open "{}" \;
    #I'm not sure what the \; is for, but it makes -exec work don't mess with it future me.

#end
