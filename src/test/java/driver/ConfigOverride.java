//package driver;
//
//import com.amazonaws.services.simplesystemsmanagement.AWSSimpleSystemsManagement;
//import com.amazonaws.services.simplesystemsmanagement.model.GetParameterRequest;
//import com.typesafe.config.Config;
//import com.typesafe.config.ConfigFactory;
//
//import java.util.Map;
//import java.util.Properties;
//
//public class ConfigOverride {
//    public static ConfigOverride ourInstance;
//
//    public Config config;
//    public AWSSimpleSystemsManagement awsClient;
//    public Properties properties;
//    public String environment;
//
//    public static ConfigOverride getInstance() {
//        if (ourInstance == null) {
//            if(!ConfigFactory.load().hasPath("EMAIL")) {
//                ourInstance = new ConfigOverride(ConfigFactory.load(),
//                        new AWSSimpleSystemsManagementClientProvider().getClient());
//            } else {
//                ourInstance = new ConfigOverride(ConfigFactory.load());
//            }
//        }
//
//        return ourInstance;
//    }
//
//    public ConfigOverride(Config config, AWSSimpleSystemsManagement awsClient) {
//        this.config = config;
//        environment = config.getString("environment");
//        this.awsClient = awsClient;
//        createSecretsOverride(config);
//    }
//
//    public ConfigOverride(Config config) {
//        this.config = config;
//        environment = config.getString("environment");
//        createSecretsOverride(config);
//    }
//
//    public void createSecretsOverride(Config config) {
//        properties = new Properties();
//        if (!config.hasPath("EMAIL")) {
//            for (Map.Entry key : config.getConfig("secrets").entrySet()) {
//                properties.put(key.getKey(),
//                        getParameterStoreValue(config.getConfig("secrets").getString(key.getKey().toString())));
//            }
//        }
//        for (Map.Entry key : config.entrySet()) {
//            properties.put(key.getKey(),config.getString(key.getKey().toString()));
//        }
//    }
//
//    public String getParameterStoreValue(String parameterStoreKey) {
//        GetParameterRequest request = new GetParameterRequest()
//                .withName(environment + "-" + parameterStoreKey)
//                .withWithDecryption(true);
//
//        return awsClient.getParameter(request).getParameter().getValue();
//    }
//
//
//    public Config getConfig() {
//        return config;
//    }
//
//    public Properties getProperties() {
//        return properties;
//    }
//}
