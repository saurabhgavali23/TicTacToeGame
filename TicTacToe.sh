#!/bin/bash -x

echo "Welcome to TicTacToe Game"

declare -a gameBoard

gameBoard=(_ _ _ _ _ _ _ _ _)

toss=$((RANDOM%2))

case $toss in

	0)
		player=o;;
	1)
		player=x;;
esac
