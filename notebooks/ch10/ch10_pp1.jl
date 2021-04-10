### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 987bc194-99b7-11eb-2888-b3315880f5bc
begin
	using SymPy
end

# ╔═╡ 4d68afe6-99b4-11eb-1c86-31df3ccd2f95
md"""**Problem 1.**
$\ket{\psi}$ is a given state in Hilbert space $\mathcal{C}^n$. If $X$ and $Y$ are $n \times n$ hermitian matrices. The correlation for the state $\ket{psi}$ is given by:

$ C_{XY}(\ket{\psi}) := \bra{\psi} XY \ket{\psi} - \bra{\psi} X \ket{\psi} \bra{\psi} Y \ket{\psi} $

If $n=4$ and $X$ and $Y$ are:

$X = \begin{pmatrix} 0 & 0 & 0 & 1\\
0 & 0 & 1 & 0 \\
0 & 1 & 0 & 0 \\
1 & 0 & 0 & 0 \end{pmatrix}\hskip{3mm} Y= \begin{pmatrix} 1 & 0 & 0 & 0\\
0 & 0 & 0 & 1 \\
0 & 0 & 1 & 0 \\
0 & 1 & 0 & 0 \end{pmatrix}$

and we consider the state:

$\ket{\psi} = \frac{1}{\sqrt{2}}\begin{pmatrix} 1 \\ 0 \\ 0 \\ 1 \end{pmatrix}$. Evaluate the correlation measure.

"""

# ╔═╡ 8e24caee-99b7-11eb-1198-21bd9b7465f8
md"""**Solution.**
This is a fairly straightfoward calculation that can be done by hand. The correlation is 0."""

# ╔═╡ 9d7a0c82-99b7-11eb-114c-891dd03ce35a
begin
	⋅(X,Y) = X * Y
	⋅(X::Array{T,1},Y::Array{T,1}) where T<:SymPy.Sym = X[1] ⋅ Y[1]
	halfsqrt = 1/sympy.sqrt(2)
end;

# ╔═╡ b61a58ac-99b7-11eb-33b1-af0f3f96912f
begin
	ψ = halfsqrt ⋅ [1;
			        0;
			        0;
		    	    1];
	ψ′ = ψ.adjoint()
end;

# ╔═╡ dc39d3aa-99b7-11eb-37e7-bda25090708e
begin
	X = [0 0 0 1;
		 0 0 1 0;
		 0 1 0 0;
		 1 0 0 0]
	Y = [1 0 0 0;
		 0 0 0 1;
		 0 0 1 0;
		 0 1 0 0]
end;

# ╔═╡ 286079f0-99b8-11eb-2ec4-6f96151e57cb
cor = (ψ′ ⋅ X ⋅ ψ) ⋅ (ψ′ ⋅ Y ⋅ ψ) .- (ψ′ ⋅ (X ⋅ Y) ⋅ ψ)' ;

# ╔═╡ 9abdc414-99bb-11eb-2cda-a1bc40729ac7
md"""

$ C_{XY}(\ket{\psi}) = $(cor[1]) $
"""

# ╔═╡ Cell order:
# ╟─4d68afe6-99b4-11eb-1c86-31df3ccd2f95
# ╟─8e24caee-99b7-11eb-1198-21bd9b7465f8
# ╠═987bc194-99b7-11eb-2888-b3315880f5bc
# ╠═9d7a0c82-99b7-11eb-114c-891dd03ce35a
# ╠═b61a58ac-99b7-11eb-33b1-af0f3f96912f
# ╠═dc39d3aa-99b7-11eb-37e7-bda25090708e
# ╠═286079f0-99b8-11eb-2ec4-6f96151e57cb
# ╟─9abdc414-99bb-11eb-2cda-a1bc40729ac7
