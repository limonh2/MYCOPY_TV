package utils;

import java.text.SimpleDateFormat;

import java.util.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Map;
import java.util.Random;
import java.util.jar.Attributes;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Helper {
    public static Map<String, String> cookies;
    public static String xsrfToken;
    public static Map<String, Attributes> filterCriteriaMap;
    public static String PARENT_WINID;
    public static String TEMP_DATA;
    public static String NOTICE_ID;
    public static String TEMP_DATA1;
    public static String TEMPLATE_NAME;
    public static String OUT_OF_COUNTY_MATCHES_REPORT_COUNT;

    private static String voterName;

    public static String votersFullName;

    private static String lastName_FirstName;

    public static String getVoterName() {
        return voterName;
    }

    public static void setVoterName(String voterName) {
        Helper.voterName = voterName;
    }

    public static String reportName;

    public static String getReportName() {
        return reportName;
    }

    public static String getLastNameFirstName() {
        return lastName_FirstName;
    }
    public static void setLastNameFirstName(String lastNameFirstName) {
        lastName_FirstName=lastNameFirstName;
    }

    public static void setReportName(String reportName) {
        Helper.reportName = reportName;
    }



    private static List<Map<String, String>> registrantData;

    public static void setRegistrantData(List<Map<String, String>> newData) {
        registrantData = newData;
    }

    public static List<Map<String, String>> getRegistrantData() {
        return registrantData;
    }

    public static String getElectionDate() {
        return electionDate;
    }

    public static void setElectionDate(String electDate) {
        electionDate = electDate;
    }

    private static String electionDate;


    public static int ballotRow = 0;

    public void setBallotRowCount(int count) {
        ballotRow = count;
    }

    public int getBallotRowCount() {
        return ballotRow;
    }

    /**
     * gets cookie tree
     *
     * @return
     */
    public static Map<String, String> getCookiesTree() {
        return cookies;
    }

    /**
     * sets cookie tree
     *
     * @param cookies
     */
    public static void setCookiesTree(Map<String, String> cookies) {
        Helper.cookies = cookies;
    }

    /**
     * gets auth token
     *
     * @return
     */
    public static String getXsrfToken() {
        return xsrfToken;
    }

    /**
     * sets auth token cache
     *
     * @param token
     */
    public static void setXsrfToken(String token) {
        xsrfToken = token;
    }

    /**
     * sets cookies and auth token
     *
     * @param cookies
     */
    public static void setCookiesAndToken(Map<String, String> cookies) {
        setCookiesTree(cookies);
        setXsrfToken(cookies.get("XSRF-TOKEN"));
    }


    /**
     * sets data-set, filters and filter attributes cache
     *
     * @param dataSetInfoListMap
     */


    public static final String DATE_SUFFIX_FORMAT = "-yyyyMMdd-HHmmss";
    public static final SimpleDateFormat sdf = new SimpleDateFormat(DATE_SUFFIX_FORMAT);

    public static String getCurrentTime() {
        Date date = new Date();
        return sdf.format(date.getTime());
    }

    public static String getTime() {
        long random = new Date().getTime();
        return Long.toString(random);
    }

    /**
     * generates a unique number
     *
     * @return
     */
    public static String getUniqueNumber() {
        return "-AUTO-" + getTime();
    }

    public static String getRandomNumber() {
        double x = Math.random();
        return Double.toString(x).replace("0.", "");
    }

    public static int getRandomNumberInRange(int min, int max) {
        if (min >= max) {
            throw new IllegalArgumentException("max must be greater than min");
        }
        return min + (int) (Math.random() * max);
    }

    public static Map<String, Attributes> getFilterCriteriaMap() {
        return filterCriteriaMap;
    }

    public static String extractJobNumber(String input) {
        Pattern pattern = Pattern.compile("results/(\\d+)/");
        Matcher matcher = pattern.matcher(input);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return "";
    }

    public static String getRandomNumber(int size) {
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        // first not 0 digit
        sb.append(random.nextInt(9) + 1);
        // rest of 11 digits
        for (int i = 1; i < size; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }

    public static String getRandomString(int lenght) {
        String String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".toUpperCase();
        StringBuilder out = new StringBuilder();
        Random rnd = new Random();
        while (out.length() < lenght) { // length of the random string.
            int index = (int) (rnd.nextFloat() * String.length());
            out.append(String.charAt(index));
        }

        return out.toString();
    }


    public static String getDateAndTime() {
        LocalDateTime localDate = LocalDateTime.now();
        DateTimeFormatter dateformatter
                = DateTimeFormatter.ofPattern("MM/dd/YYYY hhmmss");
        return dateformatter.format(localDate);
    }
}