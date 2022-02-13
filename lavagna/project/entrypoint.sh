#!/bin/sh

flag=0

while [ $flag -eq 0 ]; do
    result=$( curl lavanga_db:3306 2>/dev/null )
    if [ $? -eq 1 ]; then
        echo "Successfully curled it"
        flag=1
    else
        echo "Failed to curl it!"
    fi
    sleep 2
done

mv /app/lavagna/ /static_files

java -Xms64m -Xmx128m -Ddatasource.dialect="${DB_DIALECT}" \
-Ddatasource.url="${DB_URL}" \
-Ddatasource.username="${DB_USER}" \
-Ddatasource.password="${DB_PASS}" \
-Dspring.profiles.active="${SPRING_PROFILE}" \
-jar /app/lavagna-jetty-console.war --headless

