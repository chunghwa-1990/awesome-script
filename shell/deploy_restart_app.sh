#!/bin/bash
app_name=$1
dir_name=${app_name%-*}


echo "dir_name:${dir_name}" 
echo "app_name:${app_name}"

if [ -n "${app_name}" ]; then

        pid=$(ps -ef | grep java | grep ${app_name} | awk '{print $2}')
        if [ -n "$pid" ]; then
                kill -9 ${pid}
                sleep 2
        fi




        start_project() {
                if [ -e /data/${dir_name}/log/${app_name} ]; then
                        cd /data/${dir_name}/log/${app_name}/
                        sudo rm -rf ${app_name}*.log
                        echo "===============================》rm logs"
                else
                        sudo mkdir /data/${dir_name}/log/${app_name}
                fi

                sudo chmod 777 -R /data/${dir_name}/log/${app_name}
                source /etc/profile
                exec nohup java -jar -Xmx512m -Xms512m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/data/${dir_name}/log/${app_name}/ -Djava.io.tmpdir=/data/${dir_name}/tmp -Dspring.profiles.active=pre /data/${dir_name}/app/${app_name}*.jar >/data/${dir_name}/log/${app_name}/${app_name}.log 2>&1 &

                pid=$(ps -ef | grep java | grep ${app_name} | awk '{print $2}')

                if [ -n "$pid" ]; then
                        echo "===============================》app_name: ${app_name},  start success , pid: $pid "
                else
                        echo "===============================》app_name: ${app_name},  start fail"
                fi
        }
        start_project

else
        echo "===============================》app_name is null, plase retry and write app_name"
fi
