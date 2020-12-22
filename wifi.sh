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
        notify-send 'wifi' "Đăng nhập tài khoản $2 thành công"
    else
        if [ ${#account} == 0 ]
        then
            notify-send 'wifi' "Sai tài khoản hoặc mật khẩu: $2|$3"
        else
            notify-send 'wifi' "Tài khoản $2 đã được đăng nhập ở thiết bị khác"
        fi
    fi
elif [ $1 == "logout" ]
then
    curl --location GET 'https://login.net.vn/logout'
    notify-send 'wifi' "Đăng xuất tài khoản thành công"
else
    notify-send 'wifi' "Chưa nhận được lệnh wifi"
fi
