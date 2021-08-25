
## Quantum Computing Problems & Solutions
[![DOI](https://zenodo.org/badge/342710871.svg)](https://zenodo.org/badge/latestdoi/342710871)


My alternative solutions to problems in the book *Problems and solutions in quantum computing and quantum information*<sup>[1](#ref1)</sup>
 using Julia with [SymPy.jl](https://github.com/JuliaPy/SymPy.jl) within [Pluto.jl](https://github.com/fonsp/Pluto.jl) notebooks.

I put together a static website of the notebooks using [Franklin.jl](franklinjl.org) and deployed with github pages. Its still in an early state:

🎈[Static Pluto Notebook Website](https://stefanbringuier.github.io/QuantumComputingProblemsSolutions/index.html)🎈


Environment and pluto server can be instatiated from the Package.toml and dependencies from Manifest.toml, using the command line:

```bash
julia --project=@. -e "using Pluto; Pluto.run()"
```

A `test/runtests.jl` file exist which just runs each notebook file is include but may or may not be useful.

<a name="ref1"><sup>1</sup></a> Steeb, W. H., & Hardy, Y., Problems and solutions in quantum computing and quantum information (4th Edition). In Problems And Solutions In Quantum Computing And Quantum Information, World Scientific, 4th ed., 2018. [10.1142/10943](https://doi.org/10.1142/10943)
