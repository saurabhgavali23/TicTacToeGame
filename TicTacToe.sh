#!/bin/bash -x

echo "Welcome to TicTacToe Game"

declare -a gameBoard

gameBoard=(_ _ _ _ _ _ _ _ _)

function toss(){

	toss=$((RANDOM%2))

	case $toss in

		0)
			echo o;;
		1)
			echo x;;
	esac
}

function printBoard(){

	row=0
	count=1
	for (( i=0;i<3;i++ ))
	do
		echo " $((count++))| ${gameBoard[$row]} | $((count++))| ${gameBoard[$((row=$row+1))]} | $((count++))| ${gameBoard[$((row=$row+1))]} |"
		row=$(($row+1))
	done
}

function playerMove(){

	flag=true
	while [[ $flag == true ]]
	do
		read -p "Enter the Position " pos

		if (( $pos <= 9 ))
		then
			gameBoard[$(($pos - 1))]=$1
			flag=false
		fi
	done
}

function main(){

	playerMove $( toss )
	printBoard
}

main
