### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 2dd32f90-7d39-11eb-0fb7-5b89988db109
begin
	using SymPy
end

# ╔═╡ 4bbf10a2-7d37-11eb-2397-993233a31dd6
md"""
**Problem 10.** A mixed state represents the statistical collection/mixture of pure sates of a quantum system, that is that the quantum state is described by a pair of probabilities over the pure states. If given a set of:


$\set{(p_1 , \ket{\psi_1}),\cdots,(p_n,\ket{\psi_n})}$

then the density matrix is:

$\rho =\sum_i^n p_i \ket{\psi_i}\bra{\psi_i}$

which is taken to be postive semidefinite, with normalized pure states.

1. Find the probability that the measurment in the orthonormal basis $\set{\ket{k_1},\cdots,\ket{k_n}}$ will yield $\ket{k_i}$
"""

# ╔═╡ 1a209b18-7d39-11eb-31b0-37754cf58546
 md"**Solution 10** The probablity of state $\ket{k_i}$ is given by the sum of probabilities of each state $\ket{\psi_j}$ "

# ╔═╡ b8df8fa4-7d5f-11eb-0252-73f1a8a8fabe
begin
	function adjointket(ket::Sym) 
		n,m = ket.shape
		ketsym = "⟨$(split(ket|>string,"")[2])|"
		bra = sympy.MatrixSymbol(ketsym,m,n)
		return bra
	end
	
	function ⋅(bra::Sym,ket::Sym)
		if bra === ket
			value = 1
		else
			value = 0
		end
		brasym = "⟨$(split(bra|>string,"")[2])"
		ketsym = "$(split(ket|>string,"")[2])⟩"
		expr = sympy.symbols((brasym*"|"*ketsym))
		return expr,value
	end
end;

# ╔═╡ 39eb3796-7d5c-11eb-1a11-4142522431a7
begin
	i,j = sympy.symbols("i,j")
	n,N = sympy.symbols("n,N")
	ψ = sympy.MatrixSymbol("|ψ⟩",N,1)
	k = sympy.MatrixSymbol("|k⟩",N,1)
	p = sympy.symbols("p")
end;

# ╔═╡ 1d8f3e70-7d6c-11eb-095e-63fc1714a99c
begin
	ψᵢ = sympy.Indexed(ψ,i)
	ψᵢᵖ = sympy.Indexed(adjointket(ψ),i)	
	kⱼ = sympy.Indexed(k,j);
	kⱼᵖ = sympy.Indexed(adjointket(k),j)
	pᵢ = sympy.Indexed(p,i)
end

# ╔═╡ 7f65d852-7d6c-11eb-05f1-9bb3746e9771
sympy.Sum(pᵢ*kⱼ*ψᵢᵖ*ψᵢ*kⱼᵖ,(i,0,n))

# ╔═╡ 6bb44d1c-7d70-11eb-1a94-07b2dd905326


# ╔═╡ Cell order:
# ╠═4bbf10a2-7d37-11eb-2397-993233a31dd6
# ╠═1a209b18-7d39-11eb-31b0-37754cf58546
# ╠═2dd32f90-7d39-11eb-0fb7-5b89988db109
# ╠═b8df8fa4-7d5f-11eb-0252-73f1a8a8fabe
# ╠═39eb3796-7d5c-11eb-1a11-4142522431a7
# ╠═1d8f3e70-7d6c-11eb-095e-63fc1714a99c
# ╠═7f65d852-7d6c-11eb-05f1-9bb3746e9771
# ╠═6bb44d1c-7d70-11eb-1a94-07b2dd905326
