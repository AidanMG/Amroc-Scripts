#!/bin/bash
#SBATCH --mail-user=aidan.mulrooneygelinas@mail.concordia.ca
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --time=2:0:0
#SBATCH --account=def-hoing
#SBATCH --job-name=tar_job
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --mem-per-cpu=1000M
#SBATCH --output=%x-%j.out

#Before execution check outfold, ntasks,ncores, contd
#module load nixpkgs/16.09
#module load StdEnv/2018.3
#module load python/2.7.14
#module load openmpi/3.1.2

dirname=~/links/scratch/UnderExpandedJet_PR5_0
filename=~/links/scratch/UnderExpandedJet_PR5_0_walls.tar.gz
archive_path=~/links/projects/def-hoing/aidanmg/archive/2025-10-30

if [ ! -d "$archive_path" ]; then
    mkdir "$archive_path"
    echo "$archive_path created."
fi
tar -czf "$filename" "$dirname"

if [gzip -t >/dev/null/]; then
    echo "$filename checksum passed."
    cp "$filename" "$archive_path"
    echo "$filename copied to $archive_path"
    rm -r "$dir_name"
    echo "Cleaned up $dirname"
fi

exit 0

