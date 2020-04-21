public class Main {
    public static void main(String[] args) {
        PersonController persons = new PersonController();
        MovieController movies = new MovieController();

        persons.create(1, "Francis Ford Coppola");
        persons.create(2, "Marlon Brando");
        persons.create(3, "Al Pacino");
        Database.commit();

        persons.create(4, "Guillermo del Toro");
        Database.rollback();

        movies.create(1, "The Godfather", persons.findByName("%Coppola"));
        movies.create(2, "The Godfather 2", persons.findByName("%Brando"));
        Database.commit();

        movies.create(3, "The Godfather 3", persons.findByName("%Pacino"));
        Database.rollback();

        Database.closeConnection();
    }
}
