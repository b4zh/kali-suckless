## Renombrando directorios
path_ks=$(pwd)

dirs_en=$(grep "^XDG" ~/.config/user-dirs.dirs | cut -d"/" -f2 | sed 's/"//g' | xargs)
num_dirs=$(echo $dirs_en | wc -w)
LC_ALL=es_ES.UTF-8 xdg-user-dirs-update --force
dirs_es=$(grep "^XDG" ~/.config/user-dirs.dirs | cut -d"/" -f2 | sed 's/"//g' | xargs)
dir1=
dir2=

for i in $(seq 1 $num_dirs); do
	dir1=$(printf "%s\n%s\n" "$dirs_en" "$dirs_es" | cut -d" " -f$i | xargs | awk '{print $1}')
	dir2=$(printf "%s\n%s\n" "$dirs_en" "$dirs_es" | cut -d" " -f$i | xargs | awk '{print $2}')
	rmdir -v ~/$dir1 2>/dev/null || (mv -v ~/$dir1/* ~/$dir2 && rmdir -v ~/$dir1)
done;
