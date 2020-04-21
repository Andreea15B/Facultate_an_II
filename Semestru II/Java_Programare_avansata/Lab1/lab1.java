public class lab1{
    public static void main(String args[]) {
        System.out.println("Hello World!");
        String languages[] = {"C", "C++", "C#", "Go", "JavaScript", "Perl", "PHP", "Python", "Swift", "Java"};
        int n = (int)(Math.random() * 1_000_000);
        n = n*3;
        String nr1 = "10101";
        int decimalValue = Integer.parseInt(nr1,2);
        String nr2 = "FF";
        int hexval = Integer.parseInt(nr2,16);
        n = n + decimalValue + hexval;
        n = n*6;
        System.out.println(n);
        int suma;
        int result;
        do{
            suma = 0;
            while(n > 0){
                suma = suma + n%10;
                n = n/10;
            }
            n = suma;
            result = n;
        }while(suma > 9);
        System.out.println("Willy-nilly, this semester I will learn " + languages[result]);
    }
}