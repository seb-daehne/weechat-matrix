from: https://github.com/jessfraz/dockerfiles/tree/master/weechat-matrix

wip


run: 
`docker run -ti -v /etc/localtime:/etc/localtime:ro -v "${HOME}/.weechat:/home/user/.weechat" --rm -u $(id -u) weechat`
