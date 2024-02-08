//package driver;
//
//
//
//import com.fasterxml.jackson.databind.cfg.ConfigOverride;
//
//import java.util.Properties;
//
//public class DataReader.prop {
//
//    static ConfigOverride conf;
//    final static Properties properties;
//
//    public static String getProperty(String property) {
//        if (System.getProperty(property) != null) {
//            return System.getProperty(property);
//        } else if (properties.getProperty(property) != null) {
//            return properties.getProperty(property);
//        } else {
//            System.out.println("Configuration key: " + property + " not found in config and jvm parameter inputs");
//            return "";
////            throw new Exception("Configuration key not found in config and jvm parameter inputs");
//        }
//    }
//}
