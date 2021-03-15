### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ d0b221fe-83cd-11eb-1995-ed02a36fcc5f
using SymPy

# ╔═╡ e3df1d72-83cd-11eb-0458-db10d9e89896
md"""**Problem 1.**
GIven the standard basis $\mathbf{e}_1, \mathbf{e}_2, \mathbf{e}_3, \mathbf{e}_4$ in $\mathbb{C}^4$ and the untary matrices:

$U_{CNOT} = \begin{pmatrix} 1 & 0 & 0 & 0 \\ 0 & 1 & 0 & 0 \\ 0 & 0 & 0 & 1 \\ 0 & 0 & 1 & 0 \end{pmatrix}, \hskip{3mm} V_H = H \otimes I_2$

where $H$ is the Hadamard matrix $\frac{1}{\sqrt{2}}\begin{pmatrix} 1 & 1 \\ 1 & -1 \end{pmatrix}$. Show that the unitary matrices acting on the standard basis generates Bell states. That is:

$U_{CNOT}\, V_H \, \ket{\mathbf{e}_i}$

"""

# ╔═╡ ddba09d0-8543-11eb-1c18-4df278b212c7
md"""**Solution.**
This is just a simple demonstration of unitary operators acting on a basis set, therefore we just go through the matrix algebra as shown below.
"""

# ╔═╡ a8a805b8-83d0-11eb-2cc1-69dad6639cba
begin
	sqrthalf = 1/sympy.sqrt(2)
	⋅(x,y) = x*y
	⊗(x,y) = kron(x,y)
end;

# ╔═╡ 19816f4a-83d1-11eb-2643-338cedca4d5d
begin
	𝐞₁ = [1;
		  0;
		  0;
		  0]
	𝐞₂ = [0;
		  1;
		  0;
		  0]
	𝐞₃ = [0;
		  0;
		  1;
		  0]
	𝐞₄ = [0;
		  0;
		  0;
		  1]
	𝐞 = [𝐞₁ 𝐞₂ 𝐞₃ 𝐞₄];
end;
		  

# ╔═╡ 8ffbbcc6-83d0-11eb-056a-8def113c5030
begin
	U = [1 0 0 0;
		 0 1 0 0;
		 0 0 0 1;
		 0 0 1 0];
	H = sqrthalf ⋅ [ 1  1;
		             1 -1];
	I₂ = sympy.eye(2,2) #could also use sympy.Identity(2)
	V = H ⊗ I₂
end;

# ╔═╡ 5fb56108-8541-11eb-261c-158a0e56c914
@bind i html"<input type='range' min=1 max=4>"

# ╔═╡ 9fb879b6-8541-11eb-13d7-4303d4b9f795
md"""
$ U \cdot H \otimes I \ket{e_$(i)} = $(sympy.latex(U⋅V⋅𝐞[:,i])) $
"""

# ╔═╡ Cell order:
# ╟─e3df1d72-83cd-11eb-0458-db10d9e89896
# ╟─ddba09d0-8543-11eb-1c18-4df278b212c7
# ╠═d0b221fe-83cd-11eb-1995-ed02a36fcc5f
# ╠═a8a805b8-83d0-11eb-2cc1-69dad6639cba
# ╠═19816f4a-83d1-11eb-2643-338cedca4d5d
# ╠═8ffbbcc6-83d0-11eb-056a-8def113c5030
# ╟─5fb56108-8541-11eb-261c-158a0e56c914
# ╟─9fb879b6-8541-11eb-13d7-4303d4b9f795
