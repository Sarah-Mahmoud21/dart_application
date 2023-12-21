import 'dart:io';
String player1Name="";
String player2Name="";
void main() {
  
  bool playAgain = true;

  while (playAgain) {
    playGame();
    //if you want to quit or restart the game
    stdout.write("Do you want to play again? (yes/no): ");
    String playAgainInput = stdin.readLineSync()?.toLowerCase() ?? "";
    if (playAgainInput != 'yes') {
      playAgain = false;
    }
  }

  print("Thanks for playing!");
}

void playGame() {
  List<String> board = List.filled(9, ' ');

  print("First player, enter your name: ");
   player1Name = stdin.readLineSync() ?? "Player 1";
  print("Second player, enter your name: ");
   player2Name = stdin.readLineSync() ?? "Player 2";

  print("$player1Name uses X / $player2Name uses O");

  int currentPlayer = 1; // 1 for the first, 2 for the second 

  while (true) {
    buildBoard(board);
    int move = getPlayerMove(currentPlayer, board);
    rebuildBoard(board, move, currentPlayer);

    if (checkWin(board, currentPlayer)) {
      buildBoard(board);
      if(currentPlayer==1){
         print("Player $player1Name wins!");
      }
      else{
          print("Player $player2Name wins!");
      }
      break;
    } else if (board.every((cell) => cell != ' ')) { // all cells filled and nobody won
      buildBoard(board);
      print("Nobody Won :(");
      break;
    }

    currentPlayer = 3 - currentPlayer; // switch roles
  }
}

void buildBoard(List<String> board) {
  print(" ${board[0]} | ${board[1]} | ${board[2]} ");
  print("---|---|---");
  print(" ${board[3]} | ${board[4]} | ${board[5]} ");
  print("---|---|---");
  print(" ${board[6]} | ${board[7]} | ${board[8]} ");
}

int getPlayerMove(int currentPlayer, List<String> board) {
  int move;
  while (true) {
    if(currentPlayer==1){
      stdout.write("$player1Name , where do you want to play (1-9): ");
    }
    else {
      stdout.write("$player2Name , where do you want to play (1-9): ");
    }
    String input = stdin.readLineSync() ?? "";
    
      move = int.parse(input);
      if (move >= 1 && move <= 9) {
        if (board[move - 1] == ' ') {
          break;
        } else {
          print("Cell is filled. Try again.");
        }
      } else {
        print("Please enter a number between 1 to 9.");
      }
    
  }
  return move - 1;
}

void rebuildBoard(List<String> board, int move, int currentPlayer) {
  board[move] = (currentPlayer == 1) ? 'X' : 'O';
}

bool checkWin(List<String> board, int currentPlayer) {
  // Check all possible win cases
  List<List<int>> winPatterns = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var pattern in winPatterns) {
    if (board[pattern[0]] == board[pattern[1]] &&
        board[pattern[1]] == board[pattern[2]] &&
        board[pattern[0]] != ' ') {
      return true;
    }
  }

  return false;
}
