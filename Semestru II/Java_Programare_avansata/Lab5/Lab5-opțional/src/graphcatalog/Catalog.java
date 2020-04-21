/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcatalog;

import graphcatalogcommands.AddCommand;
import graphcatalogcommands.HtmlCommand;
import graphcatalogcommands.ListCommand;
import graphcatalogcommands.LoadCommand;
import graphcatalogcommands.OpenCommand;
import graphcatalogcommands.SaveCommand;
import graphcomponents.Graph;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tifir
 */
public class Catalog implements Serializable {
    public  String path;
    List<Graph> graphs = new ArrayList<>();
    public void add(Graph temp)
    {
      AddCommand tempAdd = new AddCommand();
      this.graphs=tempAdd.addGraphToCatalog(temp,this.graphs);
    }
    public Catalog()
    {
        
    }
    public Catalog(String temp)
    {
        path = temp;
    }
    public void open() throws IOException
    {
       OpenCommand tempOpen = new OpenCommand();
       tempOpen.openCatalog();
    }
    
    public void save() throws FileNotFoundException, IOException
    {

      SaveCommand tempSave=new SaveCommand();
      tempSave.saveCatalog("catalog", this);
      
    }
    public void load() throws IOException, FileNotFoundException, ClassNotFoundException
    {

      LoadCommand tempLoad=new LoadCommand();
      tempLoad.loadCatalog("catalog", this);
    }
    public void list()
    {
        ListCommand tempList=new ListCommand();
        tempList.listCatalog(this.graphs);
    }
    public void html() throws IOException
    {
        HtmlCommand tempHtml = new HtmlCommand();
        tempHtml.reportHTML(path, graphs);
    }
}
