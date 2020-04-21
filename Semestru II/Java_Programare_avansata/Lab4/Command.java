public abstract class Command {
    String commandName;
    String[] arguments;
    Catalog catalog;
    public abstract void execute() throws Exception;
}
