### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 758770e7-6d28-4410-970e-448b74aeaa24
using SymPy

# ╔═╡ df6d8a20-d900-11eb-356e-fff642594829
md"""
**Problem 1.** Find the unitary matrix such that :

```math
\begin{align}
\ket{\psi_a} = \frac{1}{\sqrt{2}}\begin{bmatrix} 1 \\ 1 \end{bmatrix} &\hskip{3mm} &
\ket{\psi_b} = \frac{1}{\sqrt{2}}\begin{bmatrix} 1 \\ -1 \end{bmatrix}
\end{align}
```

```math
U\left(\ket{\psi_a} \otimes \ket{\psi_b}\right) = \frac{1}{\sqrt{2}}\begin{bmatrix} 1 \\ 1 \end{bmatrix} \otimes \frac{1}{\sqrt{2}}\begin{bmatrix} 1 \\ 1 \end{bmatrix}
```
"""

# ╔═╡ c8d4d6f4-6fb1-477a-b5e9-0c6a00d32c20
md"""
**Solution.** The tensor product unitaries that perform this operation is:

```math
U = \begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix} \otimes \begin{bmatrix} 0 & -1 \\ 1 & 0 \end{bmatrix}

```
"""

# ╔═╡ c1c4631e-b4e8-476b-9883-617c584143d3
begin 
	⋅ = *
	⊗ = kron
	halfsqrt = 1/sympy.sqrt(2)
end;

# ╔═╡ f0ba309f-564a-4316-891c-d5ecf8e7d0ae
begin
	q₁ = halfsqrt ⋅ sympy.Matrix([1;
								  1])
	q₂ = halfsqrt ⋅ sympy.Matrix([1;
								  -1])
end;

# ╔═╡ 33610504-8c10-4d0d-b35c-1736c7a1f953
U = sympy.Matrix([1 0; 0 1]) ⊗ sympy.Matrix([0 -1; 1 0])

# ╔═╡ 056ec4a7-7e1b-4ecb-a873-71c0a92200c1
begin
	ψ = q₁⊗q₁
	ψc = U⋅(q₁⊗q₂)
end

# ╔═╡ 03e23ce5-c83e-4784-b4b1-0ceb88a1d091
begin
	result = (ψ == ψc ) ? "clones" : "does not clone";
	md"""

	 The unitary $(result).
	"""
end

# ╔═╡ Cell order:
# ╟─df6d8a20-d900-11eb-356e-fff642594829
# ╟─c8d4d6f4-6fb1-477a-b5e9-0c6a00d32c20
# ╠═758770e7-6d28-4410-970e-448b74aeaa24
# ╠═c1c4631e-b4e8-476b-9883-617c584143d3
# ╠═f0ba309f-564a-4316-891c-d5ecf8e7d0ae
# ╠═33610504-8c10-4d0d-b35c-1736c7a1f953
# ╠═056ec4a7-7e1b-4ecb-a873-71c0a92200c1
# ╟─03e23ce5-c83e-4784-b4b1-0ceb88a1d091
