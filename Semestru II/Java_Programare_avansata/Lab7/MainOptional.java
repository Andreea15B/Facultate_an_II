import game.Board;
import game.Game;
import player.RandomPlayer;
import player.SmartPlayer;

public class MainOptional
{
    public static void main(String[] args)
    {
        Game game = new Game();
        game.setBoard(new Board(6));
        game.addPlayer(new SmartPlayer("Player 1"));
        game.addPlayer(new RandomPlayer("Player 2"));
        game.addPlayer(new RandomPlayer("Player 3"));
        game.start();
    }
}
