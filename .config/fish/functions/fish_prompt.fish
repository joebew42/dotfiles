function fish_prompt
  set laststatus $status
  function _git_branch_name
    echo -n  (set_color yellow)(git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
  end
  function _git_is_dirty
    echo (git status -s --ignore-submodules=dirty ^/dev/null)
  end
  function _git_status
    if [ (_git_is_dirty) ]
      set git_status (set_color red) \u2717
    else
      set git_status (set_color green) \u2713
    end
    printf '%s' $git_status
  end
  function _git_info
    if [ (_git_branch_name) ]
      printf '%s %s ' (_git_branch_name) (_git_status)
    else
      printf '%s ' (prompt_pwd)
    end
  end
  function _prompt_start
    printf (set_color blue)'❯ '
  end
  function _prompt_end
    printf (set_color magenta)'❯ '
  end

  test $SSH_TTY
  and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '

  test $USER = 'root'
  and echo (set_color red)"#"

  # Main
  printf '%s%s%s' (_prompt_start) (_git_info) (_prompt_end)
end
