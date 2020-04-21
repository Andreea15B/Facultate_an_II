  abstract class Triunghi extends FiguraGeometrica {
      public String subcategorie;
     public  Triunghi() {
        laturi = 3;
        categorie = "Triunghi";
    }
      void label2()
      {
          System.out.println(subcategorie);
      }
}