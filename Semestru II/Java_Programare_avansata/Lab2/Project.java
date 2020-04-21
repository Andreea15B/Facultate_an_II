import java.time.LocalDate;

/**
 * A project has the properties: name and deadline. Project is an abstract class.
 * A project may be an application or an essay.
 */
abstract public class Project {
    String name;
    LocalDate deadline;

    // setters
    abstract void setName(String name);
    abstract void setDeadline(LocalDate deadline);

    // getters
    abstract String getName();
    abstract LocalDate getDeadline();
}
