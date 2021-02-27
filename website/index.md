@def title = "Quantum problems and solutions"
@def tags = ["pluto","sympy"]

# Quantum Computing Problems & Solutions
These are my solutions to problems in the book *Problems and solutions in quantum computing and quantum information*[^1] using [Julia](https://julialang.org) with [SymPy.jl](https://github.com/JuliaPy/SymPy.jl) within [Pluto.jl](https://github.com/fonsp/Pluto.jl) notebooks.



Once the [repo](https://github.com/stefanbringuier/QuantumComputingProblemsSolutions) is locally cloned, the environment and pluto server can be instatiated from the `Package.toml` and dependencies from `Manifest.toml`, using the command line:

```bash
julia --project=@. -e "using Pluto; Pluto.run()"
```


## Chapters 
   - [Ch. 1](/ch1/) Qubits
   - [Ch. 2](/ch2/) Product spaces
   - [Ch. 3](/ch3/) Matrices


[^1]: Steeb, W. H., & Hardy, Y., Problems and solutions in quantum computing and quantum information (4th Edition). In Problems And Solutions In Quantum Computing And Quantum Information, World Scientific, 4th ed., 2018. [10.1142/10943](https://doi.org/10.1142/10943)
