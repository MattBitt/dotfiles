function find_longest
    if test (count $argv) -ne 1
        echo "Usage: find_longest <extension>"
        echo "Example: find_longest vue"
        return 1
    end
    
    set extension $argv[1]
    
    echo "Finding longest .$extension files..."
    echo "----------------------------------------"
    
    find . -type f -name "*.$extension" -exec wc -l {} + | sort -nr | head -20 | awk '{print $1 " lines: " $2}'
end
