# Total Vote Automation

## Description

This project is a Maven-based test automation framework that utilizes Cucumber for behavior-driven development (BDD). It provides a structured approach to writing automated tests in a human-readable format.

## Prerequisites

Before setting up and running this project, make sure you have the following software installed on your machine:

- Java Development Kit (JDK) 1.8 or higher
- Apache Maven

## Installation

### Java

#### Windows

1. Download the latest version of JDK from the Oracle website: [https://www.oracle.com/java/technologies/javase-jdk8-downloads.html](https://www.oracle.com/java/technologies/javase-jdk8-downloads.html)
2. Run the installer and follow the on-screen instructions.
3. Set up the JAVA_HOME environment variable:
    - Right-click on **My Computer** or **This PC** and select **Properties**.
    - Go to **Advanced system settings**.
    - Click on **Environment Variables**.
    - Under **System Variables**, click **New**.
    - Enter `JAVA_HOME` as the variable name.
    - Enter the JDK installation directory path as the variable value (e.g., `C:\Program Files\Java\jdk1.8.0_221`).
    - Click **OK** on all windows.

#### macOS

1. Download the latest version of JDK from the Oracle website: [https://www.oracle.com/java/technologies/javase-jdk8-downloads.html](https://www.oracle.com/java/technologies/javase-jdk8-downloads.html)
2. Run the installer and follow the on-screen instructions.
3. Set up the JAVA_HOME environment variable:
    - Open Terminal.
    - Run the command `nano ~/.bash_profile` to open the file in a text editor.
    - Add the following line at the end of the file:
      ```
      export JAVA_HOME=$(/usr/libexec/java_home)
      ```
    - Save the file by pressing **Ctrl + X**, then **Y**, and finally **Enter**.
    - Run the command `source ~/.bash_profile` to apply the changes.

### Maven

#### Windows

1. Download the latest version of Maven from the Apache Maven website: [https://maven.apache.org/download.cgi](https://maven.apache.org/download.cgi)
2. Extract the downloaded archive to a directory of your choice (e.g., `C:\apache-maven-3.8.1`).
3. Set up the MAVEN_HOME environment variable:
    - Right-click on **My Computer** or **This PC** and select **Properties**.
    - Go to **Advanced system settings**.
    - Click on **Environment Variables**.
    - Under **System Variables**, click **New**.
    - Enter `MAVEN_HOME` as the variable name.
    - Enter the Maven installation directory path as the variable value (e.g., `C:\apache-maven-3.8.1`).
    - Click **OK** on all windows.
4. Add Maven to the system's PATH variable:
    - Append `%MAVEN_HOME%\bin` to the **Path** variable under **System Variables**.
    - Click **OK** on all windows.

#### macOS

1. Install Maven using Homebrew:
    - Open Terminal.
    - Run the command `brew install maven`.
    - Wait for the installation to complete.

## Project Setup

1. Clone or download the project from the repository.
2. Open IntelliJ IDEA.
3. Click **Open** and select the project's root directory.
4. IntelliJ will automatically detect the Maven project and import the necessary dependencies.
5. Wait for the indexing and synchronization processes to
