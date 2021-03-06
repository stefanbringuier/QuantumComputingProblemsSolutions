@def title = "Quantum problems and solutions"
@def tags = ["pluto","sympy"]

# Quantum Computing Problems & Solutions
\toc

These are my solutions to problems in the book *Problems and solutions in quantum computing and quantum information*[^1] using [Julia](https://julialang.org) with [SymPy.jl](https://github.com/JuliaPy/SymPy.jl) within [Pluto.jl](https://github.com/fonsp/Pluto.jl) notebooks.

The aim of this effort is to assist in improving  ones mathematical rigor and know-how related to quantum computing using symbolic algebra and numerical computation. 

It helps if you have access to the text by *Nielsen & Chuang*[^2] while working through these problems.

## About this site

This site is intended to provide a static render of the various notebooks along with some minor background material. The end goal is to somehow turn the static renders into dynamic notebooks using something like binder.

 \note{The html bind objects in the Pluto.jl notebooks don't work with the static html output. However as of Pluto v0.14.8 the html exports now include [mybinder](https://mybinder.org) button to run. This will work but requires setting up the proper `Pkg` environment for `SymPy.jl` after it loads and fails. An example of this would be to add the following to the `Pluto.jl` notebook running on [mybinder](https://mybinder.org):
 ```julia
 begin
	using Pkg
	Pkg.activate(mktempdir())
	ENV["PYTHON"] = ""
	Pkg.add(["Conda", "PyCall"])
    Pkg.build()
    using Conda
    Conda.add("sympy")
	Pkg.add("SymPy")
end
```
}

 ### Chapters

 The site is broken down by chapter and within each chapter there are programming problems (i.e. solved using \linksympy) and those that are just solved by "hand".

- [Ch. 1](/ch1/) Qubits
- [Ch. 2](/ch2/) Product spaces
- [Ch. 3](/ch3/) Matrices
- [Ch. 4](/ch4/) Density Operators
- [Ch. 5](/ch5/) Traces
- [Ch. 7](/ch7/) Unitary Operators
- [Ch. 8](/ch8/) Entropy
- [Ch. 9](/ch9/) Measurement
- [Ch. 10](/ch10/) Entanglement
- [Ch. 11](/ch11/) Bell's Inequality
- [Ch. 12](/ch12/) Quantum Information
- [Ch. 13](/ch13/) Cloning


## Using the notebooks files 

Once the [repo](https://github.com/stefanbringuier/QuantumComputingProblemsSolutions) is locally cloned, the environment and pluto server can be instatiated from the `Package.toml` and dependencies from `Manifest.toml` from within the folder using the command line:

```bash
julia --project=@. -e "using Pluto; Pluto.run()"
```

or

```julia-repl
julia> ]
(v1.5) pkg> activate .
(QuantumComputingProblemsSolutions) pkg> instantiate
julia> using Pluto
julia> Pluto.run()
```


[^1]: Steeb, W. H., & Hardy, Y., Problems and solutions in quantum computing and quantum information (4th Edition). In Problems And Solutions In Quantum Computing And Quantum Information, World Scientific, 4th ed., 2018. [10.1142/10943](https://doi.org/10.1142/10943)

[^2]: Nielsen, Michael A., and Isaac Chuang, Quantum computation and quantum information, Cambridge, 2002. [10.1017/CBO9780511976667](https://doi.org/10.1017/CBO9780511976667)