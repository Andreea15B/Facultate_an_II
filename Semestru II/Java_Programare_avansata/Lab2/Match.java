import java.util.ArrayList;

/**
 * The class Match represents the pairs of students and the projects that were allocated to them.
 */
public class Match {
    private Project project;
    private Student student;

    @Override
    public String toString() {
        return "(" + student.getName() + ", " + project.getName() + ")";
    }

    Match(Student student, Project project){
        this.student = student;
        this.project = project;
    }
}