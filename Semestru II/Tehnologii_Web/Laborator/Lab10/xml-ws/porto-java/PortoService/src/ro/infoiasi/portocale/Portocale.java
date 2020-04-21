/* Pachet ce incapsuleaza implementarea unui serviciu Web
 *  prin paradigma SOAP (se recurge la JAX-WS).
 *  Furnizeaza informatii despre stocuri de portocale.  
 *  Autor: Sabin Buraga -- http://profs.info.uaic.ro/~busaco/
 *  Ultima actualizare: 11 aprilie 2016
 */
package ro.infoiasi.portocale;

import javax.jws.WebService;
import javax.jws.WebMethod; 

@WebService
public class Portocale { // clasa ce implementeaza serviciul Web

	@WebMethod
	// o metoda publica returnand stocul de portocale
	public Integer furnizeazaStoc (String sortiment) {
		// aici ar fi trebuit o interogare "adevarata"
		if (sortiment.equals ("albastre"))
			return 33;
		return 0;
	}

	@WebMethod
	// o alta metoda publica 
	public Double furnizeazaPret () {
		return 7.50; // pret fix, fictiv
	}
}