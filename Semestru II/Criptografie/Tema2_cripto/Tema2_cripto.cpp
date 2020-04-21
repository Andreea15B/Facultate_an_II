#include <iostream>
#include <fstream>
#include <cstring>
#include <cmath>
#define MAX_HEX_LENGTH 100
#define MAX_BIN_LENGTH 400
using namespace std;

void readInput (char plainText[MAX_HEX_LENGTH], char key[MAX_HEX_LENGTH]) {
	ifstream fin("plainText.txt");
	fin >> plainText;
	cout << "Plain text: " << plainText << endl;
	fin.close();

	ifstream fin2("key.txt");
	fin2 >> key;
	cout << "Key: " << key << endl;
	fin2.close();
}

void hexToBinary (char hex[MAX_HEX_LENGTH], char binary[MAX_BIN_LENGTH]) {
	int length = strlen(hex);
	strcpy(binary, "");
	for (int i = 0; i < length; i++)
		switch (hex[i]) {
            case '0': strcat(binary, "0000"); break;
            case '1': strcat(binary, "0001"); break;
            case '2': strcat(binary, "0010"); break;
            case '3': strcat(binary, "0011"); break;
            case '4': strcat(binary, "0100"); break;
            case '5': strcat(binary, "0101"); break;
            case '6': strcat(binary, "0110"); break;
            case '7': strcat(binary, "0111"); break;
            case '8': strcat(binary, "1000"); break;
            case '9': strcat(binary, "1001"); break;
            case 'A': strcat(binary, "1010"); break;
            case 'B': strcat(binary, "1011"); break;
            case 'C': strcat(binary, "1100"); break;
            case 'D': strcat(binary, "1101"); break;
            case 'E': strcat(binary, "1110"); break;
            case 'F': strcat(binary, "1111"); break;
		}
}

void permuteKey (char binaryKey[MAX_BIN_LENGTH]) {
	char newKey[56];
	memset(newKey, 0, sizeof(newKey));
	int PC1[56] = {
		57, 49, 41, 33, 25, 17, 9,
		1, 58, 50, 42, 34, 26, 18,
		10, 2, 59, 51, 43, 35, 27,
		19, 11, 3, 60, 52, 44, 36,
		63, 55, 47, 39, 31, 23, 15,
		7, 62, 54, 46, 38, 30, 22,
		14, 6, 61, 53, 45, 37, 29,
		21, 13, 5, 28, 20, 12, 4
	};
	for(int i = 0; i < 56; i++) newKey[i] = binaryKey[PC1[i] - 1];
	strcpy (binaryKey, newKey);
	binaryKey[56] = '\0';
}

void splitKey (char binaryKey[MAX_BIN_LENGTH], char C0[MAX_BIN_LENGTH], char D0[MAX_BIN_LENGTH]) {
	for (int i = 0; i < 28; i++) C0[i] = binaryKey[i];
	for (int i = 28; i < 56; i++) D0[i-28] = binaryKey[i];
}

void leftShift (char C[MAX_BIN_LENGTH], char D[MAX_BIN_LENGTH], int noOfShifts) {
	char c, d;
	for(int i = 0; i < noOfShifts; i++) {
		c = C[0];
		d = D[0];
		for(int j = 0; j < 27; j++) {
			C[j] = C[j+1];
			D[j] = D[j+1];
		}
		C[27] = c;
		D[27] = d;
	}
}

void getCandD (char binaryKey[MAX_BIN_LENGTH], char C[16][MAX_BIN_LENGTH], char D[16][MAX_BIN_LENGTH]) {
	splitKey(binaryKey, C[0], D[0]);
	for (int i = 1; i < 17; i++) {
		strcpy (C[i], C[i-1]);
		strcpy (D[i], D[i-1]);
		if (i == 1 || i == 2 || i == 9 || i == 16) leftShift(C[i], D[i], 1);
		else leftShift(C[i], D[i], 2);
	}
}

void stickKey (char subKeys[17][MAX_BIN_LENGTH], char C[17][MAX_BIN_LENGTH], char D[17][MAX_BIN_LENGTH]) {
	for (int i = 0; i < 17; i++) {
		strcpy (subKeys[i], C[i]);
		strcat (subKeys[i], D[i]);
	}
}

void get16Keys (char keys[17][MAX_BIN_LENGTH], char hexKey[MAX_HEX_LENGTH]) {
	char binaryKey[MAX_BIN_LENGTH];
	char C[17][MAX_BIN_LENGTH], D[17][MAX_BIN_LENGTH];
	char subKeys[17][MAX_BIN_LENGTH], newKey[17][MAX_BIN_LENGTH];

    memset(C, 0, sizeof(C));
    memset(D, 0, sizeof(D));
    memset(subKeys, 0, sizeof(subKeys));
    memset(newKey, 0, sizeof(newKey));

	hexToBinary(hexKey, binaryKey);
	permuteKey(binaryKey);
	getCandD(binaryKey, C, D);
	stickKey(subKeys, C, D);

	int PC2[48] = {
		14, 17, 11, 24, 1, 5,
		3, 28, 15, 6, 21, 10,
		23, 19, 12, 4, 26, 8,
		16, 7, 27, 20, 13, 2,
		41, 52, 31, 37, 47, 55,
		30, 40, 51, 45, 33, 48,
		44, 49, 39, 56, 34, 53,
		46, 42, 50, 36, 29, 32
	};
	for (int i = 0; i < 17; i++) {
		for (int j = 0; j < 48; j++) newKey[i][j] = subKeys[i][PC2[j] - 1];
		newKey[i][48] = '\0';
	}
	for (int i = 0; i < 16; i++) strcpy (keys[i], newKey[i+1]);
}

void initialPermutation (char binaryText[MAX_BIN_LENGTH]) {
	char newText[64];
	memset(newText, 0, sizeof(newText));
	int IP[64] = {
		58, 50, 42, 34, 26, 18, 10, 2,
		60, 52, 44, 36, 28, 20, 12, 4,
		62, 54, 46, 38, 30, 22, 14, 6,
		64, 56, 48, 40, 32, 24, 16, 8,
		57, 49, 41, 33, 25, 17, 9, 1,
		59, 51, 43, 35, 27, 19, 11, 3,
		61, 53, 45, 37, 29, 21, 13, 5,
		63, 55, 47, 39, 31, 23, 15, 7
	};
	for (int i = 0 ; i < 64; i++) newText[i] = binaryText[IP[i] - 1];
	strcpy (binaryText, newText);
	binaryText[64] = '\0';
}

void splitText (char binaryText[MAX_BIN_LENGTH], char L[MAX_BIN_LENGTH], char R[MAX_BIN_LENGTH]) {
	for (int i = 0; i < 32; i++) L[i] = binaryText[i];
	for (int i = 32 ; i < 64; i++) R[i-32] = binaryText[i];
}

void E (char R[MAX_BIN_LENGTH]) { // expansion function (32 bits to 48 bits)
	char tempR[MAX_BIN_LENGTH];
	memset(tempR, 0, sizeof(tempR));
	int E[48] = {
		32, 1, 2, 3, 4, 5,
		4, 5, 6, 7, 8, 9,
		8, 9, 10, 11, 12, 13,
		12, 13, 14, 15, 16, 17,
		16, 17, 18, 19, 20, 21,
		20, 21, 22, 23, 24, 25,
		24, 25, 26, 27, 28, 29,
		28, 29, 30, 31, 32, 1
	};
	for (int i = 0; i < 48; i++) tempR[i] = R[E[i] - 1];
	strcpy (R, tempR);
	R[48] = '\0';
}

char xorBits (char bit1, char bit2) {
	switch (bit1) {
        case '0':
            switch (bit2) {
                case '0': return '0';
                case '1': return '1';
            }
        case '1':
            switch (bit2) {
                case '0': return '1';
                case '1': return '0';
            }
	}
}

void decToBin (int dec, char binary[4]) {
	int i;
	for (i = 0; i < 4; i++) binary[i] = '0';
	binary[4] = '\0';
	i = 3;
	while (dec != 0) {
		binary[i--] = dec%2 + '0';
		dec = dec/2;
	}
}

void turnTo6BitBoxes (char bitChain[MAX_BIN_LENGTH], char bitBoxes[8][7]) {
	for (int i = 0; i < strlen(bitChain); i ++) bitBoxes[i/6][i%6] = bitChain[i];
	for (int i = 0; i < 8; i++) bitBoxes[i][6] = '\0';
}

void S (int s, char bitBox[7], char res[4]) {
	int row, col, result;
	int S[512] = {
		14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7,
		0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8,
		4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0,
		15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13,
		15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10,
		3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5,
		0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15,
		13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9,
		10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8,
		13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1,
		13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7,
		1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12,
		7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15,
		13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9,
		10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4,
		3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14,
		2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9,
		14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6,
		4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14,
		11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3,
		12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11,
		10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8,
		9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6,
		4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13,
		4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1,
		13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6,
		1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2,
		6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12,
		13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7,
		1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2,
		7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8,
		2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11
	};

	row = (bitBox[0] - '0')*2 + (bitBox[5] - '0');
	col = (bitBox[1] - '0')*8 + (bitBox[2] - '0')*4 + (bitBox[3] - '0')*2 + (bitBox[4] - '0');
	result = S[64*(s-1) + row*16 + col]; // fiecare S-box are 64 de valori si 16 randuri
	decToBin (result, res);
}

void permuteP (char B[32]) {
	char tempB[32];
	memset(tempB, 0, sizeof(tempB));
	int P[32] = {
		16, 7, 20, 21,
		29, 12, 28, 17,
		1, 15, 23, 26,
		5, 18, 31, 10,
		2, 8, 24, 14,
		32, 27, 3, 9,
		19, 13, 30, 6,
		22, 11, 4, 25
	};
	for (int i = 0; i < 32; i++) tempB[i] = B[P[i] - 1];
	strcpy (B, tempB);
}

void f (char R[MAX_BIN_LENGTH], char keys[MAX_BIN_LENGTH], char result[MAX_BIN_LENGTH]) {
	char bitBoxes[8][7], B[8][4];
	memset(bitBoxes, 0, sizeof(bitBoxes));
	memset(B, 0, sizeof(B));
	E(R); // R is expanded from 32 bits to 48 bits
	for (int i = 0; i < 48; i++) result[i] = xorBits(R[i], keys[i]);
	turnTo6BitBoxes (result, bitBoxes); // 8 boxes
	for (int i = 0; i < 8; i++) S(i+1, bitBoxes[i], B[i]);
	for (int i = 0; i < 32; i++) result[i] = B[i/4][i%4];
	result[32] = '\0';
	permuteP(result);
}

void getLandR (char keys[16][MAX_BIN_LENGTH], char L[17][MAX_BIN_LENGTH], char R[17][MAX_BIN_LENGTH], int flag) {
	char result[48];
	memset(result, 0, sizeof(result));
	if(flag == 1) { // encrypt
        for (int i = 1; i < 17; i++) {
            strcpy (L[i], R[i-1]); // building L
            f(R[i-1], keys[i-1], result);
            for (int j = 0; j < 32; j++) R[i][j] = xorBits(L[i-1][j], result[j]); // building R
            R[i][32] = '\0';
        }
	}
	else { // decrypt
        for (int i = 1; i < 17; i++) {
            strcpy (L[i], R[i-1]); // building L
            f(R[i-1], keys[16-i], result); // keys are in reversed order
            for (int j = 0; j < 32; j++) R[i][j] = xorBits(L[i-1][j], result[j]); // building R
            R[i][32] = '\0';
        }
	}
}

void finalIP (char block[MAX_BIN_LENGTH]) {
	char tempBlock[MAX_BIN_LENGTH];
	memset(tempBlock, 0, sizeof(tempBlock));
	int IP[64] = { // IP ^ (-1)
	    40, 8, 48, 16, 56, 24, 64, 32, 39, 7, 47, 15, 55, 23, 63, 31, 38, 6, 46, 14, 54, 22, 62, 30, 37, 5, 45, 13, 53, 21, 61, 29,
	    36, 4, 44, 12, 52, 20, 60, 28, 35, 3, 43, 11, 51, 19, 59, 27, 34, 2, 42, 10, 50, 18, 58, 26, 33, 1, 41, 9, 49, 17, 57, 25};
	for (int i = 0; i < 64; i++) tempBlock[i] = block[IP[i] - 1];
	strcpy (block, tempBlock);
	block[64] = '\0';
}

void binaryToHex (char binary[MAX_BIN_LENGTH], char hex[MAX_HEX_LENGTH]) {
	int length = strlen (binary), n = 0, decimal = 0;
	for (int i = 0; i <= length; i ++) {
		if (i % 4 == 0 && i != 0) {
			switch (decimal) {
                case 0: hex[n++] = '0'; break;
                case 1: hex[n++] = '1'; break;
                case 2: hex[n++] = '2'; break;
                case 3: hex[n++] = '3'; break;
                case 4: hex[n++] = '4'; break;
                case 5: hex[n++] = '5'; break;
                case 6: hex[n++] = '6'; break;
                case 7: hex[n++] = '7'; break;
                case 8: hex[n++] = '8'; break;
                case 9: hex[n++] = '9'; break;
                case 10: hex[n++] = 'A'; break;
                case 11: hex[n++] = 'B'; break;
                case 12: hex[n++] = 'C'; break;
                case 13: hex[n++] = 'D'; break;
                case 14: hex[n++] = 'E'; break;
                case 15: hex[n++] = 'F'; break;
			}
			decimal = 0;
		}
		if (binary[i] == '1') decimal += pow(2.0, (3 - i%4));
	}
}

void encode64BitBlocks (char hexText[MAX_HEX_LENGTH], char keys[16][MAX_BIN_LENGTH], int flag) {
	char binaryText[MAX_BIN_LENGTH], L[17][MAX_BIN_LENGTH], R[17][MAX_BIN_LENGTH], result[MAX_BIN_LENGTH], finalBlock[MAX_BIN_LENGTH], finalHex[MAX_HEX_LENGTH];
	memset(binaryText, 0, sizeof(binaryText));
	memset(L, 0, sizeof(L));
	memset(R, 0, sizeof(R));
	memset(result, 0, sizeof(result));
	memset(finalBlock, 0, sizeof(finalBlock));
	memset(finalHex, 0, sizeof(finalHex));

	hexToBinary (hexText, binaryText);
	initialPermutation (binaryText);
	splitText (binaryText, L[0], R[0]);
	getLandR (keys, L, R, flag);

	strcpy (finalBlock, R[16]);
	strcat (finalBlock, L[16]);
	finalIP (finalBlock); // final permutation
	binaryToHex (finalBlock, finalHex);

	if(flag == 1) { // encrypt
        ofstream fout("cypherText.txt");
        fout << finalHex; // the cyphertext
        //cout << "Cypher text: " << finalHex << endl;
        fout.close();
	}
	else { // decrypt
        ofstream fout("cypherText.txt");
        fout << finalHex; // the plaintext
        //cout << "Plain text: " << finalHex << endl;
        fout.close();
	}
}

void DES (char hexText[MAX_HEX_LENGTH], char hexKey[MAX_HEX_LENGTH], int flag) {
	char sixteenKeys[16][MAX_BIN_LENGTH];
	memset(sixteenKeys, 0, sizeof(sixteenKeys));
	get16Keys(sixteenKeys, hexKey);
	encode64BitBlocks(hexText, sixteenKeys, flag);
}

void readCypher (char cypherText[MAX_HEX_LENGTH], char key[MAX_HEX_LENGTH]) {
    ifstream fin("cypherText.txt");
	fin >> cypherText;
	cout << "Cypher text: " << cypherText << endl;
	fin.close();

	ifstream fin2("key.txt");
	fin2 >> key;
	cout << "Key: " << key << endl;
	fin2.close();
}

void meetAttack(char hexPlainText[MAX_HEX_LENGTH], char hexCypherText[MAX_HEX_LENGTH]) {
    // encryption
    char keysEn[17 * MAX_HEX_LENGTH][MAX_HEX_LENGTH], key[MAX_HEX_LENGTH], encrypted[17*MAX_HEX_LENGTH][MAX_HEX_LENGTH];
    memset(keysEn, '0', sizeof(keysEn));
    memset(key, '0', sizeof(key));
    key[17] = 0;
    int i, line = 0;
    char j;
    for(i = 0; i < 16; i++) {
        for(j='0'; j<='F'; j++) {
            key[i] = j;
            strcpy(keysEn[line++], key);
            if (j == '9') j = 'A' - 1;
        }
        key[i] = '0';
    }

    for(i = 0; i < line; i++) {
        DES(hexPlainText, keysEn[i], 1);
        ifstream fin("cypherText.txt");
        fin >> encrypted[i];
        fin.close();
    }

    // decryption
    char keysDe[17 * MAX_HEX_LENGTH][MAX_HEX_LENGTH], decrypted[17*MAX_HEX_LENGTH][MAX_HEX_LENGTH];
    memset(keysDe, '0', sizeof(keysDe));
    memset(key, '0', sizeof(key));
    key[17] = 0;
    line = 0;
    for(i = 0; i < 16; i++) {
        for(j='0'; j<='F'; j++) {
            key[i] = j;
            strcpy(keysDe[line++], key);
            if (j == '9') j = 'A'-1;
        }
        key[i] = '0';
    }
    for(i = 0; i < line; i++) {
        DES(hexCypherText, keysDe[i], 2);
        ifstream fin2("cypherText.txt");
        fin2 >> decrypted[i];
        fin2.close();
    }

    // find key
    for(i = 0; i < line; i++) {
        for(int j = 0; j < line; j++) {
            //cout << encrypted[i] << " " << decrypted[j] << endl;
            if(strcmp(encrypted[i], decrypted[j]) == 0) {
                cout << "Found keys: " << keysEn[i] << " " << keysDe[j] << endl;
            }
        }
    }
}

int main() {
    char hexText[MAX_HEX_LENGTH], hexKey[MAX_HEX_LENGTH], hexCypherText[MAX_HEX_LENGTH], hexKey2[MAX_HEX_LENGTH], tempResult[MAX_HEX_LENGTH];
    memset(hexText, 0, sizeof(hexText));
    memset(hexKey, 0, sizeof(hexKey));
    memset(hexCypherText, 0, sizeof(hexCypherText));
    memset(hexKey2, 0, sizeof(hexKey2));
    memset(tempResult, 0, sizeof(tempResult));
    int flag;
    cout << "1. DES encryption \n2. DES decryption \n3. 2DES encryption \n4. 2DES decryption\n5. Meet-in-the-middle attack\n";
    cin >> flag;
    if(flag == 1) { // encrypt
        readInput (hexText, hexKey);
        DES (hexText, hexKey, flag);
    }
    else if(flag == 2) { // decrypt
        readCypher (hexCypherText, hexKey);
        DES (hexCypherText, hexKey, flag);
    }
    else if(flag == 3) {
        readInput(hexText, hexKey);
        ifstream fin("key.txt");
        fin >> hexKey;
        fin >> hexKey2;
        cout << "Key 2: " << hexKey2 << endl;
        fin.close();

        DES(hexText, hexKey, 1); // encrypt

        ifstream fin2("cypherText.txt");
        fin2 >> tempResult;
        fin2.close();

        DES(tempResult, hexKey2, 1); // encrypt
    }
    else if(flag == 4) {
        readCypher (hexCypherText, hexKey);
        ifstream fin("key.txt");
        fin >> hexKey;
        fin >> hexKey2;
        cout << "Key 2: " << hexKey2 << endl;
        fin.close();

        DES(hexCypherText, hexKey2, 2); // decrypt

        ifstream fin2("cypherText.txt");
        fin2 >> tempResult;
        fin2.close();

        DES(tempResult, hexKey, 2); // decrypt
    }
    else { // meet-in-the-middle attack
        ifstream fin("plainText.txt");
        fin >> hexText;
        fin.close();
        ifstream fin2("cypherText.txt");
        fin2 >> hexCypherText;
        fin2.close();

        meetAttack(hexText, hexCypherText);
    }
    return 0;
}
