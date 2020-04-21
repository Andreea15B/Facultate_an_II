/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcatalogcommands;

import graphcatalog.Catalog;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

/**
 *
 * @author maria
 */
public class Serialization {
    Catalog catalogSer ;
    public Serialization(Catalog temp)
    {
        this.catalogSer=temp;
    }
    public void SerializeCatalog(String temp) throws FileNotFoundException, IOException
    {
        String path=catalogSer.path+"\\serializaton";
        File saveFile = new File(path);
        saveFile.mkdir();
        File fileToSave = new File(path+"\\"+temp);
        ObjectOutputStream saveCatalog = new ObjectOutputStream(new FileOutputStream(fileToSave.getPath()));
        saveCatalog.writeObject(fileToSave);
        saveCatalog.close();
        
    }
    public void DeSerializeCatalog(String temp) throws FileNotFoundException, IOException, ClassNotFoundException
    {
        String path=catalogSer.path+"\\serializaton";
        File uploadFile = new File(path);
        File fileToUpload = new File(path+"\\"+temp);
        ObjectInputStream uploadCatalog = new ObjectInputStream(new FileInputStream(fileToUpload.getPath()));
        System.out.println("Succses! Path->" + uploadCatalog.readObject());
    }
}
