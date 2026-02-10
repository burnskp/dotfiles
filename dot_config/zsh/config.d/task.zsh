#!/bin/zsh
if [ $commands[task] ]; then
  alias ta="task add"
  alias th="task history"
  alias tl="task ls"
  alias tln="task ls tag:next"
  alias tn="task next"
  alias tp="task projects"
  alias tsum="task summary"

  function tasksync {
    if grep -q "^taskd" $HOME/.config/task/taskrc; then
      task sync
    fi
  }

  function td {
    if [[ -z $1 ]]; then
      echo "Usage: td TASK_NUMBER"
      return 1
    fi
    task $1 done
    tasksync
  }

  function tlater {
    if [[ -z $1 ]]; then
      echo "Usage: tlater TASK_NUMBER"
      return 1
    fi
    task $1 modify +later
    tasksync
  }

  function tdel {
    if [[ -z $1 ]]; then
      echo "Usage: tdel TASK_NUMBER"
      return 1
    fi
    task $1 delete
    tasksync
  }

  function tap {
    if [[ -z $2 ]]; then
      echo "Usage: tap PROJECT DESCRIPTION"
      return 1
    fi
    local project="$1"
    shift
    task add "project:$project" "$@"
    tasksync
  }

  function tas {
    if [[ -z $1 ]]; then
      echo "Usage: tas DESCRIPTION"
      return 1
    fi
    task add project:singletons $*
    tasksync
  }

  function tlp {
    if [[ -z $1 ]]; then
      echo "Usage: tlp PROJECT"
      return 1
    fi
    task ls "project:$1"
  }

  function tdep {
    if [[ -z $2 ]]; then
      echo "Usage: tdep TASK_NUMBER DEPENDENCY_TASK_NUMBER"
      return 1
    fi
    task $1 modify depends:"$2"
    tasksync
  }
fi
