public class Restaurant extends Node {
    String name;
    int rank;
    Restaurant(String name) {
        this.name = name;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    public int getRank() {
        return rank;
    }

    @Override
    public String toString() {
        return "Restaurant{" +
                "name='" + name + '\'' +
                ", rank=" + rank +
                '}';
    }
}
