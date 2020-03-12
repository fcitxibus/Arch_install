#!/bin/bash
# Author: Auroot/BaSierl
# QQ： 2763833502
# Description： Arch Linux 安装脚本 
# URL Blog： https://basierl.github.io
# URL GitHub： https://github.com/BaSierL/arch_install.git
# URL Gitee ： https://gitee.com/auroot/arch_install.git

# 给予mirrorlist.sh执行权限，否则将我发导入源。

null="/dev/null"
#----------下载需要的脚本----------#
curl -fsSL https://gitee.com/auroot/Arch_install/raw/master/mirrorlist.sh > mirrorlist.sh


#====脚本颜色变量-------------#
r='\033[1;31m'	#---红
g='\033[1;32m'	#---绿
y='\033[1;33m'	#---黄
b='\033[1;36m'	#---蓝
w='\033[1;37m'	#---白
#-----------------------------#
rw='\033[1;41m'    #--红白
wg='\033[1;42m'    #--白绿
ws='\033[1;43m'    #--白褐
wb='\033[1;44m'    #--白蓝
wq='\033[1;45m'    #--白紫
wa='\033[1;46m'    #--白青
wh='\033[1;46m'    #--白灰
h='\033[0m'		   #---后缀
bx='\033[1;4;36m'  #---蓝 下划线
wy='\033[1;41m' 
h='\033[0m'
#-----------------------------#
# 交互 蓝
JHB=$(echo -e "${b}-=>${h}")
# 交互 红
JHR=$(echo -e "${r}-=>${h}")
# 交互 绿
JHG=$(echo -e "${g}-=>${h}")
# 交互 黄
JHY=$(echo -e "${y}-=>${h}")
#-----------------------------
# 提示 蓝
PSB=$(echo -e "${b} ::==>${h}")
# 提示 红
PSR=$(echo -e "${r} ::==>${h}")
# 提示 绿
PSG=$(echo -e "${g} ::==>${h}")
# 提示 黄
PSY=$(echo -e "${y} ::==>${h}")
#-----------------------------

#========变量值

clear;
ECHOA=`echo -e "${w}    _             _       _     _                  ${h}"`  
ECHOB=`echo -e "${g}   / \   _ __ ___| |__   | |   (_)_ __  _   ___  _        ${h}"` 
ECHOC=`echo -e "${b}  / _ \ | '__/ __| '_ \  | |   | | '_ \| | | \ \/ /         ${h}"` 
ECHOD=`echo -e "${y} / ___ \| | | (__| | | | | |___| | | | | |_| |>  <           ${h}"`  
ECHOE=`echo -e "${r}/_/   \_\_|  \___|_| |_| |_____|_|_| |_|\__,_/_/\_\                ${h}"`
echo -e "$ECHOA\n$ECHOB\n$ECHOC\n$ECHOD\n$ECHOE" | lolcat 2> ${null} || echo -e "$ECHOA\n$ECHOB\n$ECHOC\n$ECHOD\n$ECHOE"

# 文件位置变量
tmps="$PWD/arch_tmp"
# mirrorlist.sh 脚本位置
MIRROR_SH="$PWD/mirrorlist.sh"
chmod +x $PWD/mirrorlist.sh 2&>${null}

# 位置
LIST_IN="$PWD/$0"
# 初始密码
PASS="123456"
#systemctl start dhcpcd &> ${null}


#========网络变量
#有线
ETHERNET=`ip link | grep 'enp[0-9]s[0-9]' |  grep -v 'grep' | awk '{print $2}' | cut -d":" -f1`  
#无线
WIFI=`ip link | grep 'wlp[0-9]s[0-9]' | grep -v 'grep' | awk '{print $2}' | cut -d":" -f1`   

#WIFI_IP=`ifconfig ${WIFI} &> $null || echo "--.--.--.--" && ifconfig ${WIFI} | grep ./a"inet " |  awk '{print $2}'`
#ETHERNET_IP=`ifconfig ${ETHERNET} &> $null || echo "--.--.--.--" && ifconfig ${ETHERNET} | grep "inet " |  awk '{print $2}'`

ETHERNET_IP=`ip route | grep "${ETHERNET}" &> ${null} && ip route list | grep "${ETHERNET}" | cut -d" " -f9 | sed -n '2,1p'`  
WIFI_IP=`ip route | grep ${WIFI} &> ${null} && ip route list | grep ${WIFI} |  cut -d" " -f9 | sed -n '2,1p'`



#========选项
echo -e "${b}||====================================================================||${h}"
echo -e "${b}|| Script Name:        Arch Linux system installation script.        ${h}"  
echo -e "${b}|| Author:             Auroot                                        ${h}"
echo -e "${b}|| GitHub:	       ${bx}https://github.com/BaSierL/arch_install${h}        ${h}"
echo -e "${g}|| Ethernet:           ${ETHERNET_IP:-No_network..}                                  ${h}"
echo -e "${g}|| WIFI:	       ${WIFI_IP:-No_network.}                                   ${h}"
echo -e "${g}|| SSH:                ssh $USER@${ETHERNET_IP:-IP_Addess.}                         ${h}"
echo -e "${g}|| SSH:                ssh $USER@${WIFI_IP:-IP_Addess.}                         ${h}"
echo -e "${g}||====================================================================||${h}"
echo;
echo -e "${PSB} ${g}Configure Mirrorlist   [1]${h}"
echo -e "${PSB} ${g}Configure Network      [2]${h}"
echo -e "${PSG} ${g}Configure SSH          [3]${h}"
echo -e "${PSY} ${g}Install System         [4]${h}"
echo -e "${PSG} ${g}Exit Script            [Q]${h}"
echo;
READS_A=$(echo -e "${PSG} ${y}What are the tasks[1,2,3..]${h} ${JHB} ")
read -p "${READS_A}" principal_variable

#
#========ArchLinux Mirrorlist 配置镜像源  1 

PACMANCONF_FILE="/etc/pacman.conf"
MIRRORLIST_FILE="/etc/pacman.d/mirrorlist"
if [[ ${principal_variable} == 1 ]]; then
    echo ;
    # 检查"/etc/pacman.conf"文件是否存在
    if [ -e ${PACMANCONF_FILE}  ] ; then
        # 如果存在
        sh ${MIRROR_SH}  || curl -fsSL https://gitee.com/auroot/Arch_install/raw/master/mirrorlist.sh > mirrorlist.sh  && sh ${MIRROR_SH}
    else
        # 如果不存在
        touch ${PACMANCONF_FILE} &&  sh ${MIRROR_SH} || curl -fsSL https://gitee.com/auroot/Arch_install/raw/master/mirrorlist.sh > mirrorlist.sh  && sh ${MIRROR_SH}
    fi
    # 检查"/etc/pacman.d/mirrorlist"文件是否存在
    if [ -e ${MIRRORLIST_FILE}  ] ; then    
        # 如果存在
        sh ${MIRROR_SH} || curl -fsSL https://gitee.com/auroot/Arch_install/raw/master/mirrorlist.sh > mirrorlist.sh  && sh ${MIRROR_SH}
    else
        # 如果不存在
        touch ${MIRRORLIST_FILE} && sh ${MIRROR_SH} || curl -fsSL https://gitee.com/auroot/Arch_install/raw/master/mirrorlist.sh > mirrorlist.sh  && sh ${MIRROR_SH}
    fi
    bash ${0}
fi

#========检查网络  2
if [[ ${principal_variable} == 2 ]]; then
    echo;
    echo ":: Checking the currently available network."
    sleep 2
    echo -e ":: Ethernet: ${r}${ETHERNET}${h}" 2> $null
    echo -e ":: Wifi:   ${r}${WIFI}${h}" 2> $null 

    READS_B=$(echo -e "${PSG} ${y}Query Network: Ethernet[1] Wifi[2] Exit[3]? ${h}${JHB} ")
    read -p "${READS_B}" wlink
        case $wlink in
            1) 
                echo ":: One moment please............"
                ls /usr/bin/ifconfig &> $null && echo ":: Install net-tools" ||  echo "y" |  pacman -S ifconfig
                ip link set ${ETHERNET} up
                ifconfig ${ETHERNET} up
                systemctl restart dhcpcd  &&  ping -c 3 14.215.177.38 
                sleep 1
                bash ${0}    
            ;;
            2) 
                echo;
                wifi-menu &&  ping  -c 3 14.215.177.38
                sleep 1 
                bash ${0}
                #echo ":: The following WiFi is available: "
                #iwlist ${WIFI} scan | grep "ESSID:"
            ;;
            3) 
                bash ${0}
            ;;
        esac
fi
#
##========开启SSH 3
if [[ ${principal_variable} == 3 ]]; then
    clear
    echo
    echo -e "${y}:: Setting Username / password.${h}"
    echo ${USER}:${PASS} | chpasswd &> $null

    echo -e "${g} ||=================================||${h}"
    echo -e "${g} || $ ssh $USER@${ETHERNET_IP:-IP_Addess..}          ||${h}"
    echo -e "${g} || $ ssh $USER@${WIFI_IP:-IP_Addess..}          ||${h}"
    echo -e "${g} || Username --=>  $USER             ||${h}"
    echo -e "${g} || Password --=>  $PASS           ||${h}"
    echo -e "${g} ||=================================||${h}"

        systemctl start sshd.service
        netstat -antp | grep sshd

fi

##======== 安装ArchLinux    选项4 ==========================================
if [[ ${principal_variable} == 4 ]];then
#
    echo
    echo -e "     ${w}***${h} ${r}Install System Modular${h} ${w}***${h}  "
    echo "---------------------------------------------"
    echo -e "${PSY} ${g}   Disk partition.         ${h}${r}**${h}  ${w}[1]${h}"
    echo -e "${PSY} ${g}   Install System Files.   ${h}${r}**${h}  ${w}[2]${h}"
    echo -e "${PSG} ${g}   Installation Drive.     ${h}${b}*${h}   ${w}[3]${h}"    
    echo -e "${PSG} ${g}   Installation Desktop.   ${h}${b}*${h}   ${w}[4]${h}"  
    echo -e "${PSY} ${g}   Configurt System.       ${h}${r}**${h}  ${w}[5]${h}"
    echo "---------------------------------------------"
    echo;
    READS_C=$(echo -e "${PSG} ${y} What are the tasks[1,2,3..] Exit [Q] ${h}${JHB} ")
    read -p "${READS_C}" tasks
#
# list1==========磁盘分区==========11111111111
        if [[ ${tasks} == 1 ]];then
        clear;
            echo;   # 显示磁盘
            lsblk | egrep "sda|sdb|sdc|sdd|sdg|nvme"
            echo;
            #---AAAA 20----------------磁盘分区-------------------A---#
           # 选择磁盘 #parted /dev/sdb mklabel gpt   转换格式 GPT
            READDISK_A=$(echo -e "${PSY} ${y} Select disk: ${g}/dev/sdX | sdX ${h}${JHB} ")
            read -p "${READDISK_A}"  DISKS_ID  #给用户输入接口
                DISK_NAMEL_A=$(echo "${DISKS_ID}" |  cut -d"/" -f3)   #设置输入”/dev/sda” 或 “sda” 都输出为 sda
                if echo $DISK_NAMEL_B |  egrep "^[a-z]$" &> ${null} ; then
                    cfdisk /dev/${DISK_NAMEL_A}  
                else
                    clear;
                    echo;
                    echo -e "${r} ==>> Error code [20] Please input: /dev/sdX | sdX? !!! ${h}"
                    exit 20    # 分区时输入错误，退出码。
                fi
                clear;
                #-------------------分区步骤结束，进入下一个阶段 格式和与挂载分区----------------B------#
                #---BBBB 21----------------root [/]----------------B------#
                echo;
                lsblk | egrep "sda|sdb|sdc|sdd|sdg|nvme"
                echo;
                READDISK_B=$(echo -e "${y}:: ==>> Choose your root[/] partition: ${g}/dev/sdX[0-9] | sdX[0-9] ${h}${JHB} ")
                read -p "${READDISK_B}"  DISK_LIST_ROOT   #给用户输入接口
                    DISK_NAMEL_B=$(echo "${DISK_LIST_ROOT}" |  cut -d"/" -f3)   #设置输入”/dev/sda” 或 “sda” 都输出为 sda
                    if echo ${DISK_NAMEL_B} | egrep "^sd[a-z][0-9]$" &> ${null} ; then
                        mkfs.ext4 /dev/${DISK_NAMEL_B}
                        mount /dev/${DISK_NAMEL_B} /mnt
                        ls /sys/firmware/efi/efivars &> ${null} && mkdir -p /mnt/boot/efi || mkdir -p /mnt/boot
                    else
                        clear;
                        echo;
                        echo -e "${r} ==>> Error code [21] Please input: /dev/sdX[0-9] | sdX[0-9] !!! ${h}"
                        exit 21    # 分区时输入错误，退出码。
                    fi
                #---CCCC 22----------------EFI / boot----------------C------#
                echo;
                lsblk | egrep "sda|sdb|sdc|sdd|sdg|nvme"
                echo;
                READDISK_C=$(echo -e "${y}:: ==>> Choose your EFI / BOOT partition: ${g}/dev/sdX[0-9] | sdX[0-9] ${h}${JHB} ")
                read -p "${READDISK_C}"  DISK_LIST_GRUB   #给用户输入接口
                    DISK_NAMEL_C=$(echo "${DISK_LIST_GRUB}" |  cut -d"/" -f3)   #设置输入”/dev/sda” 或 “sda” 都输出为 sda
                    if echo ${DISK_NAMEL_C} | egrep "^sd[a-z][0-9]$" &> ${null} ; then
                        mkfs.vfat /dev/${DISK_NAMEL_C}
                        ls /sys/firmware/efi/efivars &> ${null} && mount /dev/${DISK_NAMEL_C} /mnt/boot/efi || mount /dev/${DISK_NAMEL_C} /mnt/boot
                    else
                        clear;
                        echo;
                        echo -e "${r} ==>> Error code [22] Please input: /dev/sdX[0-9] | sdX[0-9] !!! ${h}"
                        exit 22    # 分区时输入错误，退出码。
                    fi
                #---DDDD 23-----------SWAP file 虚拟文件(类似与win里的虚拟文件) 对于swap分区我更推荐这个，后期灵活更变---------------#
                echo
                lsblk | egrep "sda|sdb|sdc|sdd|sdg|nvme"
                echo;
                READDISK_D=$(echo -e "${y}:: ==>> Please select the size of swapfile: ${g}[example:512M-4G ~] ${h}${JHB} ")
                read -p "${READDISK_D}"  DISK_LIST_SWAP     #给用户输入接口
                    DISK_NAMEL_D=$(echo "${DISK_LIST_SWAP}" |  cut -d"/" -f3)   #设置输入”/dev/sda” 或 “sda” 都输出为 sda
                    if echo ${DISK_NAMEL_D} | egrep "^[0-9]*[A-Z]$" &> ${null} ; then
                        echo -e ""
                        fallocate -l ${DISK_NAMEL_D} /mnt/swapfile
                        chmod 600 /mnt/swapfile
                        mkswap /mnt/swapfile
                        swapon /mnt/swapfile
                    else
                        clear;
                        echo;
                        echo -e "${r} ==>> Error code [23] Please input size: [example:512M-4G ~] !!! ${h}"
                        exit 23    # 分区时输入错误，退出码。
                    fi
            echo -e "${wg} ::==>> Partition complete. ${h}"
            bash ${0} 
        fi 
#
# list2========== 安装及配置系统文件 ==========222222222222222
        if [[ ${tasks} == 2 ]];then
            echo -e "${wg}Update the system clock.${h}"  #更新系统时间
                timedatectl set-ntp true
            sleep 4
            echo;
            echo -e ":: ${r}Install the base packages.${h}"   #安装基本系统
            echo;
                pacstrap /mnt base base-devel linux linux-firmware linux-headers ntfs-3g networkmanager net-tools 
	        sleep 2
            echo -e ":: ${r}Configure Fstab File.${h}" #配置Fstab文件
	            genfstab -U /mnt >> /mnt/etc/fstab
            clear;
            echo;
            echo;
            echo -e "${wg}#======================================================#${h}"
            echo -e "${wg}#::  System components installation completed.         #${h}"            
            echo -e "${wg}#::  Entering chroot mode.                             #${h}"
            echo -e "${wg}#::  Execute in 3 seconds.                             #${h}"
            echo -e "${wg}#::  Later operations are oriented to the new system.  #${h}"
            echo -e "${wg}#======================================================#${h}"
            sleep 3
            echo    # Chroot到新系统中完成基础配置，第一步配置
                cat $0 > /mnt/Arch_install.sh  && chmod +x /mnt/Arch_install.sh
                arch-chroot /mnt /bin/bash /Arch_install.sh
#----------------------------------------------------------------------------------------------------------------------------------------------------
                    echo -e "${wg}Installing grub tools.${h}"  #安装grub工具
                    pacman -S grub efibootmgr os-prober
                    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Archlinux   # 安装Grub引导
                    grub-mkconfig -o /boot/grub/grub.cfg                            # 生成配置文件
                    echo;
                    if efibootmgr | grep "Archlinux" &> ${null} ; then      #检验 并提示用户
                        echo -e "${g} Grub installed successfully -=> [Archlinux] ${h}"
                        echo -e "${g}     `efibootmgr | grep "Archlinux"`  ${h}" 
                        echo;   
                    else
                        echo -e "${r} Grub installed failed ${h}"       # 如果安装失败，提示用户，并列出引导列表
                        echo -e "${g}     `efibootmgr`  ${h}"   
                        echo; 
                    fi
                    rm -rf /mnt/etc/pacman.conf 2&>${null}
                    rm -rf /mnt/etc/pacman.d/mirrorlist 2&>${null}
                    cp -rf /etc/pacman.conf /mnt/etc/pacman.conf 2&>${null}
                    cp -rf /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist 2&>${null}
                        echo -e "${PSG} ${w}Configure enable Network.${h}"   
                    systemctl enable NetworkManager &> ${null}        #配置网络 加入开机启动
                    #---------------------------------------------------------------------------#
                    # 基础配置  时区 主机名 本地化 语言 安装语言包
                    #-----------------------------
                        echo -e "${PSG} ${w}Time zone changed to 'Shanghai'. ${h}"
                    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && hwclock --systohc # 将时区更改为"上海" / 生成 /etc/adjtime
                        echo -e "${PSG} ${w}Localization language settings. ${h}"
                    echo "Archlinux" > /etc/hostname  # 设置主机名
                    sed  -i "24i en_US.UTF-8 UTF-8" /etc/locale.gen   # 本地化设置 "英文"
                    sed  -i "24i zh_CN.UTF-8 UTF-8" /etc/locale.gen   # 本地化设置 "中文"
                    locale-gen       # 生成 locale
                    echo -e "${PSG} ${w}Configure local language defaults 'en_US.UTF-8'. ${h}"
                    echo "LANG=en_US.UTF-8" > /etc/locale.conf       # 系统语言 "英文" 默认为英文   
                    # echo "LANG=zh_CN.UTF-8" > /etc/locale.conf       # 系统语言 "中文"
                    echo -e "${PSG} ${w}Install Fonts. ${h}"
                    pacman -Sy wqy-microhei wqy-zenhei ttf-dejavu ttf-ubuntu-font-family noto-fonts # 安装语言包
            echo -e "${ws}#====================================================#${h}" #本区块退出后的提示
            echo -e "${ws}#::  Next you need to execute:                       #${h}"
            echo -e "${ws}#::  arch-chroot /mnt /bin/bash                      #${h}"
            echo -e "${ws}#::  Then you can install the driver or software.。  #${h}"
            echo -e "${ws}#====================================================#${h}"
            sleep 5
            exit 0
        fi

fi
# list3------------------------------------------------------------------------------------------------------#
#==========  Installation Drive. 驱动  ===========3333333333333
if [[ ${tasks} == 3 ]];then
    echo "${PSY} ${y}Still under development.....${h}" 
    #---------------------------------------------------------------------------#
    #  配置驱动
    #-------------------
    echo -e "${PSG} ${g}Installing Audio driver.${h}"
    pacman -S alsa-utils pulseaudio pulseaudio-bluetooth pulseaudio-alsa  #安装声音软件包
    echo "load-module module-bluetooth-policy" >> /etc/pulse/system.pa
    echo "load-module module-bluetooth-discover" >> /etc/pulse/system.pa

    echo -e "${PSG} ${g}Installing input driver.${h}"
    pacman -S xf86-input-synaptics xf86-input-libinput create_ap     #触摸板驱动
    echo;
    READDISK_DRIVER_GPU=$(echo -e "${PSG} ${y}Please choose: Intel[1] AMD[2]${h} ${JHB} ")
    read -p "${READDISK_DRIVER_GPU}"  DRIVER_GPU_ID
        if  [[ `echo "${DRIVER_GPU_ID}" | grep -E "^1$"`  == "1" ]] ; then
            pacman -S xf86-video-intel intel-ucode xf86-video-intel
        elif [[ `echo "${DRIVER_GPU_ID}" | grep -E "^2$"`  == "2" ]] ; then
            pacman -S xf86-video-ati amd-ucode
        fi
    lspci -k | grep -A 2 -E "(VGA|3D)"
    echo;
    READDISK_DRIVER_NVIDIA=$(echo -e "${PSG} ${y}Please choose: Nvidia[1] Exit[2]${h} ${JHB} ")
    read -p "${READDISK_DRIVER_NVIDIA}"  DRIVER_NVIDIA_ID
        if  [[ `echo "${DRIVER_GPU_ID}" | grep -E "^1$"`  == "1" ]] ; then
            pacman -S nvidia nvidia-utils opencl-nvidia lib32-nvidia-utils lib32-opencl-nvidia mesa lib32-mesa-libgl  optimus-manager optimus-manager-qt 
            systemctl enable optimus-manager.service
            rm -f /etc/X11/xorg.conf 2&> ${null}
            rm -f /etc/X11/xorg.conf.d/90-mhwd.conf 2&> ${null}

            if [ -e "/usr/bin/gdm" ] ; then  # gdm管理器
                pacman -S gdm-prime 
                sed -i 's/#.*WaylandEnable=false/WaylandEnable=false/'  /etc/gdm/custom.conf
            elif [ -e "/usr/bin/sddm" ] ; then
                sed -i 's/DisplayCommand/# DisplayCommand/' /etc/sddm.conf
                sed -i 's/DisplayStopCommand/# DisplayStopCommand/' /etc/sddm.conf
            fi
        elif [[ `echo "${DRIVER_GPU_ID}" | grep -E "^2$"`  == "2" ]] ; then
            bash $0
        fi      
fi
#------------------------------------------------------------------------------------------------------#
# list4==========  Installation Desktop. 桌面环境 ==========444444444444444444444444444
if [[ ${tasks} == 4 ]];then
DESKTOP_ID="0"
    echo
    echo -e "     ${w}***${h} ${b}Install Desktop${h} ${w}***${h}  "
    echo "---------------------------------"
    echo -e "${PSB} ${g}   KDE plasma.     ${h}${w}[1]${h}"
    echo -e "${PSB} ${g}   Gnome.          ${h}${w}[2]${h}"
    echo -e "${PSB} ${g}   Deepin.         ${h}${w}[3]${h}"    
    #echo -e "${PSB} ${g}   xfce.           ${h}${w}[4]${h}"  
    #echo -e "${PSB} ${g}   i3wm.           ${h}${w}[5]${h}"
    echo "---------------------------------"                           
    echo;
    CHOICE_ITEM_DESKTOP=$(echo -e "${PSG} ${y} Please select desktop${h} ${JHB} ")
    read -p "${CHOICE_ITEM_DESKTOP}"  DESKTOP_ID
        if  [[ `echo "${DESKTOP_ID}" | grep -E "^1$"`  == "1" ]] ; then
            DESKTOP_ENVS="plasma"
            pacman -S xorg xorg-server xorg-xinit mesa sddm sddm-kcm palsma palsma-desktop konlose dolphin kate \
            plasma-pa xorg-xwininfo ttf-dejavu ttf-liberation  thunar gvfs gvfs-smb gnome-keyring \
            cifs-utils powerdevil unrar unzip p7zip google-chrome zsh vim git ttf-wps-fonts mtpaint mtpfs libmtp kio-extras 
            bash ${0} 
            #-------------------------------------------------------------------------------# 
        elif  [[ `echo "${DESKTOP_ID}" | grep -E "^2$"`  == "2" ]] ; then
            DESKTOP_ENVS="gnome"
            pacman -S xorg xorg-server xorg-xinit mesa gnome gnome-extra gdm gnome-shell gvfs-mtp \                 
            gnome-tweaks gnome-shell-extensions unrar unzip p7zip google-chrome zsh vim git ttf-wps-fonts mtpaint mtpfs libmtp 
            bash ${0}            
            #-------------------------------------------------------------------------------#
        elif  [[ `echo "${DESKTOP_ID}" | grep -E "^3$"`  == "3" ]] ; then
            DESKTOP_ENVS="deepin"
            pacman -S xorg xorg-server xorg-xinit mesa deepin deepin-extra lightdm \
            lightdm-deepin-greeter unrar unzip p7zip google-chrome zsh vim git ttf-wps-fonts mtpaint mtpfs libmtp 
            bash ${0}           
            #-------------------------------------------------------------------------------#
        #elif  [[ `echo "${DESKTOP_ID}" | grep -E "^4$"`  == "4" ]] ; then
        #    DESKTOP_ENVS="xfce"
        #    pacman -S xorg xorg-server xorg-xinit mesa xfce4 xfce4-goodies light-locker \
        #    xfce4-power-manager libcanberra libcanberra-pulse unrar unzip p7zip google-chrome zsh vim git ttf-wps-fonts mtpaint mtpfs libmtp 
        #    bash ${0} 
            #-------------------------------------------------------------------------------#
         #elif  [[ `echo "${DESKTOP_ID}" | grep -E "^5$"`  == "5" ]] ; then
         #   echo "${PSY} ${y}Subsequent updates.....${h}"
            #DESKTOP_ENVS="i3wm"   
         #   bash ${0} 
            #-------------------------------------------------------------------------------#    
        fi
fi
#------------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------------#
# list5==========  进入系统后的配置 ===========55555555555555555555
if [[ ${tasks} == 5 ]];then
    #---------------------------------------------------------------------------#
    # 配置用户 Root 密码  
    #-----------------------------
    echo;
    SETTINGS_ROOT_PA=$(echo -e "${PSY} ${g}Settings ${y}Root Password.${h}${JHG} ")
    SETTINGS_ROOT_PB=$(echo -e "${PSY} ${g}Please enter the ${y}Root Password${h}${g} again.${h}${JHG} ")
    SETTINGS_USERNAME=$(echo -e "${PSY} ${g}Settings UserName.${h}${JHG} ")
    SETTINGS_USER_PASS=$(echo -e "${PSY} ${g}Settings Password.${h}${JHG} ")
    read -p "${SETTINGS_ROOT_PA}" ROOT_PASSWORD_A
    read -p "${SETTINGS_ROOT_PB}" ROOT_PASSWORD_B
    if [${ROOT_PASSWORD_A} == ${ROOT_PASSWORD_B} ]; then
        echo root:${ROOT_PASSWORD_B} | chpasswd &> $null
        echo;
        echo -e "${PSG} Root Password setting complete,[OK]"
    else    
        echo -e "${PSR} ${r}Two passwords are inconsistent. ${h}"
        exit 30;
    fi
    #---------------------------------------------------------------------------#
    # 配置用户
    #-----------------------------
    echo;
    read -p "${SETTINGS_USERNAME}" USER_NAME
    read -p "${SETTINGS_USER_PASS}" USER_PASSWORD_A
    read -p "${SETTINGS_USER_PASS}" USER_PASSWORD_B
    if [${USER_PASSWORD_A} == ${USER_PASSWORD_B} ]; then
        useradd -m -g users -G wheel -s /bin/bash ${USER_NAME}
        echo ${USER_NAME}:${USER_PASSWORD_B} | chpasswd &> $null
        echo;
        echo -e "${PSG} Password setting complete,[OK]"
    else    
        echo -e "${PSR} ${r}${USER_NAME} Two passwords are inconsistent. ${h}"
        exit 31;
    fi
    #---------------------------------------------------------------------------#
    # 更改sudo 配置
    #-----------------------------
    echo -e "${PSG} ${g}Configure Sudoers. ${h}"
    function S_LINE() {
        sed -n -e '/# %wheel ALL=(ALL) NOPASSWD: ALL/=' /etc/sudoers
    }
    SUDOERS_LIST=$(S_LINE)
    chmod 770 /etc/sudoers
        sed -i "${SUDOERS_LIST}i %wheel ALL=\(ALL\) NOPASSWD: ALL" /etc/sudoers || echo -e "${PSY} ${y}Configure Sudoers fail. ${h}"
    chmod 440 /etc/sudoers
    #---------------------------------------------------------------------------#
    #  配置桌面环境
    #----------------------------- 
    #   1.保存用户选择的变量，判断用户安装的什么桌面 优点：快速判断  缺点：必须的在脚本中完成一次桌面安装后，才知道用户是什么桌面。 保存变量为：${DESKTOP_ENVS}
    #   2.首先制定每个桌面坏境配置  使用保存的变量，执行对应的配置命令  $DESKTOP_SESSION   env | grep DESKTOP_SESSION= 

    if [[ `echo "${DESKTOP_ENVS}"` == "plasma" ]] ; then  #------------ plasma
    echo -e "${PSG} ${g}Configuring desktop environment.${h}"
        systemctl enable sddm
        echo "exec startkde" >> /etc/X11/xinit/xinitrc
        cp -rf /etc/X11/xinit/xinitrc  $USER/.xinitrc
    echo -e "${PSG} ${g}Desktop environment configuration completed.${h}"
    elif [[ `echo "${DESKTOP_ENVS}"` == "gnome" ]] ; then  #------------ gnome
    echo -e "${PSG} ${g}Configuring desktop environment.${h}"
        systemctl enable gdm
        echo "exec gnome=session" >> /etc/X11/xinit/xinitrc
        cp -rf /etc/X11/xinit/xinitrc  $USER/.xinitrc
    echo -e "${PSG} ${g}Desktop environment configuration completed.${h}"
    elif [[ `echo "${DESKTOP_ENVS}"` == "deepin" ]] ; then  #------------ deepin
    echo -e "${PSG} ${g}Configuring desktop environment.${h}"
        systemctl enable lightdm
        sed -i 's/greeter-session=example-gtk-gnome/greeter-session=lightdm-deepin-greeter/'  /etc/lightdm/lightdm.conf
        echo "exec startdde" >> /etc/X11/xinit/xinitrc
        cp -rf /etc/X11/xinit/xinitrc  $USER/.xinitrc
    echo -e "${PSG} ${g}Desktop environment configuration completed.${h}"
    fi
fi

##========退出 EXIT
case $principal_variable in
    q | Q | quit | QUIT)
    clear;
    echo;
    echo -e "${wg}#----------------------------------#${h}"
    echo -e "${wg}#:: script is over. Thank.         #${h}"
    echo -e "${wg}#----------------------------------#${h}"
    exit 0
esac
