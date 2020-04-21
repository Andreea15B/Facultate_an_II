public class Lab1_optional {
    public static void DFS(int nod, int n, int m[][], int viz[]) {
        viz[nod] = 1;
        for(int i=0; i<n; i++)
            if(m[nod][i]==1 && viz[i]==0) DFS(i, n, m, viz);
    }

    public static void generateRandomTree(int n, int m[][]) {
        // incep cu un graf complet si elimin muchii pana cand am n-1 muchii
        generateCompleteGraph(n, m);
        int muchii = numberEdges(n, m);
        int[] grade = new int[n];
        while(muchii != n-1) {
            nrGrade(n, m, grade);
            int r_i = (int) (Math.random() * n);
            int r_j = (int) (Math.random() * n);
            if (m[r_i][r_j] == 1 && grade[r_i] > 1 && grade[r_j] > 1) {
                m[r_i][r_j] = 0;
                m[r_j][r_i] = 0;
                muchii--;
            }
        }
        System.out.println("Arbore random:");
        printMatrix(n, m);
    }

    public static void generateCompleteGraph(int n, int m[][]) {
        int i, j;
        for(i=0; i<n; i++) {
            for(j=0; j<n; j++) {
                if(i == j) m[i][j] = 0;
                else m[i][j] = 1;
            }
        }
    }

    public static void generateCyclicGraph(int n, int m[][]) {
        int i, j;
        for(i=0; i<n; i++)
            for(j=0; j<n; j++) m[i][j] = 0;
        for(i=0; i<n; i++) {
            if(i == n-1) m[i][0] = m[0][i] = 1;
            else {
                m[i][i+1] = 1;
                m[i+1][i] = 1;
            }
        }
        System.out.println("Graf ciclic:");
        printMatrix(n, m);
    }

    public static void generateRandomGraph(int n, int m[][]) {
        int i, j;
        for(i=0; i<n; i++) {
            for(j=i; j<n; j++) {
                if(i == j) m[i][j] = 0;
                else {
                    int p = (int)(Math.random()*100);
                    if(p < 30) m[i][j] = 0;
                    else m[i][j] = m[j][i] = (int)(Math.random() * 2);
                }
            }
        }
    }

    public static int numberEdges(int n, int m[][]) {
        int i, j;
        //int m = n*(n-1); //pentru graf complet
        int muchii = 0;
        for(i=0; i<n; i++) {
            for(j=0; j<n; j++)
                if(m[i][j] == 1) muchii++;
        }
        return muchii/2;
    }

    public static int nrComponenteConexe(int n, int m[][]) {
        int i, j, nrComponente=1;
        int[]viz = new int[n];
        DFS(0, n, m, viz);
        for(i=0; i<n; i++)
            if(viz[i]==0) {
                nrComponente++;
                DFS(i, n, m, viz);
            }
        return nrComponente;
    }

    public static void printMatrix(int n, int m[][]) {
        for(int i=0; i<n; i++) {
            for(int j=0; j<n; j++)
                System.out.print(m[i][j] + " ");
            System.out.println();
        }
    }

    public static void nrGrade(int n, int m[][], int grade[]) {
        int i, j;
        for(i=0; i<n; i++) grade[i]=0;
        for(i=0; i<n; i++)
            for(j=0; j<n; j++)
                if(m[i][j] == 1) grade[i]++;
    }

    public static void main(String args[]) {
        long startTime = System.nanoTime();
        if(args.length > 1) {
            System.out.println("Too many arguments!");
            System.exit(-1);
        }
        int n = Integer.parseInt(args[0]);
        if(n%2 == 0) {
            System.out.println("Number is not odd!");
            System.exit(-1);
        }
        int i, j;
        int[][] matrice = new int[n][n];
        generateRandomGraph(n, matrice);

        printMatrix(n, matrice);

        int muchii = numberEdges(n, matrice);
        System.out.println("Nr muchii: " + muchii);

        int[] grade = new int[n];
        nrGrade(n, matrice, grade);

        int minim=10000, maxim=0, sum=0;
        for(i=0; i<n; i++) {
            if(grade[i] < minim) minim = grade[i];
            if(grade[i] > maxim) maxim = grade[i];
            sum += grade[i];
        }
        System.out.println("Maxim = \u0394(G) = " + maxim);
        System.out.println("Minim = \u03B4(G) = " + minim);
        if(maxim == minim) System.out.println("Graful este regulat!");
        else System.out.println("Graful nu este regulat!");
        if(sum == 2*muchii) System.out.println("Suma gradelor = 2*m");
        else System.out.println("Suma gradelor nu este 2*m");

        int nrComponente = nrComponenteConexe(n, matrice);
        if(nrComponente == 1) System.out.println("Graf conex");
        else {
            System.out.println("Graf neconex");
            System.out.println("Numar componente conexe = " + nrComponente);
        }

        int[][] arbore = new int[n][n];
        generateRandomTree(n, arbore);

        int[][] matr = new int[n][n];
        generateCyclicGraph(n, matr);

        long endTime   = System.nanoTime();
        long totalTime = endTime - startTime;
        System.out.println("Running time: " + totalTime + " nanoseconds");
    }
}
