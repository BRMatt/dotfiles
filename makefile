
setup: bin/ack bin/tmuxstart bin/gitcrypt

bin/gitcrypt:
	curl https://raw.githubusercontent.com/shadowhand/git-encrypt/develop/gitcrypt > bin/gitcrypt
	chmod +x bin/gitcrypt

bin/ack:
	curl http://beyondgrep.com/ack-2.12-single-file > bin/ack
	chmod +x bin/ack

bin/tmuxstart: 
	wget https://raw.githubusercontent.com/treyhunner/tmuxstart/master/tmuxstart -O bin/tmuxstart
	chmod +x bin/tmuxstart
