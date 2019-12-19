#!/bin/bash -x

echo "Welcome to TicTacToe Game"

declare -a gameBoard

changeTurn=x
mainFlag=false

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
		echo "  -  -  -  "
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

function computerMove(){

	computerPos=$(( RANDOM%9 ))

	if [[ ${gameBoard[$computerPos]} == x ]] || [[ ${gameBoard[$computerPos]} == o ]]
	then
		computerMove $1
	else
		gameBoard[$computerPos]=$1
	fi
		changeTurn $1
}

function rowBlocker(){

	if [[ $1 == x ]]
	then
		checkForComp=o
	else
		checkForComp=x
	fi

	flag=true
	for (( i=0;i<9;i+=3 ))
	do
		if [[ ${gameBoard[$i]} == $1 && ${gameBoard[$i+1]} == $1 ]]
		then
			if [[ ${gameBoard[$i+2]} != $1 && ${gameBoard[$i+2]} != $2 && ${gameBoard[$i+2]} != $checkForComp ]]
			then
				gameBoard[$i+2]=$2
				mainFlag=true
				flag=false
				break
			fi
		elif [[ ${gameBoard[$i]} == $1 && ${gameBoard[$i+2]} == $1 ]]
		then
			if [[ ${gameBoard[$i+1]} != $1 && ${gameBoard[$i+1]} != $2 && ${gameBoard[$i+1]} != $checkForComp ]]
			then
				gameBoard[$i+1]=$2
				mainFlag=true
				flag=false
				break
			fi
		elif [[ ${gameBoard[$i+1]} == $1 && ${gameBoard[$i+2]} == $1 ]]
		then
			if [[ ${gameBoard[$i]} != $1 && ${gameBoard[$i]} != $2 && ${gameBoard[$i]} != $checkForComp ]]
			then
				gameBoard[$i]=$2
				mainFlag=true
				flag=false
				break
			fi
		fi
	done

		if [[ $flag == true ]]
		then
			columnBlocker $1 $2 $checkForComp
		fi
		changeTurn $2
}

function columnBlocker(){

	flag=true
	for (( i=0;i<3;i++ ))
	do
		if [[ ${gameBoard[$i]} == $1 && ${gameBoard[$i+3]} == $1 ]]
		then
			if [[ ${gameBoard[$i+6]} != $1 && ${gameBoard[$i+6]} != $2 && ${gameBoard[$i+6]} != $3 ]]
			then
				gameBoard[$i+6]=$2
				mainFlag=true
				flag=false
				break
			fi
		elif [[ ${gameBoard[$i]} == $1 && ${gameBoard[$i+6]} == $1 ]]
		then
			if [[ ${gameBoard[$i+3]} != $1 && ${gameBoard[$i+3]} != $2 && ${gameBoard[$i+3]} != $3 ]]
			then
				gameBoard[$i+3]=$2
				mainFlag=true
				flag=false
				break
			fi
		elif [[ ${gameBoard[$i+3]} == $1 && ${gameBoard[$i+6]} == $1 ]]
		then
			if [[ ${gameBoard[$i]} != $1 && ${gameBoard[$i]} != $2 && ${gameBoard[$i]} != $3 ]]
			then
				gameBoard[$i]=$2
				mainFlag=true
				flag=false
				break
			fi
		fi
	done

	if [[ $flag == true ]]
	then
		diag1Blocker $1 $2 $3
	fi
	changeTurn $2
}

function diag1Blocker(){

	flag=true
	for (( i=0;i<9;i+=3 ))
	do
		if [[ ${gameBoard[$i]} == $1 && ${gameBoard[$i+4]} == $1 ]]
		then
			if [[ ${gameBoard[$i+8]} != $1 && ${gameBoard[$i+8]} != $2 && ${gameBoard[$i+8]} != $3 ]]
			then
				gameBoard[$i+8]=$2
				mainFlag=true
				flag=false
				break
			fi
		elif [[ ${gameBoard[$i]} == $1 && ${gameBoard[$i+8]} == $1 ]]
		then
			if [[ ${gameBoard[$i+4]} != $1 && ${gameBoard[$i+4]} != $2 && ${gameBoard[$i+4]} != $3 ]]
			then
				gameBoard[$i+4]=$2
				mainFlag=true
				flag=false
				break
			fi
		elif [[ ${gameBoard[$i+4]} == $1 && ${gameBoard[$i+8]} == $1 ]]
		then
			if [[ ${gameBoard[$i]} != $1 && ${gameBoard[$i]} != $2 && ${gameBoard[$i]} != $3 ]]
			then
				gameBoard[$i]=$2
				mainFlag=true
				flag=false
				break
			fi
		fi
	done

	if [[ $flag == true ]]
	then
		diag2Blocker $1 $2 $3
	fi
		changeTurn $2
}


function diag2Blocker(){

	flag=true
	for (( i=0;i<9;i+=3 ))
	do
		if [[ ${gameBoard[$i+2]} == $1 && ${gameBoard[$i+4]} == $1 ]]
		then
			if [[ ${gameBoard[$i+6]} != $1 && ${gameBoard[$i+6]} != $2 && ${gameBoard[$i+6]} != $3 ]]
			then
				gameBoard[$i+6]=$2
				mainFlag=true
				flag=false
				break
			fi
		elif [[ ${gameBoard[$i+2]} == $1 && ${gameBoard[$i+6]} == $1 ]]
		then
			if [[ ${gameBoard[$i+4]} != $1 && ${gameBoard[$i+4]} != $2 && ${gameBoard[$i+4]} != $3 ]]
			then
				gameBoard[$i+4]=$2
				mainFlag=true
				flag=false
				break
			fi
		elif [[ ${gameBoard[$i+4]} == $1 && ${gameBoard[$i+6]} == $1 ]]
		then
			if [[ ${gameBoard[$i+2]} != $1 && ${gameBoard[$i+2]} != $2 && ${gameBoard[$i+2]} != $3 ]]
			then
				gameBoard[$i+2]=$2
				mainFlag=true
				flag=false
				break
			fi
		fi
	done

		changeTurn $2
}

function checkCorner(){

	flag=true
	for (( i=0;i<9;i++ ))
	do
		if (( $i%2==0 && $i!=4 ))
		then
			if [[ ${gameBoard[$i]} != $1 &&  ${gameBoard[$i]} != $2 ]]
			then
				gameBoard[$i]=$2
				flag=false
				break
			fi
		fi
	done

	if [[ $flag == true ]]
	then
		checkCenter $1 $2
	fi
		changeTurn $2
}

function checkCenter(){

	if [[ ${gameBoard[4]} != $1 &&  ${gameBoard[4]} != $2 ]]
	then
			gameBoard[4]=$2
	fi

	changeTurn $2
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

	status=false

	read player computer < <( toss )

	echo "Player $player"
	echo "Computer $computer"

	for (( j=0;j<${#gameBoard[@]};j++ ))
	do
		if [[ $player == $changeTurn ]]
		then
			playerMove $player
			printBoard
			status=$( checkWhoWon $player )
			if [[ $status == true ]]
			then
					echo "Player is Won"
					break
			fi
		else
			rowBlocker $computer $computer
			status=$( checkWhoWon $computer )
			if [[ $status == true ]]
			then
					printBoard
					echo "computer is Won"
					break
			else
					rowBlocker $player $computer
			fi

			if [[ $mainFlag == false ]]
			then
				checkCorner $player $computer
			fi
				printBoard
		fi
	done

	if [[ $status == false ]]
	then
		echo "Game Tie.."
	fi
}

main
