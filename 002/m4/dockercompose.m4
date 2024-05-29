divert(-1)

changequote([,])

include(./999/m4/utils.m4)

define(INDEX_HTML,dnl
<h1>$1.school</h1>
)
define(LIGHTTPD_CONF,dnl
include "/school/lighttpd.conf"

server.document-root        = basedir + "$1.school"
server.port                 = 80
)

define(LIGHTTPD,dnl
[
syscmd(echo 'INDEX_HTML($1)' > LAB_NAME--STUDENT_ID/$1/student/$1.school/index.html)
syscmd(echo 'LIGHTTPD_CONF($1)' > LAB_NAME--STUDENT_ID/$1/student/lighttpd.conf)
syscmd(cp -p LAB_FILES/school/lighttpd.sh LAB_NAME--STUDENT_ID/$1/student/.)dnl
])

define(MACHINE,dnl
[
  $1:
    image: debian:LAB_NAME
    container_name: ${COMPOSE_PROJECT_NAME}-$1
    hostname: ${COMPOSE_PROJECT_NAME}-uppercase($1)
    volumes:
      - ../../${COMPOSE_PROJECT_NAME}/school:/school
      - ../../${COMPOSE_PROJECT_NAME}/$1/student:/home/student
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    command: sh -c "/home/student/lighttpd.sh ; sleep infinity"
    networks:
      school:
        ipv4_address: $2
        aliases:
          - $1.school
syscmd(mkdir -p LAB_NAME--STUDENT_ID/$1/student/$1.school)dnl
LIGHTTPD($1)
])

syscmd(mkdir -p LAB_NAME--STUDENT_ID/school)dnl
syscmd(cp -rnp LAB_FILES/school/ LAB_NAME--STUDENT_ID/)dnl

divert
name: ${[LAB_NAME]:?error}--${[STUDENT_ID]:?error}

services:
# https://fr.wikipedia.org/wiki/Plan%C3%A8te#Plan%C3%A8tes_du_Syst%C3%A8me_solaire

MACHINE(arts,10.10.0.0)
MACHINE(biosciences,10.20.0.0)
MACHINE(chemistry,10.30.0.0)


networks:
  school:
    name: ${COMPOSE_PROJECT_NAME}-school
    ipam:
      config:
        - subnet: 10.0.0.0/8



