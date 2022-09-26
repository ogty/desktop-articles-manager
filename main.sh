DESKTOP="$HOME/Desktop"
TARGET="$DESKTOP/articles"
DEFAULT_ICON="pdf"

function get_value() {
    # $1: target file path
    # $2: key name
    value=$(cat $1    \
    | grep "^$2:"     \
    | cut -d ':' -f2  \
    | awk '{gsub(/"/, "", $0); gsub(/ /, "", $0); print($0);}')
    echo $value
}

for line in $(ls $TARGET | grep '.md$'); do
    target="$TARGET/$line"
    without_file_name=$(echo $line | cut -d '.' -f1)
    without_extension_path=$(echo $target | cut -d '.' -f1)

    icon=$(get_value $target icon)
    is_marp=$(get_value $target marp)

    if [[ $is_marp = true ]]; then
        marp --pdf $target --html --allow-local-files --image-scale 2
    else
        md-to-pdf $target
    fi

    mv $without_extension_path.pdf $DESKTOP

    if [ -z $icon ]; then
        ic conv $DESKTOP/$without_file_name.pdf@$DEFAULT_ICON
    else
        ic conv $DESKTOP/$without_file_name.pdf@$icon
    fi
done
