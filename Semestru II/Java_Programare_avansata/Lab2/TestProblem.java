import java.time.LocalDate;
import java.time.Month;
import java.util.ArrayList;

/**
 * @author Andreea Bucataru and Maria Bulboaca;
 */
public class TestProblem {
    public static void main(String args[]) {
        Student s1 = new Student("S1", 2);
        Student s2 = new Student("S2", 3);
        Student s3 = new Student("S3", 1);
        Student s4 = new Student("S4", 2);

        System.out.println(s1.getName() + ' ' + s1.getYear());

        ArrayList<Project> projects = new ArrayList<>();

        Application a1 = new Application("A1", LocalDate.of(2019, Month.JUNE, 1), Language.JAVA);
        Application a2 = new Application("A2", LocalDate.of(2019, Month.JULY, 1), Language.C);
        Application a3 = new Application("A3", LocalDate.of(2019, Month.AUGUST, 3), Language.PHP);
        projects.add(a1); projects.add(a2); projects.add(a3);

        System.out.println(a1.getName() + ' ' + a1.getDeadline() + ' ' + a1.getLanguage());

        Essay e1 = new Essay("E1", LocalDate.parse("2019-06-01"), Topic.ALGORITHMS);
        Essay e2 = new Essay("E2", LocalDate.parse("2019-07-01"), Topic.DATABASES);
        projects.add(e1); projects.add(e2);

        System.out.println(e1.getName() + ' ' + e1.getDeadline() + ' ' + e1.getTopic());

        s1.setPreferences(a1, a2, a3);
        s2.setPreferences(a1, e1);
        s3.setPreferences(a2, a3, e1);
        s4.setPreferences(a3, e2);

        System.out.println("Preferences for " + s1.getName() + ": " + s1.getPreferences());

        Problem problem = new Problem();
        problem.setStudents(s1, s2, s3, s4);

        System.out.println("Students: " + problem.getStudents());
        System.out.println("Projects: " + problem.getProjects());

        Matching matching = new Matching();
        System.out.println(matching.allocateStudentToProject(problem.getStudents(), projects).toString());
    }
}