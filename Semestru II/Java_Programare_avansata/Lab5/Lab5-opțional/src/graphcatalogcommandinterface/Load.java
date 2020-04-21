/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcatalogcommandinterface;

import graphcatalog.Catalog;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 *
 * @author maria
 */
public interface Load {
    public void loadCatalog(String numeCatalog,Catalog catalog)throws IOException, FileNotFoundException;
}
