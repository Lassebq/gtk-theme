install:
	install -Dm755 gtk-theme /usr/bin/gtk-theme
	install -Dm644 _gtk-theme /usr/share/zsh/site-functions/_gtk-theme
	install -Dm644 _gtk-theme.bash /usr/share/bash-completion/completions/gtk-theme