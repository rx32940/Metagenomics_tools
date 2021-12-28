#!/bin/bash
#SBATCH --partition=batch
#SBATCH --job-name=lca_diamond
#SBATCH --ntasks=1                      
#SBATCH --cpus-per-task=12         
#SBATCH --time=128:00:00
#SBATCH --mem=10G
#SBATCH --output=%x.%j.out       
#SBATCH --error=%x.%j.out        
#SBATCH --mail-user=rx32940@uga.edu
#SBATCH --mail-type=ALL


source activate megan
###################################################################
#  make diamond index against nr 
##############################################################

# DBNAME="/scratch/rx32940/metagenomics/megan/db"

# cd $DBNAME
# time wget https://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nr.gz

# time diamond makedb --in $DBNAME/nr.gz --db $DBNAME/nr -p 12

##############################################################
# diamond blastx
##############################################################

# BLASTN="/scratch/rx32940/metagenomics/blastn"
# DBNAME="/scratch/rx32940/metagenomics/megan/db"
# INPUT="$BLASTN/merged_fastq"
# OUT="/scratch/rx32940/metagenomics/megan/output"

# for file in  $INPUT/*_merged.fastq;
# do

# (
# sample=$(basename $file '_merged.fastq')
# echo "#!/bin/bash
# #SBATCH --partition=highmem_p
# #SBATCH --job-name=diamond_$sample
# #SBATCH --ntasks=1                      
# #SBATCH --cpus-per-task=12          
# #SBATCH --time=128:00:00
# #SBATCH --mem=300G
# #SBATCH --output=%x.%j.out       
# #SBATCH --error=%x.%j.out        
# #SBATCH --mail-user=rx32940@uga.edu
# #SBATCH --mail-type=ALL" > sub.sh

# # -f 0 means BLAST alignment format
# echo "time diamond blastx -d $DBNAME/nr -q $INPUT/${sample}_merged.fastq -o $OUT/${sample} -f 100 -p 12" >> sub.sh
# echo "diamond view -a $OUT/${sample}.daa > $OUT/${sample}.txt" >> sub.sh
# sbatch sub.sh
# ) &

# wait
# done

############################################################
#
# meganizer diamond classification
# 1) this will add taxonomical and functional annotation to the .daa files
# 2) after meganizer, download .daa files, and import into MEGAN 
# 3) select all nodes, and export as STAMP file (.spf)
# 
##################################################
OUT="/scratch/rx32940/metagenomics/megan"
DBNAME="/scratch/rx32940/metagenomics/megan/db"

for file in $OUT/output/R*.[K,L,S].daa;
do
sample=$(basename $file '.txt.daa')


### db downloaded from: https://software-ab.informatik.uni-tuebingen.de/download/megan6/megan-map-Jan2021.db.zip
### this will append taxonomy info to the original daa file
# daa-meganizer -i $file -mdb $DBNAME/megan-map-Jan2021.db -t 12


done


conda deactivate