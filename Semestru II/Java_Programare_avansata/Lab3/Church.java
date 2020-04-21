public class Church extends Node implements Visitable{
    String name, startHour, endHour;
    Church(String name) {
        this.name = name;
    }

    public void setOpeningHours(String start, String end) {
        startHour = start;
        endHour = end;
    }

    public String getOpeningHours() {
        String hours = startHour + " - " + endHour;
        return hours;
    }

    @Override
    public String toString() {
        return "Church{" +
                "name='" + name + '\'' +
                ", startHour='" + startHour + '\'' +
                ", endHour='" + endHour + '\'' +
                Visitable.getVisitingDuration() + 
                '}';
    }
}
