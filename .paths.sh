comp() {
	name=$1
	if [[ -x $name ]]; then
		rm $name
	fi
	echo "Compiling $name.cpp"
	g++ -std=c++14 -Wshadow -Wall -o $name $name.cpp -O2 -Wno-unused-result
}

run() {
	comp $1
	TMP_OUT=/tmp/out
	TMP_ANS=/tmp/ans
	if [[ -x $name ]]; then
		echo "Running ./$name"
		./$name > $TMP_OUT 
		echo "Program output:"
		cat $TMP_OUT
		cat /dev/null > $TMP_ANS
		echo "Enter the expected output and hit Ctrl+d:"
		while IFS= read -r line; do
			printf '%s\n' "$line" >> $TMP_ANS
		done
		diff $TMP_OUT $TMP_ANS
	fi
}

dbg() {
	name=$1
	if [[ -x $name ]]; then
		rm $name
	fi
	echo "Compiling $name.cpp in debug mode"
	g++ -std=c++14 -Wshadow -Wall -o $name $name.cpp -Og -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
}

dbgr() {
	name=$1
	if [[ -x $name ]]; then
		rm $name
	fi
	echo "Compiling $name.cpp in debug mode"
	g++ -std=c++14 -Wshadow -Wall -o $name $name.cpp -Og -g
	if [[ -x $name ]]; then
		echo "Running gdb ./$name"
		gdb ./$name
	fi
}


pyrun() {
	name=$1
	TMP_OUT=/tmp/out
	TMP_ANS=/tmp/ans
	echo "Running $name.py"
	pypy3 $name.py > $TMP_OUT
	echo "Program output:"
	cat $TMP_OUT
	cat /dev/null > $TMP_ANS
	echo "Enter the expected output and hit Ctrl+d:"
	while IFS= read -r line; do
		printf '%s\n' "$line" >> $TMP_ANS
	done
	diff $TMP_OUT $TMP_ANS
}

one() {
	file=$1
	CP_PATH=/home/deep/work/cp
	[[ -e $file.cpp ]] || cat $CP_PATH/comp.cpp > $file.cpp
}

mult() {
	start=$1
	stop=$2
	CP_PATH=/home/deep/work/cp
	for file in {$start..$stop}; do
		[[ -e $file.cpp ]] || cat $CP_PATH/comp.cpp > $file.cpp
	done
}

alias l='exa'
alias ls='exa'
alias ll='exa -la'

ANACONDA_BIN=/home/deep/anaconda3/bin
alias apython=$ANACONDA_BIN/python
alias aipython=$ANACONDA_BIN/ipython
alias apip=$ANACONDA_BIN/pip

alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'

alias myconfig='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export PATH=/home/deep/software/go/bin:$PATH
#export PATH=/home/deep/anaconda3/bin:$PATH
export PATH=/home/deep/.local/bin:$PATH
export ADB_TOOL_PATH=/home/deep/software/platform-tools
export PATH=/home/deep/.emacs.d/bin:$PATH
#export JAVA_HOME=/home/deep/software/jdk1.8.0_261
#export PATH=$JAVA_HOME/bin:$PATH
export ANDROID_HOME=/home/deep/Android/Sdk
export PATH=/home/deep/software/node-v14.15.3-linux-x64/bin:$PATH

export CLASSPATH=.:/home/deep/software/antlr-4.9-complete.jar:$CLASSPATH
export PATH=/home/deep/software/flutter/bin:$PATH

export EDITOR=nvim
export NNN_PLUG='m:nmount;p:preview-tui;t:treeview;s:suedit'
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
