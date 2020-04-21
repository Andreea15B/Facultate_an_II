import java.time.LocalDate;
import java.util.Objects;

/**
 * Essays are a type of projects that have the property topic.
 */
public class Essay extends Project {
   Topic topic;
   Essay(String name, LocalDate date, Topic topic) {
       this.name = name;
       this.deadline = date;
       this.topic = topic;
   }

    @Override
    public String toString() {
        return "Essay{" +
                "topic=" + topic +
                '}';
    }

    // setters
    void setName(String name) {
        this.name = name;
    }
    void setDeadline(LocalDate date) {
        this.deadline = date;
    }
    void setTopic(Topic topic) {
        this.topic = topic;
    }

    // getters
    String getName() {
        return this.name;
    }
    LocalDate getDeadline() {
        return this.deadline;
    }
    Topic getTopic() {
        return this.topic;
    }
}
