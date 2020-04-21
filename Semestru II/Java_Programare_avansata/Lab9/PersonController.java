import java.sql.*;

public class PersonController {
    public void create(Integer id, String name) {
        Connection tempConnection = Database.getConnection();
        if (null != tempConnection) {
            try {
                PreparedStatement preparedStatement = tempConnection.prepareStatement("INSERT INTO persons (ID, NAME) VALUES (?, ?)");
                preparedStatement.setInt(1, id);
                preparedStatement.setString(2, name);
                preparedStatement.executeUpdate();
                System.out.println("DML done!");
            }
            catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public Integer findByName(String name) {
        Integer retVal = -1;

        Connection connection = Database.getConnection();
        if (null != connection) {
            Statement statement = null;
            try {
                statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery("SELECT id FROM persons WHERE name LIKE '" + name + "'");

                while (resultSet.next()) {
                    retVal = resultSet.getInt(1);
                }
            }
            catch (SQLException e) {
                e.printStackTrace();
            }
            finally {
                if (null != statement) {
                    try {
                        statement.close();
                        System.out.println("Query done!");
                    }
                    catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return retVal;
    }
}