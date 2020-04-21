#include <iostream>
#include <cstring>
#include <fstream>
#define KEY_LENGTH 100
#define PT_LENGTH 100000
#define CT_LENGTH 100000
using namespace std;
int noEq[91];
char chrEq[26];

void readPlaintext(char plainText[PT_LENGTH]) {
	ifstream fin("plaintext.txt");
	fin.getline(plainText, PT_LENGTH);
	fin.close();
}

void readKey(char key[KEY_LENGTH]) {
	cout << "Key: ";
	cin.getline(key, KEY_LENGTH);
}

void readCyphertext(char cypherText[CT_LENGTH]) {
	ifstream fin("cyphertext.txt");
	fin.getline(cypherText, CT_LENGTH);
	fin.close();
}

void setCharNumberEquivalency() {
	int no = 0;
	char chr = 'A';
	for(char i = 'A'; i <= 'Z'; i++) noEq[i] = no++;
	for(int i = 0; i < 26; i++) chrEq[i] = chr++;
}

void turnToUpperCase(char text[PT_LENGTH]) {
	char newText[PT_LENGTH];
	int newLength = 0;
	for(int i = 0; i < strlen(text); i++) {
		if(text[i] >= 'a' && text[i] <= 'z') newText[newLength++] = text[i] - 32;
		if(text[i] >= 'A' && text[i] <= 'Z') newText[newLength++] = text[i];
	}
	for(int i = 0; i < newLength; i++) text[i] = newText[i];
	text[newLength] = '\0';
}

void encryptVigenere(char key[KEY_LENGTH], char plainText[PT_LENGTH], char cypherText[PT_LENGTH]) {
	int	keyLength = strlen(key);
	for(int i = 0; i <= strlen(plainText); i++)
		cypherText[i] = chrEq [(noEq[plainText[i]] + noEq[key[i % keyLength]]) % 26];
	cypherText[strlen(plainText)] = '\0';
}

void writeCypherText(char cypherText[PT_LENGTH]) {
	ofstream fout("cyphertext.txt");
	fout << cypherText;
	fout.close();
}

void substring(char cypherText[PT_LENGTH], int keyLength, char subString[PT_LENGTH], int j) {
	int ctLength = strlen(cypherText), it = 0;
	for(int i = j; i < ctLength; i = i + keyLength) subString[it++] = cypherText[i];
	subString[it] = '\0';
}

void letterFrequency(char cypherText[PT_LENGTH], double frequency[26]) {
	int ctLength = strlen(cypherText);
	for(int i = 0; i < 26; i++) frequency[i] = 0;
	for(int i = 0; i < ctLength; i++)
        frequency[noEq[cypherText[i]]]++;
}

double coincidenceIndex(char alpha[PT_LENGTH], double frequency[26]) {
	double IC = 0, aLength = strlen(alpha);
	for (int i = 0; i < 26; i++)
		IC += (frequency[i] / aLength)*((frequency[i]-1) / (aLength - 1));
	return IC;
}

bool isGoodEnough(double IC) {
	if (IC <= 0.07 && IC >= 0.061) return true;
	return false;
}

int getKeyLength(char cypherText[PT_LENGTH]) {
	bool found = false;
	char alpha[PT_LENGTH];
	int keyLength = 0, ctLength = strlen(cypherText);
	double IC = 0, frequencyAlpha[26];

	while(!found && keyLength <= KEY_LENGTH) {
		keyLength++;
		found = true;
		for(int j = 0; j < keyLength; j++) {
			substring(cypherText, keyLength, alpha, j);
			letterFrequency(alpha, frequencyAlpha);
			IC = coincidenceIndex(alpha, frequencyAlpha);
			if(!isGoodEnough(IC)) found = false;
		}
	}
	return keyLength;
}

void shift(char text[PT_LENGTH], int s) {
	int tLength = strlen(text);
	for (int i = 0; i < tLength; i ++)
		text[i] = chrEq[(noEq[text[i]]+s) % 26];
}

double mutualCoincidenceIndex(char alpha[PT_LENGTH], double frequencyAlpha[PT_LENGTH]) {
	double probability[26] = { 0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02228, 0.02015, 0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056, 0.02758, 0.00978, 0.02360, 0.00150, 0.01974, 0.00074 };
	double MIC = 0, aLength = strlen(alpha);
	for (int i = 0; i < 26; i ++)
		MIC += (frequencyAlpha[i] / aLength) * probability[i];
	return MIC;
}

void getKey(char cypherText[PT_LENGTH], int keyLength, char key[KEY_LENGTH], char plainText[PT_LENGTH]) {
	bool found = false;
	char alpha[PT_LENGTH];
	int  s, ctLength = strlen(cypherText);
	double MIC = 0, frequencyAlpha[26];

	for(int j = 0; j < keyLength; j++) {
		s = -1;
		do {
			s++;
			substring(cypherText, keyLength, alpha, j);
			shift(alpha, s);
			letterFrequency(alpha, frequencyAlpha);
			MIC = mutualCoincidenceIndex(alpha, frequencyAlpha);
		} while(!isGoodEnough(MIC));
		key[j] = chrEq[(26-s) % 26];
	}
	key[keyLength] = '\0';
}

void getDecryptedText(char cypherText[PT_LENGTH], char key[KEY_LENGTH], char plainText[PT_LENGTH]) {
	int	keyLength = strlen(key);
	for(int i = 0; i <= strlen(cypherText); i++)
		plainText[i] = chrEq[(26 + (noEq[cypherText[i]] - noEq[key[i % keyLength]])) % 26];
	plainText[strlen(plainText)] = '\0';
}

void decryptVigenere(char cypherText[PT_LENGTH], char plainText[PT_LENGTH]) {
	char key[KEY_LENGTH], decryptedText[PT_LENGTH];
	int keyLength = getKeyLength(cypherText);
	cout << endl << "Found keyLength: " << keyLength << endl;

	getKey(cypherText, keyLength, key, plainText);
	cout << "Found key: " << key;

	getDecryptedText(cypherText, key, decryptedText);
	ofstream fout("plaintext.txt");
	fout << decryptedText;
	fout.close();
}

void readInput(char plainText[PT_LENGTH], char key[KEY_LENGTH])
{
	ifstream fin ("plaintext.txt");
	fin.getline(plainText, PT_LENGTH);
	cout<<"Key: ";
	cin.getline(key, KEY_LENGTH);
	fin.close();
}

int main() {
    char key[KEY_LENGTH], plainText[PT_LENGTH], cypherText[PT_LENGTH];
    int option;
    cout << "1. Encrypt a text\n2. Decrypt a text\n";
    cin >> option;
    cin.get();
    if(option == 1) {
        readPlaintext(plainText);
        readKey(key);
        setCharNumberEquivalency();
        turnToUpperCase(plainText);
        turnToUpperCase(key);
        encryptVigenere(key, plainText, cypherText);
        writeCypherText(cypherText);
    }
    else {
        readCyphertext(cypherText);
        setCharNumberEquivalency();
        turnToUpperCase(cypherText);
        decryptVigenere(cypherText, plainText);
    }
    return 0;
}
