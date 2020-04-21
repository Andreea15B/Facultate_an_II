import java.io.*;
import java.util.ArrayList;
import java.awt.Desktop;

public class Catalog implements java.io.Serializable {
    String path;
    ArrayList<Graph> graphs = new ArrayList<>();

    /**
     * Constructor
     * @param path
     */
    Catalog(String path) {
        this.path = path;
    }

    public String getPath() {
        return path;
    }

    @Override
    public String toString() {
        return "Catalog{" +
                "path='" + path + '\'' +
                ", graphs=" + graphs +
                '}';
    }

    public void add(Graph graph) {
        graphs.add(graph);
    }

    /**
     * Opens the image file using the native operating system application.
     * @param graphName
     * @throws Exception
     */
    void open(String graphName) throws Exception {
        for (Graph graph : graphs) {
            if ((graph.getName()).equals(graphName)) {
                Desktop dt = Desktop.getDesktop();
                File file = new File(path + graph.getImagePath());
                dt.open(file);
            }
        }
    }

    /**
     * Prints the content of the catalog on the screen.
     **/
    void list() {
        for (Graph graph : graphs) {
            System.out.println(graph.toString());
        }
    }

    /**
     * Saves the catalog to an external file (either as a text or binary, using object serialization).
     */
    void save(String pathTo) {
        CatalogIO catalogIO = new CatalogIO();
        catalogIO.saveCatalog(this, pathTo);
    }

    /**
     * Loads the catalog from an external file.
     */
    void load(String pathFrom) {
        CatalogIO catalogIO = new CatalogIO();
        catalogIO.loadCatalog(this, pathFrom);
    }
}
