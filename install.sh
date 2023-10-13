#!/bin/bash
#      _       _    __ _ _            
#   __| | ___ | |_ / _(_) | ___  ___  
#  / _` |/ _ \| __| |_| | |/ _ \/ __| 
# | (_| | (_) | |_|  _| | |  __/\__ \ 
#  \__,_|\___/ \__|_| |_|_|\___||___/ 
#                                     
#  
# by Christian Hennes (2023) 
# ----------------------------------------------------- 

show_logo(){
    echo -e "
             _       _    __ _ _           
          __| | ___ | |_ / _(_) | ___  ___ 
         / _\` |/ _ \| __| |_| | |/ _ \/ __|
        | (_| | (_) | |_|  _| | |  __/\__ \\
         \__,_|\___/ \__|_| |_|_|\___||___/
                                   
"
}


main()  {
    if [[ "${EUID}" -eq 0 ]]; then
        show_logo
    else
        # printf "${rot}Admin-Rechte werden benötigt. Bitte mit sudo ausführen."
        # exit $?
        # If the sudo command exists, try rerunning as admin
        if is_command sudo ; then
            printf "%b  %b Sudo utility check\\n" "${OVER}"  "${TICK}"

            # when run via curl piping
            if [[ "$0" == "bash" ]]; then
                # Download the install script and run it with admin rights
                exec curl -sSL https://github.com/h3Nn35/dotfiles/raw/master/install.sh | sudo bash "$@"
            else
                # when run via calling local bash script
                exec sudo bash "$0" "$@"
            fi

            exit $?
        else
            # Otherwise, tell the user they need to run the script as root, and bail
            printf "%b  %b Sudo utility check\\n" "${OVER}" "${CROSS}"
            printf "  %b Sudo is needed for the Web Interface to run pihole commands\\n\\n" "${INFO}"
            printf "  %b %bPlease re-run this installer as root${COL_NC}\\n" "${INFO}" "${COL_LIGHT_RED}"
            exit 1
        fi
    fi
}

main "$@"
