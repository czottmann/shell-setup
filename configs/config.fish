# ### Defining the prompt
#
# Example output:
#
#     |1.9.3| Illium in /Users/carlo/Code
#     |gh-pages| ➔

function fish_prompt
  echo
  # line 1: "|{Ruby version}| {hostname} in {current path}"
  if test $RUBY_VERSION
    set_color yellow
    echo -n "|$RUBY_VERSION| "
  end
  set_color purple
  echo -n ( hostname -s )
  set_color white
  echo -n " in "
  set_color green
  pwd

  # line 2: "({current git branch}) ➔ "
  echo -n ( __fish_git_prompt; and echo -n " " )
  echo -n "➔ "
  set_color normal
end


# ### Show my external IP address
function myip
  echo "My external IP:" ( curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+' )
end


# Add homebrew folders to the path
if not contains /usr/local/bin $PATH
  set -gx PATH /usr/local/bin /usr/local/sbin $HOME/bin $PATH
end

# Add node folders to the path
if not contains /usr/local/share/npm/bin $PATH
  set -gx PATH $PATH /usr/local/share/npm/bin ./node_modules/.bin
end

# Postgres
set psql_path /Applications/Postgres.app/Contents/Versions/9.4/bin
if test -d $psql_path
  if not contains $psql_path $PATH
    set -gx PATH $PATH $psql_path
  end
end

# Android dev
if test -d /Users/carlo/android-sdk-macosx
  if not contains /Users/carlo/android-sdk-macosx/tools $PATH
    set -gx PATH $PATH /Users/carlo/android-sdk-macosx/tools /Users/carlo/android-sdk-macosx/plattform-tools
    set -gx ANDROID_HOME "/Users/carlo/android-sdk-macosx"
  end
end

# ### Aliases
alias be "bundle exec"
alias gpull "git pull origin"
alias gpush "git push origin"
alias ls "ls -Gal"
alias serve "python -m SimpleHTTPServer"
alias tmux "env TERM=xterm-256color tmux"
alias v "vagrant"


# ### chruby-fish
source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish


# Set editor and git editor
if test -f /usr/local/bin/atom
  set -x EDITOR "/usr/local/bin/atom -w"
  set -x GIT_EDITOR '/usr/local/bin/atom -w'
else if -f /usr/local/bin/subl
  set -x EDITOR "/usr/local/bin/subl -w"
  set -x GIT_EDITOR '/usr/local/bin/subl -w'
end
