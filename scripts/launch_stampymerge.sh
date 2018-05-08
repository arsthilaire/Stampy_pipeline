ind='LP6005058-DNA_D01'

sbatch --export=ind=${ind} --job-name=${ind}_stampymerge \
	--output=/home/arsth/scratch/PGX_DENOVO/STAMPY_PIPELINE/log/${ind}.GRCh38.stampy.out \
	--error=/home/arsth/scratch/PGX_DENOVO/STAMPY_PIPELINE/log/${ind}.GRCh38.stampy.err \
	GRCh38.stampymerge.sh
