/* Pachet continand o clasa ce publica serviciul Web
 * (nu necesita un server Web distinct).
 * Autor: Sabin Buraga -- http://profs.info.uaic.ro/~busaco/
 * Ultima actualizare: 11 aprilie 2016
 */
package ro.infoiasi.portocale.serviciu;

import javax.xml.ws.Endpoint;
import ro.infoiasi.portocale.*;

public class ServiciuExpus {

	public static void main (String[] args) {
		try {
			// publicam la URL-ul specificat serviciul Web 
			// implementat de clasa definita in Portocale.java
			Endpoint.publish ("http://localhost:8888/porto", 
					new Portocale ());
		} catch (Exception e) {
			System.err.println ("A survenit o exceptie... \n" + 
					e.getMessage ());
		}
	}
}
