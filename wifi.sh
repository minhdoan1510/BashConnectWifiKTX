#!/bin/bash

if [ $1 == "login" ]
then
    res=$(curl --location --request POST 'https://login.net.vn/login' \
    		--data-urlencode 'dst2=http://www.gstatic.com/generate_204' \
    		--data-urlencode 'dst=http://www.gstatic.com/generate_204' \
    		--data-urlencode 'popup=true' \
    		--data-urlencode "username=$2" \
    		--data-urlencode "password=$3")
    title=$(echo "$res" | grep -oP "\<title\>(.*?)\<\/title\>")
    account=$(echo "$res" | grep -oP "You are already logged in - access denied")
    if [ $title == '<title>redirect</title>' ]
    then
	cscript MessageBox.vbs "Đăng nhập tài khoản $2 thành công"
    else
        if [ ${#account} == 0 ]
        then
		cscript MessageBox.vbs "Sai tài khoản hoặc mật khẩu: $2|$3"
        else
		cscript MessageBox.vbs "Tài khoản $2 đã được đăng nhập ở thiết bị khác"
        fi
    fi
elif [ $1 == "logout" ]
then
	curl --location GET 'https://login.net.vn/logout'
	cscript MessageBox.vbs "Đăng xuất tài khoản thành công"
else
	cscript MessageBox.vbs "Chưa nhận được lệnh wifi"
fi