FROM mysql:5.7

COPY db/init.sql /docker-entrypoint-initdb.d/

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=leave_staff

EXPOSE 3306
