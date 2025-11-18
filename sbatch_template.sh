#!/bin/bash
#SBATCH --mail-user=aidan.mulrooneygelinas@mail.concordia.ca
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --time=24:0:0
#SBATCH --account=def-hoing
#SBATCH --job-name=DetTubeEth
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=64
#SBATCH --mem-per-cpu=1000M
#SBATCH --output=%x-%j.out

#Before execution check outfold, ntasks,ncores, contd
#module load nixpkgs/16.09
module load StdEnv/2018.3
module load python/2.7.14
#module load openmpi/3.1.2
export ncores=64
sourcedir=$HOME/links
amrocfold=amroc
settingsfold=Testrun
outfold=DetonationTubeEthylene
appfold=euler_chem
simfold=2d/DetonationTube/Ethylene_reduce/MovingDet
contd=0
files_to_copy=("display*.in"  \
				"chem.dat" "init.dat" \
				"run.py" "solver.in")
dirs_to_copy=("../src" "../../src")
# if contd, set also solver to 1

cd $sourcedir/projects/def-hoing/aidanmg/$amrocfold/vtf
source ac/paths.sh gnu-opt-mpi

# Create the output directory in scratch
if [[ $contd -eq 0 ]]; then
	mkdir $sourcedir/scratch/$outfold
fi
cd  $sourcedir/scratch/$outfold

# Copy the files over
if [[ $contd -eq 0 ]]; then
	for filename in "${files_to_copy[@]}"; do
		cp $sourcedir/projects/def-hoing/aidanmg/$amrocfold/vtf/amroc/clawpack/applications/$appfold/$simfold/$filename ./
	done
	for dirname in "${dirs_to_copy[@]}"; do
		cp -r $sourcedir/projects/def-hoing/aidanmg/$amrocfold/vtf/amroc/clawpack/applications/$appfold/$simfold/$dirname ./
	done
fi

$sourcedir/projects/def-hoing/aidanmg/$amrocfold/vtf/amroc/clawpack/applications/$appfold/$simfold/run.py $ncores

