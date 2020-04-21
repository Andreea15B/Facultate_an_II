import java.util.ArrayList;
import java.util.Objects;

/**
 * A student is described by the following properties: name, year of study and project preferences.
 */
public class Student {
    private String name ;
    private int year;
    private ArrayList<Project> preferences = new ArrayList<>();
    Student(String name, int year) { // constructor
        this.name = name;
        this.year = year;
    }

    /**
     * The problem should not allow adding the same student twice.
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Student student = (Student) o;
        return year == student.year && Objects.equals(name, student.name);
    }

    @Override
    public String toString() {
        return "Student{" +
                "name='" + name + '\'' +
                ", year=" + year +
                ", preferences=" + preferences +
                '}';
    }

    // setters
    void setName(String name) {
        this.name = name;
    }
    void setYear(int year) {
        this.year = year;
    }
    void setPreferences(Project ...preferences) {
        for(Project preference : preferences)
            this.preferences.add(preference);
    }

    // getters

    /**
     * @return an array of preferences of a student
     */
    ArrayList<Project> getPreferences() {
        return this.preferences;
    }
    String getName() {
        return name;
    }
    int getYear() {
        return this.year;
    }
}
