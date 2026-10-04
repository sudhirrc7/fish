function cppfolders
    for dir in a b c d e f g
        mkdir -p $dir
        touch $dir/$dir.cpp $dir/input.txt $dir/output.txt
    end
end
