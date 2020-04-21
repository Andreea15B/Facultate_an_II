public class ListCommand extends Command {
    ListCommand(Catalog catalog) {
        this.catalog = catalog;
        this.commandName = "list";
    }
    public void execute() throws Exception {
        catalog.list();
    }
}
