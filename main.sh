DESKTOP="$HOME/Desktop"
TARGET="$DESKTOP/articles"

for line in $(ls $TARGET | grep '.md$'); do
    target="$TARGET/$line"
    without_file_name=$(echo $line | cut -d '.' -f1)
    without_extension_path=$(echo $target | cut -d '.' -f1)

    md-to-pdf $target
    icon=$(cat $target \
    | grep '^icon:'    \
    | cut -d ':' -f2   \
    | awk '{gsub(/"/, "", $0); gsub(/ /, "", $0); print($0);}')
    mv $without_extension_path.pdf $DESKTOP

    if [ -z $icon ]; then
        ic conv $DESKTOP/$without_file_name.pdf@pdf
    else
        ic conv $DESKTOP/$without_file_name.pdf@$icon
    fi
done