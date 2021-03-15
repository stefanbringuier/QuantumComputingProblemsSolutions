<!--
Add here global page variables to use throughout your
website.

The website_* must be defined for the RSS to work
-->
@def website_title = "Quantum Computing Problems & Solutions"
@def website_descr = "Solving quantum computing problems in Julia using Sympy.jl within Pluto.jl notebooks"
@def website_url = " https://stefanbringuier.github.io/QuantumComputingProblemsSolutions/"

@def author = "S. Bringuier (stefanbringuier@gmail.com)"
@def mintoclevel = 2

@def prepath = "QuantumComputingProblemsSolutions"


<!--
Add here files or directories that should be ignored by Franklin, otherwise
these files might be copied and, if markdown, processed by Franklin which
you might not want. Indicate directories by ending the name with a `/`.
-->
@def ignore = ["node_modules/", "franklin", "franklin.pub"]

<!--
Add here global latex commands to use throughout your
pages. It can be math commands but does not need to be.
For instance:
* \newcommand{\phrase}{This is a long phrase to copy.}
-->

\newcommand{\note}[1]{@@note @@title ⚠ Note@@ @@content #1 @@ @@}
\newcommand{\warn}[1]{@@warning @@title ⚠ Warning!@@ @@content #1 @@ @@}

\newcommand{\linksympy}{[SymPy.jl](https://github.com/JuliaPy/SymPy.jl)}