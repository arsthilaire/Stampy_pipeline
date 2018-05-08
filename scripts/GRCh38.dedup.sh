#!/bin/bash
#SBATCH -D /home/arsth/scratch/PGX_DENOVO/STAMPY_PIPELINE/log
#SBATCH --mail-user alex.richard-st-hilaire@umontreal.ca
#SBATCH --mail-type ALL 
#SBATCH --job-name=dedup_${ind}
#SBATCH --output=%a.${ind}.GRCh38.dedup.out
#SBATCH --error=%a.${ind}.GRCh38.dedup.err
#SBATCH --export=ind=LP6005058-DNA_C02
#SBATCH --time=24:00:00
#SBATCH -c 2
#SBATCH -N 1
#SBATCH --mem=48G

module load bamtools
module load picard
path_project=/home/arsth/scratch

date 1>&2
#jh modif remove (GRCh38) from bamfile name
bam=${path_project}/PGX_DENOVO/STAMPY_PIPELINE/GRCh38/${ind}.stampy.sorted.bam
dedup=${path_project}/PGX_DENOVO/STAMPY_PIPELINE/GRCh38/${ind}.markdupes.bam 

if [ ! -f $bam ]; then
    echo "$bam doesn't exist. Exit." 1>&2
    exit 1
fi

#jh modif add condition of nonexisting dedup file
if [ ! -f $dedup ]; then
    echo MarkDuplicates 1>&2
    #full path to java 1.8
	java -jar $EBROOTPICARD/picard.jar MarkDuplicates MAX_FILE_HANDLES=1024 REMOVE_DUPLICATES=true VALIDATION_STRINGENCY=LENIENT I=${bam} O=${dedup} M= ${dedup/".bam"/".metrics"} TMP_DIR=${path_project}/PGX_DENOVO/STAMPY_PIPELINE/tmp
else
    echo "$dedup already exists. Skipping." 1>&2
fi

#jh modif add condition of nonexisting sorted file 
if [ ! -f ${dedup/".bam"/".sorted.bam"} ]; then
#using samtools 1.2 because 1.3 throws an error about the header length!!
#jh modif ${dedup/".bam"/".sorted"} instead of ${dedup/".bam"/".sorted.bam"}
    echo sort 1>&2
    #${path_project}/PGX_DENOVO/software/samtools sort ${dedup} -o ${dedup/".bam"/".sorted.bam"}
    bamtools sort -n 2000000 -mem 2048 -in ${dedup} -out ${dedup/".bam"/".sorted.bam"}
    echo index 1>&2
    ${path_project}/PGX_DENOVO/software/samtools index ${dedup/".bam"/".sorted.bam"}
else
    echo '${dedup/".bam"/".sorted.bam"} already exists. Exit.' 1>&2
    exit 1
fi
