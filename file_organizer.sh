#!/bin/bash

DIR="$1"

if [ -z "$DIR" ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

if [ ! -d "$DIR" ]; then
    echo "Directory $DIR does not exist."
    exit 1
fi

create_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

create_directory "$DIR/Images"
create_directory "$DIR/Videos"
create_directory "$DIR/Documents"
create_directory "$DIR/Others"

for file in "$DIR"/*; do
    if [ -f "$file" ]; then
        extension="${file##*.}"
        extension_lower=$(echo "$extension" | tr '[:upper:]' '[:lower:]')
        
        case "$extension_lower" in
            jpg|jpeg|png)
                mv "$file" "$DIR/Images/"
                echo "Moved $file to Images"
                ;;
            mp4)
                mv "$file" "$DIR/Videos/"
                echo "Moved $file to Videos"
                ;;
            pdf|txt)
                mv "$file" "$DIR/Documents/"
                echo "Moved $file to Documents"
                ;;
            *)
                mv "$file" "$DIR/Others/"
                echo "Moved $file to Others"
                ;;
        esac
    fi
done

echo "Files organized successfully."
