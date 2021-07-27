function fish_prompt
  set laststatus $status
  function _truncate
    set word_to_truncate $argv[1]
    if [ (string length $word_to_truncate) -gt 12 ]
      echo -n (echo $word_to_truncate | cut -c -12)...
    else
      echo -n $word_to_truncate
    end
  end
  function _pwd
    set realhome ~
    if [ $realhome = $PWD ]
      echo -n (set_color green)\u2302' '
    else
      echo -n (_truncate (basename $PWD)' ')
    end
  end
  function _git_branch_name
    set branch_name (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    test $branch_name
    and echo -n (set_color yellow)(_truncate $branch_name)
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
      echo -n (_git_branch_name)' '(_git_status)' '
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
