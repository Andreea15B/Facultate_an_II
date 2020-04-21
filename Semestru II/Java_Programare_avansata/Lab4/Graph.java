public class Graph implements java.io.Serializable {
    String name, pathTGF, pathImage;
    /**
     * Constructor
     * @param name
     * @param pathTGF
     * @param pathImage
     */
    Graph(String name, String pathTGF, String pathImage) throws InvalidData {
        this.name = name;
        if(!pathTGF.substring(pathTGF.length() - 4).equals(".tgf")) throw new InvalidData("Invalid TGF path!");
        if(!pathImage.substring(pathImage.length() - 4).equals(".png")) throw new InvalidData("Image must be .png!");
        this.pathImage = pathImage;
        this.pathTGF = pathTGF;
    }
    public String getName() {
        return name;
    }
    public String getTgfPath() {
        return pathTGF;
    }
    public String getImagePath() {
        return pathImage;
    }
    @Override
    public String toString() {
        return "Graph{" +
                "name='" + name + '\'' +
                ", pathTGF='" + pathTGF + '\'' +
                ", pathImage='" + pathImage + '\'' +
                '}';
    }
}
