import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

public class Problem {
    private ArrayList<Student> students = new ArrayList();
    public Problem() {}

    @Override
    public String toString() {
        return "Problem{" +
                "students=" + students +
                '}';
    }

    // setter
    void setStudents(Student ...students) {
        for(Student student:students)
            this.students.add(student);
    }

    // getter
    ArrayList<Student> getStudents() {
        return this.students;
    }

    /**
     * @return an array of all the projects (distinct) specified in the students preferences
     */
    ArrayList<Project> getProjects() {
        Set<Project> projects = new HashSet<>(); // lista cu elemente distincte
        for(Student student:students)
            projects.addAll(student.getPreferences());

        // convert Set to ArrayList
        ArrayList<Project> result = new ArrayList<>();
        result.addAll(projects);
        return result;
    }
}
