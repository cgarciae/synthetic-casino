# Synthetic Casino

### Setup
1. Create environment: `conda env create`
2. Activate environment: `conda activate synthetic-casino`
3. Run script: `bash synthetic-casino.sh`

### Output
Each dataset is output to the `synthetic-casino` folder.

### Params
Inside `synthetic-casino.sh` you can tune job parameters, especially checkout:
* `WORKERS`: number of processes to use (use set to the number of cores in you machine).
* `N_SAMPLES`: number of synthetic images to generate.