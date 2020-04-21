public class Hotel extends Node implements Classifiable {
    String name;
    int rank;
    Hotel(String name) {
        this.name = name;
    }


    @Override
    public void setRank(int rank) {
        this.rank = rank;
    }

    @Override
    public int getRank() {
        return rank;
    }

    @Override
    public String toString() {
        return "Hotel{" +
                "name='" + name + '\'' +
                ", rank=" + rank +
                '}';
    }
}
