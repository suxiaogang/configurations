When you open up your Git Bash, you should be by default in your home directory. Now create the .bashrc file (if on Win7 the file should be named .bashrc.). If you're not in the home directory change into it with:

    cd
You can create the file with:

    touch .bashrc
Then edit it with vim or you could try doing it with some windows editor, but i don't recommend it, because of some text formatting issues.

    vim .bashrc
Change to Insert Mode by hitting the i key.

Add your alias:

    alias gs='git status'
Exit the insert mode with ESC. And save-then-close your file with the following :wqEnter.

Finally source the file our open a new git bash.

    source .bashrc
