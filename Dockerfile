# Usage:
# 	Building
# 		docker build -t weechat-matrix .
#	Running (no saved state)
# 		docker run -it \
#			-v /etc/localtime:/etc/localtime:ro \ # for your time
# 			weechat-matrix
# 	Running (saved state)
# 		docker run -it \
#			-v /etc/localtime:/etc/localtime:ro \ # for your time
# 			-v "${HOME}/.weechat:/home/user/.weechat" \
# 			weechat-matrix
#
FROM alpine:latest

RUN apk update --no-cache && \
  apk upgrade --no-cache && \  
  apk add --no-cache \
	build-base \
	ca-certificates \
	git \
	libffi-dev \
	libressl-dev \
	olm-dev \
	python \
	python-dev \
	py2-pip \
	weechat \
	weechat-perl \
	weechat-python \
	--repository https://dl-4.alpinelinux.org/alpine/edge/testing

ENV HOME /home/user

RUN adduser -S user -h $HOME \
	&& chown -R user $HOME

WORKDIR $HOME
USER user

RUN git clone https://github.com/poljar/weechat-matrix.git \
	&& cd weechat-matrix \
	&& pip install --no-cache-dir --user wheel\
	&& pip install --no-cache-dir --user -r requirements.txt \
	&& pip install --no-cache-dir --user websocket-client \
	&& make install 

ADD entrypoint.sh $HOME/entrypoint.sh

CMD [ "/bin/sh", "entrypoint.sh" ]
