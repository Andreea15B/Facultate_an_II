import java.sql.*;

public class MovieController {
    public void create(Integer id, String movieName, Integer directorId) {
        Connection tempConnection = Database.getConnection();
        if (null != tempConnection) {
            try {
                PreparedStatement preparedStatement = tempConnection.prepareStatement("INSERT INTO MOVIES (id, name, id_director) VALUES (?, ?, ?)");
                preparedStatement.setInt(1, id);
                preparedStatement.setString(2, movieName);
                preparedStatement.setInt(3, directorId);
                preparedStatement.executeUpdate();
                System.out.println("DML done!");
            }
            catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
