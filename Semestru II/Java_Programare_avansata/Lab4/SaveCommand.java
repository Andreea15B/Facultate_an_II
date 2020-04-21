public class SaveCommand extends Command {
    SaveCommand(Catalog catalog, String[] commandArguments) {
        this.catalog = catalog;
        this.arguments = commandArguments;
        this.commandName = "save";
    }
    public void execute() throws Exception {
        if(arguments.length != 1) throw new InvalidData("Not enough arguments!");
        catalog.save(arguments[0]);
    }
}
