dir=~/dotfiles
olddir=~/dotfiles_old
files="bash_profile bashrc vimrc custom_git_completion git-completion.bash"
mkdir -p $olddir
for file in $files; do
  echo $file
  mv ~/.$file $olddir
  ln -s $dir/$file ~/.$file
done
cd $dir

echo "done"
