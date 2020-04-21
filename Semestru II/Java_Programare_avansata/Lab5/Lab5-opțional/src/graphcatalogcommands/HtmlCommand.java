/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcatalogcommands;

import graphcomponents.Graph;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import graphcatalogcommandinterface.Html;

/**
 *
 * @author maria
 */
public class HtmlCommand implements Html {

    @Override
    public void reportHTML(String location,List<Graph> catalog) throws FileNotFoundException,IOException {
     String List="<p0>";
     String tempLocation = location +"\\catalog.html";
     int indexHeader=1;
      for(Graph i:catalog)
      {     
        File tempFile = new File(i.getDefinitionFilePath());
        BufferedReader tempBr = new BufferedReader(new FileReader(tempFile));
        List+="<h"+indexHeader+">"+i.getName()+"</h"+indexHeader+">";;
        List+=tempBr.lines().collect(Collectors.joining("<br />"));
        indexHeader++;
      }
           
           List+="</p0>";
      BufferedWriter writer = new BufferedWriter(new FileWriter(tempLocation));
        String htmlFile = " <!DOCTYPE html>\n" +
"<html>\n" +
"<head>\n" +
"<title>Catalog:</title>\n" +
"</head>\n" +
"<body>\n" +
"\n" +
List +
"\n" +
"</body>\n" +
"</html> ";
        writer.write(htmlFile);
        writer.close();
    }
    
}
