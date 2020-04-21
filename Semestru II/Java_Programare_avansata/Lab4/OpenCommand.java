public class OpenCommand extends Command {
    OpenCommand(Catalog catalog, String[] commandArguments) {
        this.catalog = catalog;
        this.arguments = commandArguments;
        this.commandName = "open";
    }
    public void execute() throws Exception {
        if(arguments.length != 1) throw new InvalidData("Not enough arguments!");
        catalog.open(arguments[0]);
    }
}
