#!/bin/bash -x

echo "Welcome to TicTacToe Game"

declare -a gameBoard

changeTurn=x

gameBoard=(_ _ _ _ _ _ _ _ _)

function toss(){

	toss=$((RANDOM%2))

	case $toss in

		0)
			player1=o
			player2=x;;
		1)
			player1=x
			player2=o;;
	esac

	echo $player1 $player2
}

function changeTurn(){

	if [[ $1 == x ]]
	then
		changeTurn=o
	else
		changeTurn=x
	fi
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
		read -p "Enter the Position $1 " pos

		if (( $pos <= 9 && ${gameBoard[$(($pos-1))]}!=x && ${gameBoard[$(($pos-1))]}!=o ))
		then
			gameBoard[$(($pos - 1))]=$1
			flag=false
		fi
	done
		changeTurn $1
}

function main(){

	read play1 play2 < <( toss )

	for (( i=0;i<9; i++ ))
	do
		if [[ $play1 == $changeTurn ]]
		then
			playerMove $play1
		else
			playerMove $play2
		fi
			printBoard
	done
}

main
