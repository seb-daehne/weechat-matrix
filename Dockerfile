FROM debian:testing-slim

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update -y; apt-get install -q -y \
  git \
  libolm-dev \
  python3 \
  python3-pip \
  weechat-curses \
  weechat-python \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -fr /root/.cache

ENV HOME /home/user

RUN adduser --home $HOME --disabled-password --gecos "" user \
	  && chown -R user $HOME

RUN git clone https://github.com/poljar/weechat-matrix.git \
	&& cd weechat-matrix \
	&& pip3 install --no-cache-dir wheel\
	&& pip3 install --no-cache-dir -r requirements.txt \
	&& pip3 install --no-cache-dir websocket-client \
	&& make install \
	&& chown -R user $HOME

ADD entrypoint.sh $HOME/entrypoint.sh

WORKDIR $HOME
USER user

CMD [ "/bin/sh", "entrypoint.sh" ]
