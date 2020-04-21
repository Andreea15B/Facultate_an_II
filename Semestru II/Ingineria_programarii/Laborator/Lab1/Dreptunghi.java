class Dreptunghi extends Patrulater {
    double latime, lungime;
    public Dreptunghi() {
        latime = 4;
        lungime = 5;
        subcategorie="Dreptunghi" ;
    }
    void aria() {
        System.out.println(latime*lungime);
    }
    void perimetru() {
        System.out.println(2*latime+2*lungime);
    }
}