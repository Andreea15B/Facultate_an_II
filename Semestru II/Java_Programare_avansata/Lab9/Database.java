import java.sql.*;

public class Database {
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String USER = "java";
    private static final String PASSWORD = "sql";
    private static Connection connection = null;

    private Database() {
        System.out.println("Constructor called!");
    }

    public static Connection getConnection() {
        if (null == connection) {
            createConnection();
        }
        return connection;
    }

    private static void createConnection() {
        if (null == connection) {
            try {
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                connection.setAutoCommit(false);
                System.out.println("Connected!");
            }
            catch (SQLException e) {
                connection = null;
                e.printStackTrace();
            }
        }
    }

    public static void closeConnection() {
        if (null != connection) {
            try {
                connection.close();
                connection = null;
                System.out.println("Disconnected!");
            }
            catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void commit() {
        if (null != connection) {
            try {
                connection.commit();
                System.out.println("Commit done!");
            }
            catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void rollback() {
        if (null != connection) {
            try {
                connection.rollback();
                System.out.println("Rollback done!");
            }
            catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}