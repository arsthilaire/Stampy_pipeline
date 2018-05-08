ind='LP6005057-DNA_H02'

Sbatch --export=ind=${ind} --job-name=dedup_${ind} \
	--output=/home/arsth/scratch/PGX_DENOVO/STAMPY_PIPELINE/log/%j.${ind}.GRCh38.dedup.out \
	--error=/home/arsth/scratch/PGX_DENOVO/STAMPY_PIPELINE/log/%j.${ind}.GRCh38.dedup.err \
	GRCh38.dedup.sh
