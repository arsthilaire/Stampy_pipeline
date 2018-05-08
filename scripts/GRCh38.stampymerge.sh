#!/bin/bash
#SBATCH --time=160:00:00
#SBATCH -c 1
#SBATCH -N 1
#SBATCH --mem=21G
#SBATCH --job-name=stampymerge_${ind}
#SBATCH --output=${ind}.GRCh38.stampymerge.out
#SBATCH --error=${ind}.GRCh38.stampymerge.err
#SBATCH -D /home/arsth/scratch/PGX_DENOVO/STAMPY_PIPELINE/log
#SBATCH --mail-type ALL 
#SBATCH --mail-user alex.richard-st-hilaire@umontreal.ca 
#SBATCH --export=ind=${ind}

path_project=/home/arsth/scratch

rm ${path_project}/PGX_DENOVO/STAMPY_PIPELINE/GRCh38/${ind}.mergefiles.txt

for i in {1..100} ; do	    
    echo ${path_project}/PGX_DENOVO/STAMPY_PIPELINE/GRCh38/${ind}.${i}.GRCh38.stampy.bam >> ${path_project}/PGX_DENOVO/STAMPY_PIPELINE/GRCh38/${ind}.mergefiles.txt
done

outbam=${path_project}/PGX_DENOVO/STAMPY_PIPELINE/GRCh38/${ind}.stampy.bam

${path_project}/PGX_DENOVO/software/samtools merge -f -b ${path_project}/PGX_DENOVO/STAMPY_PIPELINE/GRCh38/${ind}.mergefiles.txt  ${outbam}
${path_project}/PGX_DENOVO/software/samtools sort ${outbam} -o ${outbam/".bam"/".sorted.bam"}
${path_project}/PGX_DENOVO/software/samtools index ${outbam/".bam"/".sorted.bam"}
echo "Job is complete, will not rerun" 1>&2
