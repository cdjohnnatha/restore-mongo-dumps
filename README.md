# Restore Dumps

This project it was made in a necessity to restore multiple times several mongodb dumps.

## 1. <a name='GetStarted'></a>Get Started

First of all, create a directory and put all your zip dumps there, then put this script in this folder.

You have to give the right permissions to run this bash script. The examples bellow it was made for linux.

```
chmod +x restore_dumps.sh
```

After this, run:

```
    sh restore_dumps.sh
```
OR

```
    bash restore_dumps.sh
```

## 2. <a name='whatDoes'></a>What does it do ?

### 1. Unzip all tar.gz from:

It will ask if the user whants to unzip all tar.gz files in a directory.

### 2. Restore all dumps from:

It will ask if the user whants to restore all dumps using mongorestore at all directories.

### 3. Remove all unziped directories at:

It will ask if the user whants to delete all directories at this folder (only the unzip, IT KEEPS THE ZIP FILES).