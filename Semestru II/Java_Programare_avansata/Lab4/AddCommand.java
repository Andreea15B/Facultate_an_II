public class AddCommand extends Command {
    AddCommand(Catalog catalog, String[] commandArguments) {
        this.catalog = catalog;
        this.arguments = commandArguments;
        this.commandName = "add";
    }
    public void execute() throws Exception{
        if(arguments.length != 3) throw new InvalidData("Not enough arguments!");
        catalog.add(new Graph(arguments[0], arguments[1], arguments[2]));
    }
}
