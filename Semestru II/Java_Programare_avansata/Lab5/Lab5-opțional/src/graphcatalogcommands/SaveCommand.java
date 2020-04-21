/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcatalogcommands;

import graphcatalog.Catalog;
import java.io.IOException;
import graphcatalogcommandinterface.Save;

/**
 *
 * @author maria
 */
public class SaveCommand implements Save {

    @Override
    public void saveCatalog(String numeCatalog,Catalog catalog) throws IOException {
         Serialization file = new Serialization(catalog);
        file.SerializeCatalog(numeCatalog);
    }
    
}
