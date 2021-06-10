# Download and creates ChEMBL database using fancy piping technique where the dump file never touches
# the hard drive.
# chembl_to_postgres <version> <database_name>
# Example usage: chembl_to_postgres 27 chembl
function chembl_to_postgres {
    curl ftp://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/latest/chembl_${1}_postgresql.tar.gz | \
    tar xOz chembl_${1}/chembl_${1}_postgresql/chembl_${1}_postgresql.dmp | \
    pg_restore --no-owner -d ${2}
}

# Run a keter job on SLURM
function keter_srun {
    _IDENT=${1}_keter
    srun --job-name=${_IDENT} --output=${_IDENT}.out.log --error=${IDENT}.err.log --partition=batch --qos=medium --time=16:00:00 --nodes=1 --cpus-per-task=16 "python -c \"from keter.productions import *; ${1}()\""
}

