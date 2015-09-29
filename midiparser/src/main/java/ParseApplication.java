import java.io.File;

/**
 * Created by jasper on 25/09/15.
 */
public class ParseApplication {

    public static void main(String[] args) throws Exception {
        Parser parser = new Parser();
        parser.parse(new File(args[0]));
    }

}
