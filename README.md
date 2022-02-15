# PASSer: Protein Allosteric Sites Server API

[![Python 3.6+](https://img.shields.io/badge/python-3.6+-blue.svg)](https://www.python.org/downloads/release/python-360/) [![Paper DOI](https://zenodo.org/badge/DOI/10.1088/2632-2153/abe6d6.svg)](https://doi.org/10.1088/2632-2153/abe6d6)


This is the API for [PASSer](https://passer.smu.edu). 

If you find this helpful, please cite: Hao Tian *et al* 2021 *Mach. Learn.: Sci. Technol.* **2** 035015

Currently, the APIs only accept predictions on existing PDB IDs. The users should specify the PDB ID with optional chain ID and models. 

By default, all chains are analyzed; the ensemble learning model is used. The users can run predictions on the automated machine learning model (AutoGluon) by specifying model parameter as autoML (case sensitive).

Two common senarios are introduced here: (1) Python requests and (2) Terminal curl.

In Python, specify the PDB ID and chain ID in a dictionary and pass that to requests post function.

```python
import requests

url = 'https://passer.smu.edu/api'
data = {"pdb": "5DKK", "chain": "A"}

results = requests.post(url, data=data)
print(results.json())
```

In Terminal, pass arguments through -d option.

```bash
curl -X POST -d pdb=5dkk -d chain=A https://passer.smu.edu/api
curl -X POST -d pdb=5dkl -d chain=B -d model=autoML https://passer.smu.edu/api
```

The PASSer API returns top 3 pockets probabilities with residues in json format. The resiudes are formatted in VMD-ready command. An example return is show below.
```bash
{
    "1": {
        "prob": "89.65%",
        "residues": "chain A and resid 333 329 303 346 290"
    },
    "2": {
        "prob": "20.22%",
        "residues": "chain A and resid 270 321 352 269 250"
    },
    "3": {
        "prob": "16.83%",
        "residues": "chain A and resid 302 298 297 313 369"
    }
}
```

We also provide a bash file, together with VMD TCL file, to automate the process from prediction to visualization. To use, run the *run.sh* file with PDB ID, chain ID (optional) and model (optional). 

```bash
./run.sh 5dkk
```
