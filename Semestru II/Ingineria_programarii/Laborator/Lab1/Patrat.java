 class Patrat extends Patrulater {
    double latime;
    public Patrat() {
        latime = 4;
        subcategorie="Patrat" ;
    }

    void aria() {
        System.out.println(latime*latime);
    }
    void perimetru() {
        System.out.println(4*latime);
    }
}