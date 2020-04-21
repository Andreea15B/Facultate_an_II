import java.io.*;
import java.util.Scanner;

public class Test {
    public static void startShell() {
        Scanner keyboard = new Scanner(System.in);
        String[] commandParts, commandArguments;
        String commandName;
        Command newCommand = null;
        Catalog catalog = new Catalog("D:\\Facultate\\An_II\\Semestrul_II\\Java_Programare_avansata\\Laborator\\Lab4\\");
        while(true) {
            String command = keyboard.nextLine();
            if(command.equals("exit")) break;
            commandParts = command.split(" ");
            commandArguments = new String[commandParts.length - 1];
            commandName = commandParts[0];
            for(int i=1; i<commandParts.length; i++) {
                if(commandParts[i].endsWith(","))
                    commandArguments[i-1] =  commandParts[i].substring(0, commandParts[i].length()-1);
                else commandArguments[i-1] =  commandParts[i];
            }
            switch (commandName) {
                case "add": newCommand = new AddCommand(catalog, commandArguments); break;
                case "list": newCommand = new ListCommand(catalog); break;
                case "open": newCommand = new OpenCommand(catalog, commandArguments); break;
                case "save": newCommand = new SaveCommand(catalog, commandArguments); break;
                case "load": newCommand = new LoadCommand(catalog, commandArguments); break;
                default: System.out.println("Not a valid command!");
            }
            try {
                newCommand.execute();
            }
            catch (Exception e){
                System.out.println("General command exception: " + e.toString());
            }
        }
    }

    public static void main(String args[]) {
        startShell();
        /*
        Catalog catalog = new Catalog("D:/Facultate/An_II/Semestrul_II/Java_Programare_avansata/Laborator/Lab4/");
        try {
            catalog.add(new Graph("K3", "src/k3.tgf", "src/k3.png"));
            catalog.add(new Graph("K1_3", "src/k1_3.tgf", "src/k1_3.png"));
        }
        catch (InvalidData e) {
            System.out.println(e);
        }
        try {
            catalog.open("K3");
        }
        catch (FileNotFoundException e) {
            System.out.println("Open - The file is missing!");
        }
        catch (Exception e){
            System.out.println("Open - General exception: " + e.toString());
        }

        catalog.save("catalog.txt");
        catalog.load("catalog.txt");
        catalog.list();*/
    }
}
