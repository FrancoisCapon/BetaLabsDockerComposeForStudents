DEBIAN_BUILD(bookworm)
DEBIAN_INSTALL(nano openssl procps curl iproute2 iputils-ping lighttpd)
SET_ROOT_PASSWORD(qwerty)
ADD_CURRENT_HOST_USER(student)
RUN umask 0000 && mkdir -p /school/public

FINAL_BUILD

