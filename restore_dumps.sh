#!/bin/sh

explanation="ATENTION: This script must be located at same directory of all your mongodb dumps. Keep only them!"
unzipFilesQuestion="Unzip all tar.gz from $(pwd) (y/n)? "
restoreDumpsQuestion="Restore all dumps from $(pwd) (y/n)? "
removeAllFoldersExtractedQuestion="Delete all unziped directories at $(pwd) (y/n)? "

loading_bar() {
    BAR='##############################'
    FILL='------------------------------'
    barLen=30
    # update progress bar
    count=$1
    qtyFiles=$2
    titlePrint=$3

    percent=$((($count * 100 / $qtyFiles * 100) / 100))
    indicator=$(($percent * $barLen / 100))
    echo -ne "\r[${BAR:0:$indicator}${FILL:$indicator:$barLen}] $count/$qtyFiles ($percent%) - $titlePrint"
}

unzipDumps() {
    #Get all files tar.gz and extract at same directory.
    totalTarGz=$(find -name '*.tar.gz' | wc -l)
    processCount=0
    for f in *.tar.gz; do
        loading_bar $processCount $totalTarGz "Extracting dumps from all tar.gz from $(pwd)"
        processCount=$(($processCount + 1))
        directory=$(echo "$f" | sed 's/\.[^.]*\.[^.]*$//')
        mkdir $(echo "$directory");
        tar -xf "$f" -C "./$(echo $directory)/";
        sleep 5s
    done
}

restoreDumps() {
    #Access all directories and run mongorestore
    totalTarGz=$(find -name '*.tar.gz' | wc -l)
    totalFiles=$(ls | wc -l)
    directoriesCount=$(($totalFiles-$totalTarGz-1));
    processCount=0
    for d in ./*/ ; do
        loading_bar $processCount $directoriesCount 'Mongo Restoring'
        (cd "$d" && mongorestore ./dump);
        processCount=$(($processCount + 1))
        sleep 5s
    done
}

removeDirectories() {
    #Find all directories and delete them.
    loading_bar 0 100 'Removing directories'
    find -mindepth 1 -maxdepth 1 -type d -print0 | xargs -r0 rm -R
    loading_bar 100 100 'Finished'
}

echo -n $explanation -n

echo -n $unzipFilesQuestion
read unzipFilesAnswer


echo -n $restoreDumpsQuestion
read restoreDumpsAnswer

echo -n $removeAllFoldersExtractedQuestion
read removeAllFoldersExtractedAnswer

if [ "$unzipFilesAnswer" != "${unzipFilesAnswer#[Yy]}" ] ;then
    unzipDumps
fi

if [ "$restoreDumpsAnswer" != "${restoreDumpsAnswer#[Yy]}" ] ;then
    restoreDumps
fi

if [ "$removeAllFoldersExtractedAnswer" != "${removeAllFoldersExtractedAnswer#[Yy]}" ] ;then
    removeDirectories
fi
