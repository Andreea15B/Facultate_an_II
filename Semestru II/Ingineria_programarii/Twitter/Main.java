import twitter4j.Query;
import twitter4j.Status;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.conf.ConfigurationBuilder;

import java.util.ArrayList;
import java.util.List;
import java.util.Queue;

public class Main {
    public static void main(String args[]) {
        ConfigurationBuilder cf = new ConfigurationBuilder();
        cf.setDebugEnabled(true)
                .setOAuthConsumerKey("zFZHU8N7DYQr4LDGPc5Fds6WG")
                .setOAuthConsumerSecret("7yiWPQm7vFJSc8sgr3MkILwBisR7XOMzBH8mTAqafBQN5c7xNW")
                .setOAuthAccessToken("1108253337768611840-Ck4P6O6I9oaGuVr3kz5DWhxTQwdbpn")
                .setOAuthAccessTokenSecret("BEHIOI7CFlvG0prrsCNU3WkKOM5rPyTdKJeVJvTME62ci");
        TwitterFactory tf = new TwitterFactory(cf.build());
        twitter4j.Twitter twitter = tf.getInstance();

        // get username & status & time
        List<Status> status = new ArrayList<>();
        Query query = new Query("medical");
        query.setLang("en");
        query.setSince("2019-01-01");
        try {
            status = twitter.search(query).getTweets();
        }
        catch(twitter4j.TwitterException e) {
            System.out.println("Exceptie:" + e);
        }
        for(Status st:status)
        {
            System.out.println(st.getUser().getCreatedAt() +"------"+ st.getUser().getName()+"------"+st.getText());
        }
    }
}
