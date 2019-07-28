#!/bin/bash

############
# The Game #
############
gameTime=0
gameSpeed=1
gameHigh="999999"
gameOver=false

function gameTimePass() {
  ((gameTime++))
  tput cup 17 64
  echo "${gameTime}s"
}

############
# The User #
############
usrScore="000000"
usrPositionX=40
usrPositionY=9

function usrMove() {

  usrPositionXOld=${usrPositionX}
  usrPositionYOld=${usrPositionY}

  read -n 1 -s -r usrKey

  case "${usrKey}" in
    "w")
      if [[ ${usrPositionYOld} -gt 9 ]]; then
        ((usrPositionY--))
      fi
      ;;
    "s")
      if [[ ${usrPositionYOld} -lt 30 ]]; then
        ((usrPositionY++))
      fi
      ;;
    "a")
      if [[ ${usrPositionXOld} -gt 25 ]]; then
        ((usrPositionX--))
      fi
      ;;
    "d")
      if [[ ${usrPositionXOld} -lt 54 ]]; then
        ((usrPositionX++))
      fi
      ;;
    *)
      echo "Unknown key!"
      ;;
  esac

  tput cup ${usrPositionYOld} ${usrPositionXOld}
  echo " "
  tput cup ${usrPositionY} ${usrPositionX}
  echo "#"

}

##################
# The Background #
##################

backgroundBanner="
                            ______     __       _     
                           /_  __/__  / /______(_)____
                            / / / _ \/ __/ ___/ / ___/
                           / / /  __/ /_/ /  / (__  ) 
                          /_/  \___/\__/_/  /_/____/  
"
backgroundPattern="
                        #------------------------------#
                        |                              |  Score:  ${usrScore}
                        |                              |  High:   ${gameHigh}
                        |                              |
                        |                              |  Next:
                        |                              |  ${gameNext}
                        |                              |
                        |                              |  Position X: ${usrPositionX}
                        |                              |  Position Y: ${usrPositionY}
                        |                              |
                        |                              |  Time: "${gameTime}s"
                        |                              |
                        |                              |
                        |                              |
                        |                              |
                        |                              |
                        |                              |
                        |                              |
                        |                              |
                        |                              |
                        |                              |
                        |                              |
                        |                              |
                        #------------------------------#"

function backgroundDraw() {
  clear # Cleaning the screen
  echo "${backgroundBanner}" | lolcat --animate --speed 32 --duration 8 # Printing the banner
  echo "${backgroundPattern}" | lolcat # Printing the pattern
}

##############
# The Pieces #
##############

piecePattern="#"

function pieceDraw() {
  tput cup ${usrPositionY} ${usrPositionX}
  echo "${piecePattern}"
}

##########
# TETRIS #
##########

backgroundDraw
pieceDraw

while [ $gameOver == false ]; do
  usrMove
  #gameTimePass
done

