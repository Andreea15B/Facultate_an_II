public class LoadCommand extends Command {
    LoadCommand(Catalog catalog, String[] commandArguments) {
        this.catalog = catalog;
        this.arguments = commandArguments;
        this.commandName = "load";
    }
    public void execute() throws Exception{
        if(arguments.length != 1) throw new InvalidData("Not enough arguments!");
        catalog.load(arguments[0]);
    }
}
