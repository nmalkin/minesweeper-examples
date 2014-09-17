import java.util.Random;
import java.util.Scanner;

public class Minesweeper {
  /**
   * Play one game of minesweeper.
   * @return true if you won the game.
   */
  private static boolean playGame() {
    Scanner scanner = new Scanner(System.in);

    // Get board info
    String infoString = scanner.nextLine();
    String[] boardInfo = infoString.split(",");
    int width = Integer.parseInt(boardInfo[0]);
    int height = Integer.parseInt(boardInfo[1]);
    int mines = Integer.parseInt(boardInfo[2]);

    Random random = new Random();
    while (true) {
      // Guess a random cell
      int xGuess = random.nextInt(width);
      int yGuess = random.nextInt(height);
      System.out.println(xGuess + "," + yGuess);

      // Find out the result
      String result = scanner.nextLine();
      if (result.equals("win")) {
        return true;
      } else if (result.equals("lost")) {
        return false;
      } else {
        try {
          int neighbors = Integer.parseInt(result);
          // Now might be a good time to do something smart.
        } catch (NumberFormatException e) {
          System.err.println("Something went wrong?");
          return false;
        }
      }
    }
  }

  public static void main(String[] args) {
    if (playGame()) {
      System.err.println("I won the game!");
    } else {
      System.err.println("I lost the game. :-(");
    }
  }
}
