#!/bin/bash
#SBATCH --mail-user=aidan.mulrooneygelinas@mail.concordia.ca
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --time=24:0:0
#SBATCH --account=def-hoing
#SBATCH --job-name=300_PR5_0_UnderJet
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=192
#SBATCH --mem-per-cpu=1000M
#SBATCH --output=%x-%j.out

#Before execution check outfold, ntasks,ncores, contd
#module load nixpkgs/16.09
module load StdEnv/2018.3
module load python/2.7.14
#module load openmpi/3.1.2
export ncores=192
sourcedir=$HOME
amrocfold=amroc
settingsfold=Testrun
outfold=300_PR5_0_UnderJet
appfold=euler_chem
simfold=2d/Shocktube/Lietal_2003/300_PR5_0
contd=0
files_to_copy=("display*.in"  \
				"init.dat" \
				"run.py" "solver.in")
dirs_to_copy=("../src" "../../src")
# if contd, set also solver to 1

cd $VTF_DIR
source ac/paths.sh gnu-opt-mpi

# Create the output directory in scratch
if [[ $contd -eq 0 ]]; then
	mkdir $SCRATCH/$outfold
fi
cd  $SCRATCH/$outfold

# Copy the files over, unless continuing
if [[ $contd -eq 0 ]]; then
	for filename in "${files_to_copy[@]}"; do
		cp $VTF_DIR/amroc/clawpack/applications/$appfold/$simfold/$filename ./
	done
	for dirname in "${dirs_to_copy[@]}"; do
		cp -r $VTF_DIR/amroc/clawpack/applications/$appfold/$simfold/$dirname ./
	done
fi

$VTF_DIR/amroc/clawpack/applications/$appfold/$simfold/run.py $ncores

