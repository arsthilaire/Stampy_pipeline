#!/bin/bash
#SBATCH --time=160:00:00
#SBATCH -c 1
#SBATCH -N 1
#SBATCH --mem=21G
#SBATCH --export=ind=LP6005058-DNA_C02
#SBATCH --job-name=${ind}_stampy
#SBATCH --output=/home/arsth/scratch/PGX_DENOVO/STAMPY_PIPELINE/log/%a.${ind}.GRCh38.stampy.out
#SBATCH --error=/home/arsth/scratch/PGX_DENOVO/STAMPY_PIPELINE/log/%a.${ind}.GRCh38.stampy.err
#SBATCH -D /home/arsth/scratch/PGX_DENOVO/STAMPY_PIPELINE/
#SBATCH --array=1-100

module load samtools/1.5


    path_project=/home/arsth/scratch
    errorfile=${path_project}/PGX_DENOVO/STAMPY_PIPELINE/log/${SLURM_ARRAY_TASK_ID}.${ind}.GRCh38.stampy.err
    bamfile=${path_project}/PGX_DENOVO/STAMPY_PIPELINE/GRCh38/${ind}.${SLURM_ARRAY_TASK_ID}.GRCh38.stampy.bam
    path_rawdata=${path_project}/PGX_DENOVO/data/Quartet1207

	flag=0
    #check for missing error file
    if [ ! -f ${errorfile} ] ; then
        flag=1
    #check for "Done"
    else
        grep 'Done' ${errorfile}
        if [ $? = 1 ] ; then
            flag=1
        else
            #check in case it looks done but the filesize is too small
            filesize=$(wc -c < $bamfile)
            if [[ $filesize -le 100 ]] ; then
                flag=1
            fi
        fi
    fi

    if [ $flag = 1 ]
    then
        echo "Stampy job ${i} is incomplete, rerunning" 1>&2
        outsam=${path_project}/PGX_DENOVO/STAMPY_PIPELINE/GRCh38/${ind}.${SLURM_ARRAY_TASK_ID}.GRCh38.stampy.sam

        #remove previous failed SAM file (if present) or stampy will not run
        rm ${outsam}
        #remove failed error file to cause less confusion later on
        #rm ${errorfile}

        # Map reads with Stampy
        ${path_project}/PGX_DENOVO/software/stampy-1.0.32/stampy.py -g ${path_project}/PGX_DENOVO/refs/GRCh38 -h ${path_project}/PGX_DENOVO/refs/GRCh38 --processpart ${SLURM_ARRAY_TASK_ID}/100 -o ${outsam} -M ${path_rawdata}/${ind}.namesorted.bam

        # Convert SAM to BAM again
	samtools view -Sb ${outsam} > ${outsam/".sam"/".bam"}

        rm ${outsam}
    else
        echo "Stampy job ${SLURM_ARRAY_TASK_ID} is complete, will not rerun" 1>&2
fi
