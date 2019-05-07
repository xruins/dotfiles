# change directory with ghq and fzf
function _fzf_change_directory
    if [ (count $argv) ]
        fzf --query "$argv " | perl -pe 's/([ ()])/\\\\$1/g' | read foo
    else
        fzf | perl -pe 's/([ ()])/\\\\$1/g' | read foo
    end
    if [ $foo ]
        cd $foo
    else
        commandline ''
    end
end
function fzf_change_directory
    begin
        echo $HOME/Documents
        echo $HOME/Desktop
        echo $HOME/.config
        # ls -ad */|perl -pe "s#^#$PWD/#"|egrep -v "^$PWD/\."|head -n 5
        sort -r -t '|' -k 3 ~/.z | sed -e 's/\|.*//'
        ghq list -p
        # ls -ad */|perl -pe "s#^#$PWD/#"|grep -v \.git
    end | sed -e 's/\/$//' | awk '!a[$0]++' | _fzf_change_directory $argv
end
