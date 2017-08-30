# setup some variables
dir=~/dotfiles
olddir=~/dotfiles_old
files="bash_profile custom_git_completion git-completion.bash bash-git-prompt"

# clone bash git prompt
cd ~
git clone https://github.com/magicmonty/bash-git-prompt.git $dir/bash-git-prompt

# create backup dir
mkdir -p $olddir

# create symlinks
for file in $files; do
  echo $file
  mv ~/.$file $olddir
  ln -s $dir/$file ~/.$file
done

# go back to dotfiles dir
cd $dir

echo "done"
