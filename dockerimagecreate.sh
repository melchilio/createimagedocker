#!/bin/bash

#Author: Apoti Eri (Lionel)

echo -e "\nWhat is your name please?\n"
read name
sleep 1

echo -e "\nWhat base image do you prefer? (1 = centos, 2 - ubuntu, 3 - alpine, 4 - debian)\n"
read image
sleep 1

if [ ${image} = 1 ]
then
base=centos
fi
if [ ${image} = 2 ]
then
base=ubuntu
fi

if [ ${image} = 3 ]
then
base=alpine
fi

if [ ${image} = 4 ]
then
base=debian
fi


echo -e "\nWhat version do you want please? (latest)?\n"
read ver
sleep 1

echo -e "\nWhat applications do you want installed in the docker image? [vim, httpd (or apache2), curl, wget, docker, finger? (If there are multiple, please separate them with spaces)]\n"
read app
sleep 1

echo -e "\nDo you want to have a port exposed? Which one please?(numbers only please)\n"
read port
sleep 1

echo -e "\nWhat is the name of the file or directory you want to copy into the image? NB: Please make sure that the script is in the same directory as the directory where that file or folder is found\n"
read file
sleep 1

echo -e "\nWhat name do you want to give to the folder which is going to be copy of this container on your system?\n"
read vol
sleep 1

echo -e "\nWhat port do you want to expose for the docker container that will be created?\n"
read port2
sleep 1

echo -e "\nDo you want the container to run in a detached mode once it has been created? Or do you prefer for it to be attached? (d = detached and t = attached)?\n"
read mode
sleep 1

if [ ${base} = centos  -a  ${mode} = d ]
then
sleep 3
echo -e "\nBuilding a ${base} image, version ${ver} with port ${port} opened and installing ${app}.\n"
sleep 3
echo -e "FROM ${base}:${ver}\nMAINTAINER ${name}\nRUN yum update -y\nRUN yum install ${app} -y\nRUN systemctl enable httpd\nCOPY ./${file} /var/www/html\nEXPOSE ${port}\nCMD apachectl -D FOREGROUND" > dockerfile
docker build -t ${name}/${base}-httpd:${ver} .
docker push ${name}/${base}-httpd
echo -e "Running container in a detached mode"
docker run -itd -v ${vol}:/var/www/html -p ${port2} ${name}/${base}-httpd bash
fi

if [ ${base} = centos  -a  ${mode} = t ]
then
sleep 3
echo -e "\nBuilding a ${base} image, version ${ver} with port ${port} opened and installing ${app}.\n"
sleep 3
echo -e "FROM ${base}:${ver}\nMAINTAINER ${name}\nRUN yum update -y\nRUN yum install ${app} -y\nRUN systemctl enable httpd\nRUN systemctl start httpd\nCOPY ./${file} /var/www/html\nEXPOSE ${port}\nCMD apachectl -D FOREGROUND" > dockerfile
docker build -t ${name}/${base}-httpd:${ver} .
docker push ${name}/${base}-httpd
echo -e "Running container in an attached mode"
docker run -it -v ${vol}:/var/www/html -p ${port2} ${name}/${base}-httpd bash
fi

if [ ${base} = alpine  -a  ${mode} = d ]
then
sleep 3
echo -e "\nBuilding a ${base} image, version ${ver} with port ${port} opened and installing ${app}.\n"
sleep 3
echo -e "FROM ${base}:${ver}\nMAINTAINER ${name}\nRUN apk update\nRUN apk add ${app}\nRUN systemctl enable httpd\nRUN systemctl start httpd\nCOPY ./${file} /usr/local/apache2/htdocs\nEXPOSE ${port}\nCMD apachectl -D FOREGROUND" > dockerfile
docker build -t ${name}/${base}-httpd:${ver} .
docker push ${name}/${base}-httpd
echo -e "Running container in a detached mode"
docker run -itd -v ${vol}:/usr/local/apache2/htdocs -p ${port2} ${name}/${base}-httpd bash
fi

if [ ${base} = alpine  -a  ${mode} = t ]
then
sleep 3
echo -e "\nBuilding a ${base} image, version ${ver} with port ${port} opened and installing ${app}.\n"
sleep 3
echo -e "FROM ${base}:${ver}\nMAINTAINER ${name}\nRUN apk update\nRUN apk add ${app}\nRUN systemctl enable httpd\nRUN systemctl start httpd\nCOPY ./${file} /usr/local/apache2/htdocs\nEXPOSE ${port}\nCMD apachectl -D FOREGROUND" > dockerfile
docker build -t ${name}/${base}-httpd:${ver} .
docker push ${name}/${base}-httpd
echo -e "Running container in an attached mode"
docker run -it -v ${vol}:/usr/local/apache2/htdocs -p ${port2} ${name}/${base}-httpd bash
fi

if [ ${base} = ubuntu  -a  ${mode} = d ]
then
sleep 3
echo -e "\nBuilding a ${base} image, version ${ver} with port ${port} opened and installing ${app}.\n"
sleep 3
echo -e "FROM ${base}:${ver}\nMAINTAINER ${name}\nRUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone\nRUN apt-get update -y\nRUN apt-get install ${app} -y\nRUN systemctl enable apache2\nRUN systemctl start apache2\nCOPY ./${file} /usr/local/apache2/htdocs\nEXPOSE ${port}\nCMD apachectl -D FOREGROUND" > dockerfile
docker build -t ${name}/${base}-httpd:${ver} .
docker push ${name}/${base}-httpd
echo -e "Running container in a detached mode"
docker run -itd -v ${vol}:/usr/local/apache2/htdocs -p ${port2} ${name}/${base}-httpd bash
fi

if [ ${base} = ubuntu  -a  ${mode} = t ]
then
sleep 3
echo -e "\nBuilding a ${base} image, version ${ver} with port ${port} opened and installing ${app}.\n"
sleep 3
echo -e "FROM ${base}:${ver}\nMAINTAINER ${name}\nRUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone\nRUN apt-get update -y\nRUN apt-get install ${app} -y\nRUN systemctl enable apache2\nRUN systemctl start apache2\nCOPY ./${file} /usr/local/apache2/htdocs\nEXPOSE ${port}\nCMD apachectl -D FOREGROUND" > dockerfile
docker build -t ${name}/${base}-httpd:${ver} .
docker push ${name}/${base}-httpd
echo -e "Running container in an attached mode"
docker run -it -v ${vol}:/usr/local/apache2/htdocs -p ${port2} ${name}/${base}-httpd bash
fi

if [ ${base} = debian  -a  ${mode} = d ]
then
sleep 3
echo -e "\nBuilding a ${base} image, version ${ver} with port ${port} opened and installing ${app}.\n"
sleep 3
echo -e "FROM ${base}:${ver}\nMAINTAINER ${name}\nRUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone\nRUN apt-get update -y\nRUN apt-get install ${app} -y\nRUN systemctl enable apache2\nRUN systemctl start apache2\nCOPY ./${file} /usr/local/apache2/htdocs\nEXPOSE ${port}\nCMD apachectl -D FOREGROUND" > dockerfile
docker build -t ${name}/${base}-httpd:${ver} .
docker push ${name}/${base}-httpd
echo -e "Running container in a detached mode"
docker run -itd -v ${vol}:/usr/local/apache2/htdocs -p ${port2} ${name}/${base}-httpd bash
fi

if [ ${base} = debian  -a  ${mode} = t ]
then
sleep 3
echo -e "\nBuilding a ${base} image, version ${ver} with port ${port} opened and installing ${app}.\n"
sleep 3
echo -e "FROM ${base}:${ver}\nMAINTAINER ${name}\nRUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone\nRUN apt-get update -y\nRUN apt-get install ${app} -y\nRUN systemctl enable apache2\nRUN systemctl start apache2\nCOPY ./${file} /usr/local/apache2/htdocs\nEXPOSE ${port}\nCMD apachectl -D FOREGROUND" > dockerfile
docker build -t ${name}/${base}-httpd:${ver} .
docker push ${name}/${base}-httpd
echo -e "Running container in an attached mode"
docker run -it -v ${vol}:/usr/local/apache2/htdocs -p ${port2} ${name}/${base}-httpd bash
fi

#systemctl enable httpd
#systemctl start httpd


if [ $? = 0 ]
then
echo "Successfully created"
rm -rf dockerfile
else
echo "Docker image creation failed"
fi