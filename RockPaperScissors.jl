# Create object for making move (Rock, Paper, Scissors)
# One perk of this structure is that we can add new moves with slight changes to this struct anytime!
# e.g. Rock, Paper, Scissors, Spock, Lizard and other derivatives of Rock Paper Scissors
struct Thing
    name::String
    wins_with::String
end

# Create possible move objects
scissors = Thing("scissors", "paper")
rock = Thing("rock", "scissors")
paper = Thing("paper", "rock")

# Define winner check function
check_winner(player1::Thing, player2::Thing) = (player1.name == player2.name) ? 0 : (player1.wins_with == player2.name ?  1 : 2)

# Function to change string to a move object
function to_thing(str)
    arr = [scissors, rock, paper]
    return arr[findfirst(x -> x.name == str, arr)]
end

# Function to play_again
function play_again()
    (ask_play_again("Play again? (y/n): ") == "y") ? run(`julia $PROGRAM_FILE`) : exit()
end

# Input part of play_again
function ask_play_again(prompt)
    print(prompt)
    txt = split(lowercase(readline()))
    ((length(txt) > 1) || !(txt[1] in ["y", "n"])) ? ask_play_again(prompt) : return txt[1]
end

# Get input from user, and scrub input
function get_input(prompt)
    print(prompt)
    txt = split(lowercase(readline()))
    ((length(txt) > 1) || !(txt[1] in ["rock", "scissors", "paper"])) ? get_input(prompt) : return txt[1]
end

while true
    # Ask for input and get move by user
    player1_move = to_thing(get_input("Enter your move (Rock, Paper or Scissors): "))

    # Make AI make random move
    player2_move = rand([rock, scissors, paper])

    # Show user the move the AI made
    println("AI: ", player2_move.name)

    # Check winner
    result = check_winner(player1_move, player2_move)

    # Print result
    (result == 1) ? println("You win") : (result == 2) ? println("AI wins") : println("Tie.")
    break
end

# Ask if user want to play again
play_again()
