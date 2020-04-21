public class Museum extends Node {
    String name;
    double fee;
    Museum(String name) {
        this.name = name;
    }

    public void setEntryFee(double fee) {
        this.fee = fee;
    }

    public double getEntryFee() {
        return fee;
    }

    @Override
    public String toString() {
        return "Museum{" +
                "name='" + name + '\'' +
                ", fee=" + fee +
                '}';
    }
}
