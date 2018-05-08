path_project=/home/arsth/scratch
#for file in $(ls ${path_project}/PGX_DENOVO/STAMPY_PIPELINE/rawdata/ | grep namesorted); do	
     #ind= ${file%.namesorted.bam}
     
     ind=LP6005058-DNA_D01
     echo $ind

    for j in {1..100} ; do
            
        errorfile=${path_project}/PGX_DENOVO/STAMPY_PIPELINE/log/${j}.${ind}.GRCh38.stampy.err
            
        if [ ! -f ${errorfile} ] ; then
            echo "Missing error file: ${errorfile}"
        fi
        if grep -q 'Done' ${errorfile}; then
            continue
        else
            echo "Not done: ${errorfile}"
        fi
    done
#done
