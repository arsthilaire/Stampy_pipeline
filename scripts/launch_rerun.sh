ind='LP6005058-DNA_E02'

sbatch --export=ind=${ind} --job-name=${ind}_stampy \
	--output=/home/arsth/scratch/PGX_DENOVO/STAMPY_PIPELINE/log/${ind}.GRCh38.stampy.rerun.out \
	--error=/home/arsth/scratch/PGX_DENOVO/STAMPY_PIPELINE/log/${ind}.GRCh38.stampy.rerun.err \
	GRCh38.stampy.rerun.sh
