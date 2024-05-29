divert(-1)

changequote([,])

define([DEBIAN_BUILD],
FROM debian:$1 as build
RUN apt update
define(USER_ID,0)dnl
define(USER_NAME,root)dnl
define(USER_HOME,/root)dnl
)

define(DEBIAN_INSTALL,
RUN apt install -y $1
)

define(SET_ROOT_PASSWORD,
RUN echo "root:$1" | chpasswd
)

define(ADD_USER,[dnl
define([USER_ID],[$1])dnl
define([USER_NAME],ifelse($2,,user,$2))dnl
define([USER_HOME],/home/USER_NAME)dnl
RUN useradd -u USER_ID -ms /bin/bash USER_NAME
])

define(GET_CURRENT_HOST_USER_ID,esyscmd([id -u | tr -d '\n']))

define(ADD_CURRENT_HOST_USER,[dnl
ADD_USER(GET_CURRENT_HOST_USER_ID,ifelse($1,,user,$1))dnl
])

define(FINAL_BUILD,[dnl
FROM scratch
COPY --from=build / /
USER USER_NAME
WORKDIR USER_HOME
CMD ifelse($1,,sleep infinity,$1)
])

divert