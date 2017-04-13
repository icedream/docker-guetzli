FROM alpine:3.5

# Permanent dependencies (runtime)
#RUN \
#	apk add --no-cache \
#		libpng

# Dev & build
ARG GFLAGS_VERSION=v2.2.0
ARG GUETZLI_VERSION=v1.0.1
RUN \
	apk add --no-cache --virtual .build-deps \
		libpng-dev \
		alpine-sdk \
		git \
		coreutils \
		cmake \
		&&\
\
	git clone "https://github.com/gflags/gflags.git" /var/tmp/gflags &&\
	(cd /var/tmp/gflags &&\
		git checkout "${GFLAGS_VERSION}" &&\
		mkdir build &&\
		cd build &&\
		cmake .. &&\
		make -j$(nproc) all install DESTDIR="/opt/build" \
	) &&\
\
	git clone "https://github.com/google/guetzli.git" /var/tmp/guetzli &&\
	(cd /var/tmp/guetzli &&\
		git checkout "${GUETZLI_VERSION}" &&\
		make -j$(nproc) config=release \
			TARGETDIR=/usr/local/bin \
			LDFLAGS="-L/opt/build/usr/local/lib -static" \
			CXXFLAGS="-I/opt/build/usr/local/include" \
			CFLAGS="-I/opt/build/usr/local/include" \
			CPPFLAGS="-I/opt/build/usr/local/include" \
	) &&\
\
	apk del --no-cache .build-deps &&\
	rm -rf /var/tmp/* /tmp/* /opt/build

ENTRYPOINT ["guetzli"]
