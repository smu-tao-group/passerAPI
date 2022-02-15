#!/bin/bash

# catch inputs
pdb=$1
chain=$2
model=$3

# exit if pdb id is empty
[[ -z "$1" ]] && { echo "PDB ID is empty" ; exit 1; }

# curl passer server
results=$(curl -X POST -d pdb=$pdb -d chain=$chain -d model=$model https://passer.smu.edu/api)

# process returns
pocket1=$(python3 -c "import sys, json; sys.stdout.write(json.loads(sys.argv[1])['1']['residues'])" "$results")
pocket2=$(python3 -c "import sys, json; sys.stdout.write(json.loads(sys.argv[1])['2']['residues'])" "$results")
pocket3=$(python3 -c "import sys, json; sys.stdout.write(json.loads(sys.argv[1])['3']['residues'])" "$results")

pocket1Len=($(wc -w <<< "$pocket1"))
pocket2Len=($(wc -w <<< "$pocket2"))
pocket3Len=($(wc -w <<< "$pocket3"))

# download pdb
curl https://files.rcsb.org/download/$pdb.pdb >> $pdb.pdb

# visualize
vmd $pdb.pdb -e visual.tcl -args $pdb $pocket1Len $pocket2Len $pocket3Len $pocket1 $pocket2 $pocket3

# convert to png
convert -density 300 -quality 100 $pdb.tga $pdb.png
