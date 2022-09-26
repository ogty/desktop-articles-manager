THIS_DIR=$(cd $(dirname $0); pwd)
DESKTOP="$HOME/Desktop"
TARGET="$DESKTOP/articles"
DEFAULT_ICON="pdf"
FRAGS="--html --allow-local-files --image-scale 2"


# Function to get the value of config.
function get_value() {
    # $1: Target markdown file
    # $2: Key name of config.
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

    # ---
    icon=$(get_value $target icon)
    is_marp=$(get_value $target marp)
    marp_theme=$(get_value $target theme)
    # ---

    # PDF file generation
    if [[ $is_marp = true ]]; then # Generation and theming in Marp
        if [ -z $marp_theme ]; then
            marp --pdf $target $FRAGS
        else
            theme_path="$THIS_DIR/marp/$marp_theme.css"
            if [ -e $theme_path ]; then
                marp --pdf $target --theme $theme_path --html --allow-local-files --image-scale 2
            else
                marp --pdf $target $FRAGS
            fi
        fi
    else # Generate and apply themes in md-to-pdf
        md-to-pdf $target
    fi

    # Move generated PDF to Desktop
    mv $without_extension_path.pdf $DESKTOP

    # Change PDF file icon
    if [ -z $icon ]; then
        ic conv $DESKTOP/$without_file_name.pdf@$DEFAULT_ICON
    else
        ic conv $DESKTOP/$without_file_name.pdf@$icon
    fi
done
