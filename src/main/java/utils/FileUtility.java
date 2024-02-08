package utils;

import org.apache.commons.io.FileUtils;

import java.io.*;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.InvalidPathException;
import java.nio.file.Path;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class FileUtility {

    public static Logger LOGGER = Logger.getLogger(FileUtility.class.getName());

    public static File getFile(String fileName) throws IOException {
        if (FileUtility.class.getClassLoader().getResourceAsStream(fileName) != null) {
            InputStream resourceAsStream = FileUtility.class.getClassLoader().getResourceAsStream(fileName);
            File file = new File(fileName, "");
            assert resourceAsStream != null;
            FileUtils.copyInputStreamToFile(resourceAsStream, file);
            return file;
        } else {
            return new File(fileName);
        }
    }

    public static void createDirectoryIfNotExist(File directory) {
        if (!directory.exists()) {
            File dir = new File("./" + directory);
            dir.mkdirs();
        }
    }

    /**
     * Creates a file and its parents directories if they do not already exist.
     * Returns true if the file has been created, false if the file already exists.
     *
     * @param file {@link File} The file to create if it does not already exist
     * @return {@link boolean} True if the file was created, false if it already exists
     * @throws IOException If the file was not about be created.
     */
    public static boolean createFileIfNotExists(File file) throws IOException {
        if (!file.exists()) {
            createDirectoryIfNotExist(file.getParentFile());
            File newFile = new File("./" + file.getPath());
            return newFile.createNewFile();
        }
        return false;
    }

    public static void copyFileToDirectory(File file, File directory) throws IOException {
        createDirectoryIfNotExist(directory);
        FileUtils.copyFileToDirectory(file, directory, true);
    }

    public static void forceDelete(File file) throws IOException {
        file.delete();
    }

    public static boolean isDirectoryEmpty(File directory) {
        try {
            Path path = Path.of(String.valueOf(directory));
            if (Files.isDirectory(path)) {
                try (DirectoryStream<Path> directoryStream = Files.newDirectoryStream(path)) {
                    return !directoryStream.iterator().hasNext();
                } catch (IOException ioException) {
                    LOGGER.log(Level.SEVERE, "IoException encountered.", ioException);
                }
            }
        } catch (InvalidPathException invalidPathException) {
            LOGGER.log(Level.SEVERE,
                    String.format("Invalid path from driver download directory: %s", Driver.downloadDir),
                    invalidPathException);
        }
        return false;
    }

    /**
     * Overloaded method function to find the last downloaded file ending with the provided extension.
     *
     * @param downloadDirectory {@link String} - Extension to look for.
     */
    public static FileInputStream getLatestFileFromDirectory(String downloadDirectory) throws IOException, InvalidPathException {
        try {
            Path path = Path.of(downloadDirectory);
            if (Files.isDirectory(path)) {
                try (Stream<Path> stream = Files.list(path)) {
                    List<File> foundFiles = stream
                            .map(Path::toFile)
                            .collect(Collectors.toList());
                    if (foundFiles.size() > 1) {
                        foundFiles.sort(Comparator.comparingLong(File::lastModified).reversed());
                    }
                    if (!foundFiles.isEmpty()) {
                        return new FileInputStream(foundFiles.get(0));
                    }
                } catch (FileNotFoundException fileNotFoundException) {
                    LOGGER.log(Level.SEVERE, "File not found.", fileNotFoundException);
                }
            }
        } catch (InvalidPathException invalidPathException) {
            LOGGER.log(Level.SEVERE,
                    String.format("Invalid path from driver download directory: %s", Driver.downloadDir),
                    invalidPathException);
            throw invalidPathException;
        }
        throw new FileNotFoundException(String.format("No files found in directory: %s", downloadDirectory));
    }

    /**
     * Searches in the provided directory to find a file that exactly matches the fileName provided.
     *
     * @param directory {@link String} - The directory to search in
     * @param fileName {@link String} - The file name to find.
     * @return {@link File} - The found file object if successful
     * @throws IOException If the directory could not list the files.
     * @throws FileNotFoundException If the file cannot be found.
     * @throws InvalidPathException If the path provided is invalid.
     */
    public static File getFileWithName(String directory, String fileName) throws IOException, InvalidPathException {
        try {
            Path path = Path.of(directory);
            if (Files.isDirectory(path)) {
                Stream<Path> stream = Files.list(path);
                return stream.filter(filePath -> filePath.getFileName().toString().equals(fileName))
                        .findFirst()
                        .map(Path::toFile)
                        .orElseThrow(() -> new FileNotFoundException(String.format("%s not found in %s", fileName,
                                directory)));
            }
        } catch (InvalidPathException | FileNotFoundException exception) {
            LOGGER.log(Level.SEVERE,
                    String.format("Unable to find file from directory: %s", directory),
                    exception);
            throw exception;
        } catch (IOException ioException) {
            LOGGER.log(Level.SEVERE,
                    String.format("IOException encountered while listing the files in the directory: %s", directory),
                    ioException);
            throw ioException;
        }
        return null;
    }

    public static File getFileInDirectoryContainingName(String directory, String fileName) throws IOException,
            InvalidPathException {
        try {
            Path path = Path.of(directory);
            if (Files.isDirectory(path)) {
                Stream<Path> stream = Files.list(path);
                return stream.filter(filePath -> filePath.getFileName().toString().contains(fileName))
                        .findFirst()
                        .map(Path::toFile)
                        .orElseThrow(() -> new FileNotFoundException(String.format("No files containing %s were " +
                                "found in %s", fileName, directory)));
            }
        } catch (InvalidPathException | FileNotFoundException exception) {
            LOGGER.log(Level.SEVERE,
                    String.format("Unable to find file from directory: %s", directory),
                    exception);
            throw exception;
        } catch (IOException ioException) {
            LOGGER.log(Level.SEVERE,
                    String.format("IOException encountered while listing the files in the directory: %s", directory),
                    ioException);
            throw ioException;
        }
        return null;
    }

    public static File getLastModified(String directoryFilePath) {
        File directory = new File(directoryFilePath);
        File[] files = directory.listFiles(File::isFile);
        long lastModifiedTime = Long.MIN_VALUE;
        File chosenFile = null;

        if (files != null) {
            for (File file : files) {
                if (file.lastModified() > lastModifiedTime) {
                    chosenFile = file;
                    lastModifiedTime = file.lastModified();
                }
            }
        }

        return chosenFile;
    }

    public static boolean fileExistsInDirectory(String filename, String directory) {
        return new File(directory, filename).exists();
    }

    public static List<File> getFilesInDirectory(String directory) {
        File directoryFile = new File(directory.endsWith("/")? directory : directory.concat("/"));
        if (directoryFile.isDirectory()) {
            File[] files = directoryFile.listFiles();
            return files == null? Collections.emptyList() : new ArrayList<>(Arrays.asList(files));
        }
        LOGGER.warning(String.format("%s is not a directory", directory));
        return Collections.emptyList();
    }

    public static void appendToFile(String filename, String line) throws IOException {
        FileWriter fileWriter = new FileWriter(filename, true);
        PrintWriter printWriter = new PrintWriter(fileWriter);
        printWriter.println(line);
        printWriter.close();
    }
}