#!/bin/bash -x

echo "Welcome to TicTacToe Game"

declare -a gameBoard

gameBoard=(_ _ _ _ _ _ _ _ _)

function toss(){

	toss=$((RANDOM%2))

	case $toss in

		0)
			player=o
			computer=x;;
		1)
			player=x
			computer=o;;
	esac

	echo $player $computer
}
