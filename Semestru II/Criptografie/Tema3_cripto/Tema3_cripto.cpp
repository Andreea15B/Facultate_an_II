#include <NTL/ZZ.h>
#include <fstream>

using namespace std;
using namespace NTL;

#define PRIME_LENGTH 1024

void generateN(ZZ &p, ZZ &q, ZZ &n, ZZ &phi) {

	p = GenPrime_ZZ(PRIME_LENGTH, 80);
	q = GenPrime_ZZ(PRIME_LENGTH, 80);
	//p = 2357; q = 2551;
	n = p * q;
	phi = (p - 1)*(q - 1);
}

ZZ generateE(ZZ phi) {
	ZZ e, gcd;
	do {
		e = RandomBnd(phi); // 1 < e < phi
		//e = 3674911;
		gcd = GCD(e, phi);
	} while (gcd != 1);
	return e;
}

void generateKeys(ZZ &phi, ZZ &e, ZZ &d) {
	e = generateE(phi);
	d = InvMod(e, phi); // ed = 1 mod phi
}

void sendPublicKey(ZZ n, ZZ e) {
	ofstream fout("./files/PublicKey.txt");
	fout << n << endl << e;
	fout.close();
}

void getCypherText(ZZ &c) {
	ifstream fin("./files/CypherText.txt");
	fin >> c;
	fin.close();
}

void getKey(ZZ &n, ZZ &e) {
	//  Obtain A’s authentic public key (n, e)
	ifstream fin("./files/PublicKey.txt");
	fin >> n >> e;
	fin.close();
}

void getInput(ZZ &input) {
	// the message as an integer m in the interval [0, n − 1]
	ifstream fin("./files/PlainText.txt");
	fin >> input;
}

void sendCypherText(ZZ c) {
	ofstream fout("./files/CypherText.txt");
	fout << c;
	fout.close();
}

int main()
{
	ZZ p, q, n, phi, e, d, c, m;
	cout << "Generating keys...\n";
	generateN(p, q, n, phi);
	generateKeys(phi, e, d);
	// A’s public key is (n, e)
	// A’s private key is d
	sendPublicKey(n, e);
	cout << "Keys generated.\n";

	int f;
	while (1) {
		cout << "\n1. Encrypt 2. Decrypt 3. Decrypt with CRT 4. Exit\n\n";
		cin >> f;
		if (f == 1) { // encrypt
			getKey(n, e);
			getInput(m);
			cout << "Input received: " << m << "\n";
			c = PowerMod(m, e, n); // c = m^e mod n
			sendCypherText(c);
			cout << "Encrypted text: " << c << "\n";
		}
		if (f == 2) { // decrypt
			getCypherText(c);
			m = PowerMod(c, d, n); // m = c^d mod n
			cout << "Encrypted text: " << c << "\n";
			cout << "Decrypted text: " << m << "\n";
		}
		if (f == 3) { // decrypt with CRT
			getCypherText(c);
			ZZ dP, dQ, qInv, m1, m2, h;

			dP = d % (p - 1);
			dQ = d % (q - 1);
			qInv = InvMod(q % p, p);

			m1 = PowerMod(c % p, dP, p); // m1 = c^(dP) mod p
			m2 = PowerMod(c % q, dQ, q); // m2 = c^(dQ) mod q
			if ((m1 - m2) > 0) h = qInv * (m1 - m2) % p;
			else h = qInv * (m1 - m2 + p) % p;
			m = m2 + h * q;

			cout << "dP = " << dP << "\ndQ = " << dQ << "\nqInv = " << qInv << "\nm1 = " << m1 << "\nm2 = " << m2 << "\nh = " << h << "\n\n";
			cout << "Decrypted input: " << m << "\n";
		}
		if (f == 4) { // exit
			break;
		}
	}
}