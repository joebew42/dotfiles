function fish_prompt
  set laststatus $status
  function _pwd
    set realhome ~
    if [ $realhome = $PWD ]
      echo -n (set_color green)\u2302' '
    else
      echo -n (basename $PWD)' '
    end
  end
  function _git_branch_name
    echo -n (set_color yellow)(git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
  end
  function _git_is_dirty
    echo -n (git status -s --ignore-submodules=dirty ^/dev/null)
  end
  function _git_status
    if [ (_git_is_dirty) ]
      echo -n (set_color red)\u2717
    else
      echo -n (set_color green)\u2713
    end
  end
  function _git_info
    if [ (_git_branch_name) ]
      echo -n "$git_info"(_git_branch_name)' '(_git_status)' '
    end
  end
  function _prompt_start
    echo -n (set_color blue)'❯ '
  end
  function _prompt_end
    echo -n (set_color magenta)'❯ '
  end

  test $SSH_TTY
  and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '

  test $USER = 'root'
  and echo (set_color red)"#"

  # Main
  printf '%s%s%s%s' (_prompt_start) (_pwd) (_git_info) (_prompt_end)
end
