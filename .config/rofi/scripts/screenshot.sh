#!/bin/sh
# Thanks to b4skyx for the base script
# Cleaned up and changed version of https://github.com/b4skyx/scmenu

# Set inital options and choices
dmenu_cmd="rofi -dmenu -no-lazy-grab"
save_folder="$HOME/Screenshots"
options=("Ecran\nSélection\nFenêtre active")
choice=""

title="Capture d'écran"

# Update choice as required
function get_choice() {
	if [ -e /tmp/deletion_link ]
	then
		options+=$"\nDeletion Link"
	fi
	choice=$(echo -e "$options" | $dmenu_cmd -p $title)
}

# Processing the choices made by the user
function runner() {
	file_name=$(date +Screenshot_%Y%m%d_%H%M%S.png)
	if [ "$choice" = "Ecran" ]
	then
		sleep 0.2
		maim /tmp/screenshot.png
		save_clip
	elif [ "$choice" = "Sélection" ]
	then
		maim -s -u /tmp/screenshot.png
		save_clip
	elif [ "$choice" = "Fenêtre active" ]
	then
		maim -i $(xdotool getactivewindow) /tmp/screenshot.png
		save_clip
	fi
}

# Function to save the screenshot
function save_clip(){
	options=("Copier dans le presse-papier\nSauvegarder l'image")
	choice=$(echo -e "$options" | $dmenu_cmd -p $title)

	if [ "$choice" = "Copier dans le presse-papier" ]
	then
		xclip -selection clipboard -t image/png /tmp/screenshot.png
		notify-send -i /tmp/screenshot.png "$title effectuée" "Copiée dans le presse-papier"
	elif [ "$choice" = "Sauvegarder l'image" ]
	then
		if [ ! -d $save_folder ]; then
			mkdir -p $save_folder;
		fi

		cp /tmp/screenshot.png $save_folder/$file_name
		notify-send -i /tmp/screenshot.png "$title sauvegardée" "$file_name"
	fi
}

get_choice
runner