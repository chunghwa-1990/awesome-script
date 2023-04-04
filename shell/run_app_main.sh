#!/bin/sh
#------------------------------------
# Start java for the poi example
# author ：zhaohongliang
# date: 2017-08-23 11:51
#------------------------------------

lang=zh_CN.GBK

export lang

JAVA_HOME=/data/tools/java/jdk1.7.0_79
PATH=$JAVA_HOME/bin:$PATH
CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar

export JAVA_HOME
export PATH

RUN_HOME=/data/app/poi

CLASSPATH=$RUN_HOME/classes:$CLASSPATH
for i in "$RUN_HOME"/lib/*.jar; do
        CLASSPATH="$CLASSPATH":"$i"
done


export CLASSPATH

echo $CLASSPATH >> path.log

java com.mfq.demo.poi.RepaymentPOI2007 >> log.log &


