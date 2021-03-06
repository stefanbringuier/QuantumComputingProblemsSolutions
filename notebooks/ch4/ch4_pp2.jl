### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ dd5c350c-7e46-11eb-1464-e9108adb161c
using SymPy

# ╔═╡ 1d2c2b6e-7e46-11eb-12da-25dc30b41b92
md"""
**Problem 2.** Consider the density  matrix

$\rho = \frac{1}{2}\begin{pmatrix} 1 & -1 \\ -1 & 1 \end{pmatrix}$

and another matrix $A$ which is $2 \times 2$ real valued and symmetric. Assuming that the $\text{tr}(\rho A) = -1$ and $\text{tr}(\rho A^2) = 1$. Recosntruct the matrix from this information.
"""

# ╔═╡ d46c919e-7e46-11eb-1ee6-e7bd5c6ec6f0
md"""
**Solution 2.**
"""

# ╔═╡ 9586fcd4-7e51-11eb-3d95-cffa93849e02
md"Setting up some usefull sympy functions."

# ╔═╡ 8338d0d4-7e47-11eb-3e1d-7b19f429dd9f
begin
	⋅(X,Y) = sympy.MatMul(X,Y,evaluate=true)
	𝚝𝚛(X) = sympy.trace(X)
end;

# ╔═╡ 44f035a2-7e4b-11eb-1903-efd2b539543f
md"Define the the matrices $\rho$, $A$, and $A^2$, recall $A$ is real and symmetric."

# ╔═╡ e2fa514c-7e46-11eb-1a83-51c9675fa0c0
begin
	ρ = 1/2 * sympy.Matrix([ 1 -1;
		                    -1  1]);
	A₁₁,A₁₂,A₂₂ = sympy.symbols("A₁₁,A₁₂,A₂₂",real=true)
	A₂₁ = A₁₂
	A = sympy.Matrix([A₁₁ A₁₂;
			          A₂₁ A₂₂])
	A² = A⋅A
end;

# ╔═╡ 525ec322-7e53-11eb-13d7-8bd5ad24b858
md"""
The matrix $\rho A$ then looks like:
"""

# ╔═╡ 44c6e35c-7e53-11eb-1339-b94755416408
ρ⋅A

# ╔═╡ a30c539a-7e51-11eb-270c-ff5df34fd90b
md"Now defining expressions corresponding to the conditions $\text{tr}(\rho A) = -1$ and $\text{tr}(\rho A^2) = 1$."

# ╔═╡ 4880cac8-7e47-11eb-088f-f9ba956bd803
expr1 = 𝚝𝚛(ρ⋅A) + 1

# ╔═╡ b6bd9cf0-7e47-11eb-267a-6571dae363ca
expr2 =𝚝𝚛(ρ⋅A²) - 1

# ╔═╡ e343e6ee-7e4c-11eb-178d-67c7f0b5b247
solution = solve([expr1,expr2],A,dict=true); 

# ╔═╡ 0eaf4b66-7e52-11eb-2e97-45c041e5e534
md"""
The solutions for the matrix $A$ is then: 

$ A = $(sympy.latex(A.subs(solution...))) $

where $A_{22}$ is some real valued constant.
"""

# ╔═╡ 9b940c5a-7e53-11eb-0fde-4fd9ed82471b
md"""
> Run this command to plug solution into original symbolic variable.
```julia
A.subs(solution...)
```
"""

# ╔═╡ Cell order:
# ╟─1d2c2b6e-7e46-11eb-12da-25dc30b41b92
# ╟─d46c919e-7e46-11eb-1ee6-e7bd5c6ec6f0
# ╠═dd5c350c-7e46-11eb-1464-e9108adb161c
# ╟─9586fcd4-7e51-11eb-3d95-cffa93849e02
# ╠═8338d0d4-7e47-11eb-3e1d-7b19f429dd9f
# ╟─44f035a2-7e4b-11eb-1903-efd2b539543f
# ╠═e2fa514c-7e46-11eb-1a83-51c9675fa0c0
# ╟─525ec322-7e53-11eb-13d7-8bd5ad24b858
# ╠═44c6e35c-7e53-11eb-1339-b94755416408
# ╟─a30c539a-7e51-11eb-270c-ff5df34fd90b
# ╠═4880cac8-7e47-11eb-088f-f9ba956bd803
# ╠═b6bd9cf0-7e47-11eb-267a-6571dae363ca
# ╠═e343e6ee-7e4c-11eb-178d-67c7f0b5b247
# ╟─0eaf4b66-7e52-11eb-2e97-45c041e5e534
# ╟─9b940c5a-7e53-11eb-0fde-4fd9ed82471b
