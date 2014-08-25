#TITLE: Tic Tac Toe Ruby Game
#AUTHOR: MjB
#DESCRIPTION: Game for two players, X and O, who take turns marking the spaces in a 3×3 grid. The player who succeeds in placing three respective marks in a horizontal, vertical, or diagonal row wins the game.


#METHODS BEGIN#
def initialize_board
	p = {}
	(1..9).each {|position| p[position] = ' '}
	p
end

def draw_board(p)
	system 'clear'
	puts "Welcome to Tic Tac Toe Game"
	puts "\n"
	puts "  #{p[1]} | #{p[2]} | #{p[3]} "
	puts " -----------"
	puts "  #{p[4]} | #{p[5]} | #{p[6]} "
	puts " -----------"
	puts "  #{p[7]} | #{p[8]} | #{p[9]} "
end

def empty_positions(p)
	p.select {|k,v| v == ' ' }.keys
end

def check_free_positions(p, user_position)
	if p.select {|k,v| v != ' ' }.keys.include?(user_position)
		print "Sorry, but this position is already taken. Please choose again > "
		user_position = gets.chomp.to_i
		check_free_positions(p, user_position)
	else 
		p[user_position] = 'X'
	end
end

def player_picks_square(p)
	puts "\nYou are Xs and the Computer is Os"
	print "\nChoose a position on the board (1 - 9) > "
	user_position = gets.chomp.to_i
	position_check = check_free_positions(p, user_position)
end

def computer_picks_square(p)
	position = empty_positions(p).sample
	p[position] = 'O'
end

def check_winner(p)
	winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
	winning_lines.each do |line|
	return "Player" if p.values_at(*line).count('X') == 3
	return "Computer" if p.values_at(*line).count('O') == 3
	end
	nil
end

def replay(play_again_choice)
	if play_again_choice == 'y' || play_again_choice == 'yes'
		puts "\n---------Time for a rematch!---------\n"
	elsif play_again_choice == 'n' || play_again_choice == 'no'
		puts "\n---------Thanks for playing!---------\n"
		exit
	else
		puts "\nUmm, didn't catch that. Would You Like to Play again? (Y/N)"
		play_again_choice = gets.chomp.downcase
		replay(play_again_choice)
	end
end
#METHODS END#

#MAIN APPLICATION BEGINS#
loop do

board = initialize_board
draw_board(board)

begin	
player_picks_square(board)
computer_picks_square(board)
draw_board(board)
winner = check_winner(board)
end until winner || empty_positions(board).empty?

if winner == 'Player'
puts "\nYou won!"
elsif winner == 'Computer'
puts "\nThe computer won!"
else
puts "\nIt's a tie!"
end

print "\nWould you like to play another round of Tic-Tac-Toe? (Y/N) > "
play_again_choice = gets.chomp.downcase
replay(play_again_choice)
end
#MAIN APPLICATION ENDS#2