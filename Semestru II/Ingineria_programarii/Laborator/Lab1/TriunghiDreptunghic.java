public class TriunghiDreptunghic extends Triunghi
{
        double cateta,ipotenuza,latura;
        public TriunghiDreptunghic (){
            subcategorie="Triunghi Dreptunghi";
            cateta=2;
            ipotenuza=6;
            latura=3;
        }
    void aria() {
        System.out.println(cateta*ipotenuza/2);
    }
    void perimetru() {
        System.out.println(cateta+ipotenuza+latura);
    }
}
