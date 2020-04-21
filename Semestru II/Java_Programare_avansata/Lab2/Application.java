import java.time.LocalDate;
import java.util.Objects;

/**
 * Applications are a type of projects that have the property language.
 */
public class Application extends Project {
    Language language;
    Application(String name, LocalDate date, Language language) { // constructor
        this.name = name;
        this.deadline = date;
        this.language = language;
    }

    @Override
    public String toString() {
        return "Application{" +
                "language=" + language +
                '}';
    }

    // setters
    void setName(String name) {
        this.name = name;
    }
    void setDeadline(LocalDate date) {
        this.deadline = date;
    }
    void setLanguage(Language language) {
        this.language = language;
    }

    // getters
    String getName() {
        return this.name;
    }
    LocalDate getDeadline() {
        return this.deadline;
    }
    Language getLanguage() {
        return this.language;
    }


}
