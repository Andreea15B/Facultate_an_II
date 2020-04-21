import java.time.Duration;
import java.time.format.DateTimeFormatter;
import java.time.LocalDate;

public interface Visitable {

    void setOpeningHours(String start, String end);
    String getOpeningHours();
    static Duration getVisitingDuration() {
        String start = "09:30", end = "20:00";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("hh:mm");
        LocalDate startTime = LocalDate.parse(start);
        LocalDate endTime = LocalDate.parse(end);
        Duration duration = Duration.between(startTime, endTime);
        return duration;
    }
}
