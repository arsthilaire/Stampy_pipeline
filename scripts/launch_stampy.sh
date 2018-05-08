path_project=/home/arsth/scratch

for ind in $(ls ${path_project}/PGX_DENOVO/data/Quartet1207 | grep namesorted| grep -v C02); do
     echo $ind
		 #ind='LP6005058-DNA_E02'
		 sbatch --export=ind=${ind} --job-name=${ind}_stampy \
		 --output=~/scratch/PGX_DENOVO/STAMPY_PIPELINE/log/%a.${ind}.GRCh38.stampy.out \
		 --error=~/scratch/PGX_DENOVO/STAMPY_PIPELINE/log/%a.${ind}.GRCh38.stampy.err \
		 GRCh38.stampy.sh
done
