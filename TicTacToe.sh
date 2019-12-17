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

		if (( $pos <= 9 && ${gameBoard[$pos-1]}!=x &&  ${gameBoard[$pos-1]}!=o ))
		then
			gameBoard[$(($pos - 1))]=$1
			flag=false
		fi
	done
		changeTurn $1
}

function checkWhoWon(){

	flag=false
	row=0
	col=0
	diag1=0
	diag2=2

	for (( i=0;i<3;i++ ))
	do
		if [[ ${gameBoard[$row]} == $1 && ${gameBoard[$((row=$row+1))]} == $1 && ${gameBoard[$((row=$row+1))]} == $1 ]]
		then
			flag=true
			break
		fi

		if [[ ${gameBoard[$col]} == $1 && ${gameBoard[$((col=$col+3))]} == $1 && ${gameBoard[$((col=$col+3))]} == $1 ]]
		then
			flag=true
			break
		fi

		if [[ ${gameBoard[$diag1]} == $1 && ${gameBoard[$((diag1=$diag1+4))]} == $1 && ${gameBoard[$((diag1=$diag1+4))]} == $1 ]]
		then
			flag=true
			break
		fi

		if [[ ${gameBoard[$diag2]} == $1 && ${gameBoard[$((diag2=$diag2+2))]} == $1 && ${gameBoard[$((diag2=$diag2+2))]} == $1 ]]
		then
			flag=true
			break
		fi
		row=$(( ($i + 1) * 3 ))
		col=$(( $i + 1 ))
	done
		echo $flag
}

function main(){

	count=0
	status=flag

	read play1 play2 < <( toss )

	echo "Player1 $play1"
	echo "Player2 $play2"

	for (( j=0;j<${#gameBoard[@]};j++ ))
	do
		if [[ $play1 == $changeTurn ]]
		then
			playerMove $play1
			printBoard
			status=$( checkWhoWon $play1 )
			if [[ $status == true ]]
			then
					echo "Player 1 is Won"
					break
			fi
		else
			playerMove $play2
			printBoard
			status=$( checkWhoWon $play2 )
			if [[ $status == true ]]
			then
					echo "Player 2 is Won"
					break
			fi
		fi
	done

	if [[ $status == false ]]
	then
		echo "Game Tie.."
	fi
}

main
