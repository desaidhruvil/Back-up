echo -e "-----------------------------      \e[31m Processing of back-up start\e[0m    ------------------------------"
sleep 1

Blue="34"
intalic="\e[3;${Blue}m"
END="\e[0m"

echo -e "${intalic}"
banner BaCk-Up
echo -e "${END}"

sleep 1


if [ ! -d "$HOME/.ssh" ] 
then
    echo "Directory $HOME/.ssh DOES NOT exists." 
    echo "Creating directory......"
    mkdir $HOME/.ssh
fi

filename="Back_up_`date +%d_%m_%y_%H_%M_%S`.tar"
echo "Enter the path where you want to copy your back-up locally :"
read lpath
if [ ! -d $lpath ]; then mkdir -p $lpath;fi
echo "Enter the path of directry which you want to back-up :"
read fpath

echo "Enter your remoet machine name and ip (for example:kali@ip) :"
read remoet
echo "Enter the path where you want to copy your back-up remort machice :"
read rpath

if [ ! -d $HOME/.ssh ]
then

ssh-keygen -q -N "" -f $HOME/.ssh/id_rsa
cd $HOME/.ssh
ssh-copy-id -i id_rsa.pub ${remoet}
elif [ -e $HOME/dhruvil/.ssh ]
then
cd $HOME/dhruvil/.ssh
ssh-copy-id -i id_rsa.pub ${remoet}

fi

tar -cvf ${lpath}/${filename}  ${fpath}
read -p "are you want to automate your this back (y/n) : " ans

if [ $ans == 'y' ]
then
    
    echo -e "tar -cvf ${lpath}/Back_up_\`date +%d_%m_%y_%H_%M_%S\`.tar  ${fpath}" > ${lpath}/temp.sh
    echo -e "scp ${lpath}/Back_up_\`date +%d_%m_%y_%H_%M_%S\`.tar ${remoet}:${rpath}" >> ${lpath}/temp.sh
    chmod +x ${lpath}/temp.sh
    sleep 1
    echo -e "Set a time for back-up\n"
    
    echo -e "Set a time in following sequance [minunte hour day month week]\n"
    sleep 1
    echo -e "for know more how to set visit : https://crontab.guru/# "
    
    sleep 2
    
    read -p "set a time for back-up : " back
    echo -e "${back}"
    echo -e "${back} ${lpath}/temp.sh" | crontab - 
    echo -e "your back-up set `crontab -l` "
    echo -e "your back up time is set"
else
    echo "thank you, youer back-up is successfully taken"
fi


scp ${lpath}/${filename} ${remoet}:${rpath}

echo -e "-------------------------------         \e[31m Successfully done back-up\e[0m     --------------------------------------------"
