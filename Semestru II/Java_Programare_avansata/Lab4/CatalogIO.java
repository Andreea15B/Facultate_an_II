import java.io.*;

public class CatalogIO {
    public static void saveCatalog(Catalog catalog, String pathTo) {
        File file = new File(catalog.getPath() + pathTo);
        System.out.println(file.getPath());
        try {
            FileOutputStream fos = new FileOutputStream(file.getPath());
            ObjectOutputStream out = new ObjectOutputStream(fos);
            out.writeObject(catalog);
            out.close();
            fos.close();
        } catch (FileNotFoundException e) {
            System.out.println("Save - File not found!");
        } catch (IOException e) {
            System.out.println("Save - IO exception!");
        } catch (Exception e) {
            System.out.println("Save exception caught!");
        }
    }

    public static void loadCatalog(Catalog catalog, String pathFrom) {
        File file = new File(catalog.getPath() + pathFrom);
        try {
            FileInputStream fis = new FileInputStream(file);
            ObjectInputStream in = new ObjectInputStream(fis);
            catalog = (Catalog) in.readObject();
            System.out.println(catalog);
            fis.close();
        } catch (FileNotFoundException e) {
            System.out.println("Load - File not found!");
        } catch (IOException e) {
            System.out.println("Load - IO exception!");
        } catch (Exception e) {
            System.out.println("Load exception caught!");
        }
    }
}
