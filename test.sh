#! /opt/bin/bash
    filecount=0
    nzbcount=0
    sfvcount=0
    nfocount=0
    subcount=0
    idxcount=0
    srrcount=0
    jpgcount=0
    par2count=0
    mkvcount=0
    echo "This script is cleaning the folder."
    echo ""
    echo "Cleaning up download directory:" $1
    echo ""
    echo "Deleting .nzb-files"
	
	# remove the following file extensions (nzb,sfv,nfo,sub,srt,idx,srr,jpg,par2)
    nzbcount=`/opt/bin/find "$1" -name "*.nzb" -type f -print -exec rm {} \; | wc -l`
    echo "Deleting .sfv-files"
    sfvcount=`/opt/bin/find "$1" -name "*.sfv" -type f -print -exec rm {} \; | wc -l`
    echo "Deleting .nfo-files"
    nfocount=`/opt/bin/find "$1" -name "*.nfo" -type f -print -exec rm {} \; | wc -l`
    echo "Deleting subtitle-files"
    subcount=`/opt/bin/find "$1" -name "*.sub" -type f -print -exec rm {} \; | wc -l`
    subcount=$[$subcount+`/opt/bin/find "$1" -name "*.srt" -type f -print -exec rm {} \; | wc -l`]
    echo "Deleting .idx-files"
    idxcount=`/opt/bin/find "$1" -name "*.idx" -type f -print -exec rm {} \; | wc -l`
    echo "Deleting .srr-files"
    srrcount=`/opt/bin/find "$1" -name "*.srr" -type f -print -exec rm {} \; | wc -l`
    echo "Deleting .jpg-files"
    jpgcount=`/opt/bin/find "$1" -name "*.jpg" -type f -print -exec rm {} \; | wc -l`
    echo "Deleting .par2-files"
    par2count=`/opt/bin/find "$1" -name "*.par2" -type f -print -exec rm {} \; | wc -l`
    
	# remove the smallest mkv files 
	echo "Deleting .mkv-files"
    mkvcount=`/opt/bin/find "$1" -name "*.mkv" -type f -print | wc -l`

    if [ "$mkvcount" -ge "2" ]; then
              	#/opt/bin/find  -name "*.mkv" -type f -print0 | xargs -0 du -s | sort -rn | awk 'NR>1 {print "$NF"}'| xargs rm -f
		/opt/bin/find "$1" -name "*.mkv" -type f -print0 | xargs -0 ls -S1 | sort -nr | awk 'NR>1' | tr '\n' '\0' | xargs -0 rm -f
		echo "De kleinere mkv files zijn verwijderd"
		let "mkvcount -= 1" 
            else
               echo "Er waren geen extra MKV files aanwezig."
		let "mkvcount -= 1"
            fi

    echo ""
    echo "Cleanup completed."
    echo "Deleted $filecount files ($mkvcount .mkv, $par2count .par2, $jpgcount .jpg, $nzbcount .nzb, $sfvcount .sfv, $nfocount .nfo, $subcount subtitle-files, $idxcount .idx, $srrcount .srr)."

