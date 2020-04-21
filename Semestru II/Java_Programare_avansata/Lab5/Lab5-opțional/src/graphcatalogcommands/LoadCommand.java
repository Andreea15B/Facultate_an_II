/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcatalogcommands;
import graphcatalog.Catalog;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import graphcatalogcommandinterface.Load;
/**
 *
 * @author maria
 */
public class LoadCommand implements Load {

    @Override
    public void loadCatalog(String numeCatalog,Catalog catalog) throws IOException, FileNotFoundException {
    Serialization file = new Serialization(catalog);
        try {
            file.DeSerializeCatalog(numeCatalog);
        } catch (ClassNotFoundException ex) {
            System.out.println("error?");
        }
    }
    
}
