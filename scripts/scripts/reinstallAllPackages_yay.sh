
#!/bin/bash

yay -Q | awk '{ print $1 }' > installed.tmp
for i in $(yay -Qm | awk '{ print $1 }'); do
    cat installed.tmp | sed "s/^$i\$//;" > installed.tmp.1
    mv installed.tmp.1 installed.tmp
done
yay -S --noconfirm `cat installed.tmp`
rm installed.tmp

# #!/bin/bash
# pacman -Q | awk '{ print $1 }' > installed.tmp
# for pkgName in $(cat installed.tmp)
# do
#   pacman -S --force --noconfirm $pkgName
# done
# rm installed.tmp
echo "Reinstalled all packages."
