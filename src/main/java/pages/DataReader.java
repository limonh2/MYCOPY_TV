package pages;


import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * @author anirban
 */
public class DataReader {

    public static Properties prop;

    public Properties getData() {
        try {
            prop = new Properties();
            FileInputStream data = new FileInputStream("testData.properties");
            prop.load(data);
        } catch (Exception e) {
            e.getMessage();
        }
        return prop;
    }

    public JsonNode readData(String user) throws IOException {
        // load the properties file
        Properties props = new Properties();

        try (InputStream input = new FileInputStream("testData.properties")) {
            props.load(input);
        }

        // get the JSON string from the property value
        String jsonString = props.getProperty(user);

        // convert the JSON string to a JSON object
        ObjectMapper mapper = new ObjectMapper();
        JsonNode data = mapper.readTree(jsonString);

        return data;
    }

    public String getUser(String user) {
        try {
            return readData(user).get("uid").asText();
        } catch (IOException e) {
           return e.getMessage();
        }
    }

    public String getPassword(String user) {
        try {
            return readData(user).get("pwd").asText();
        } catch (IOException e) {
            return e.getMessage();
        }
    }

    public String getName(String user) {
        try {
            return readData(user).get("name").asText();
        } catch (IOException e) {
           return e.getMessage();
        }
    }

    public String getZip(String user) throws IOException {
        try {
            return readData(user).get("zip").asText();
        } catch (IOException e) {
            return  e.getMessage();
        }
    }
    public String getCity(String user) throws IOException {
        try {
            return readData(user).get("city").asText();
        } catch (IOException e) {
            return e.getMessage();
        }
    }
}
