
public class Test {
    public static void main(String args[]) {
        Hotel h1 = new Hotel("California");
        Hotel h2 = new Hotel("Lila");
        Hotel h3 = new Hotel("Simple");
        Museum m1 = new Museum("Banffy");
        Church c1 = new Church("Black Church");
        Restaurant r1 = new Restaurant("Angels");

        h1.setRank(5);
        h2.setRank(2);
        h3.setRank(1);

        c1.setOpeningHours("8:00", "16:00");
        m1.setEntryFee(10.5);
        r1.setRank(4);

        TravelMap map = new TravelMap();
        map.addNode(h1);
        map.addNode(h2);
        map.addNode(m1);
        map.addNode(c1);
        map.addNode(r1);

        map.addEdge(h1, h2, 15); // two way street by default
        map.addEdge(h3, h2, 1, false); // one-way street

        System.out.println("The map is: \n" + map.getNodes());
    }
}
