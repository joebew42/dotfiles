function pjson
    cat $argv | python -m json.tool | pygmentize -l json
end
