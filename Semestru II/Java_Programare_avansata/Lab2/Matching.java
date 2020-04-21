import java.util.ArrayList;

/**
 * We consider the problem of allocating students to projects, such that each student receives one acceptable project.
 * A student may be enrolled in at most one project. A project may be assigned to at most one student.
 */
public class Matching {
    ArrayList<Match> allocateStudentToProject(ArrayList<Student> students, ArrayList<Project> projects) {
        ArrayList<Match> matches = new ArrayList<>();
        boolean gasit;
        for (Student student: students){
            gasit = false;
            for (Project preference: student.getPreferences())
            if (projects.contains(preference)) {
                matches.add(new Match(student, preference));
                projects.remove(preference);
                gasit = true;
                break;
            }
            if(gasit == false) {
                matches.add(new Match(student, projects.get(0)));
                projects.remove(projects.get(0));
            }
        }
        return matches;
    }
}
