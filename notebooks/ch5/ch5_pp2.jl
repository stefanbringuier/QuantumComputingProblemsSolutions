### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ a4388ea6-82f1-11eb-0896-5d46cce70029
using SymPy

# ╔═╡ b00fcb72-82f1-11eb-1cf2-fdcfb6748f10
md"""**Problem 2.** Consider a $ 6 \times 6$ matrix $A = a_{ij}$, then calculate the partial trace in the basis:

$\begin{pmatrix} 1 \\ 0 \end{pmatrix} \otimes I_3, \hskip{3mm} \begin{pmatrix} 0 \\ 1 \end{pmatrix} \otimes I_3.$

Also calculate the partial trace with the basis:

$\begin{pmatrix} 1 \\ 0 \\ 0 \end{pmatrix} \otimes I_2, \hskip{3mm} \begin{pmatrix} 0 \\ 1 \\ 0 \end{pmatrix} \otimes I_2 ,\hskip{3mm} \begin{pmatrix} 0 \\ 0 \\ 1\end{pmatrix} \otimes I_2$


"""

# ╔═╡ 38adb4d8-82f2-11eb-0085-f5e7668c5fe0
md"**Solution.** The key thing to recall is ta the partial trace defines an operator of a subspace so:

$A := \text{tr}_B(A\otimes B) \equiv\sum_{i=1}^{N_B} (I_A \otimes \bra{\phi_i}) (A\otimes B) (I_A \otimes \ket{\phi_i})$

where $\ket{\phi_i}$ define an orthonormal basis in $B$ subspace.
"

# ╔═╡ 40eeb3a6-82f2-11eb-339e-c94768257f67
begin
	⊗(x,y)=kron(x,y)
	⊗(x::Array{Sym,2},y::Array{Sym,2}) = kron(x,y)
	⊗(x::Sym,y) = sympy.Matrix(kron(x.as_explicit(),y))
	⊗(x,y::Sym) = sympy.Matrix(kron(x,y.as_explicit()))
	𝐓(x::Array{Sym,2}) = sympy.Matrix(sympy.transpose(x))
	𝚝𝚛(x) = sympy.trace(x)
	⋅(x,y) = x*y
	⋅(x::Union{Sym,SymMatrix},y) = sympy.MatMul(x.as_explicit(),y,evaluate=true)
	⋅(x,y::Union{Sym,SymMatrix}) = sympy.MatMul(x,y.as_explicit(),evaluate=true)
end; 

# ╔═╡ 8a0cfbce-82f2-11eb-1bb3-dbacc1d882cc
begin
	A = sympy.MatrixSymbol("A",6,6)
	
	b₁ = [1;
		  0]
	
	b₂ = [0;
		  1]
	
	I₃ = sympy.Identity(3)
end;

# ╔═╡ 5ec7e022-82fd-11eb-2ed8-47061484c961
md"Calculate the matrices associated with subspace basis."

# ╔═╡ ca2aa8cc-82f5-11eb-3e60-d3342985eab4
begin
	n₁,n₁ᵀ = b₁⊗I₃,𝐓(b₁⊗I₃)
	n₂,n₂ᵀ = b₂⊗I₃,𝐓(b₂⊗I₃)
end;

# ╔═╡ 44ae20f2-82fd-11eb-1389-39090d426253
md"Now calculate the partial trace in this basis using the equation above"

# ╔═╡ 558649f6-82f6-11eb-3bf8-ebde0766efdc
n₁ᵀ ⋅ A ⋅ n₁ + n₂ᵀ ⋅ A ⋅ n₂

# ╔═╡ 43cd24c8-82fd-11eb-0211-d9c146c83df0
md"Now looking at the other basis:"

# ╔═╡ 916b7588-82fe-11eb-1796-2f8b1951dabb
begin
	c₁ = [1;
		  0;
	      0]
	
	c₂ = [0;
		  1;
	      0]
	
	c₃ = [0;
		  0;
		  1]
	
	I₂ = sympy.Identity(2)
end;

# ╔═╡ b5021cfe-82fe-11eb-2c61-2d85d2463a18
begin
	m₁,m₁ᵀ = c₁⊗I₂,𝐓(c₁⊗I₂)
	m₂,m₂ᵀ = c₂⊗I₂,𝐓(c₂⊗I₂)
	m₃,m₃ᵀ = c₃⊗I₂,𝐓(c₃⊗I₂)
end;

# ╔═╡ fbf1c7cc-82fe-11eb-272b-41b6b07f4da8
m₁ᵀ ⋅ A ⋅ m₁ + m₂ᵀ ⋅ A ⋅ m₂ + m₃ᵀ ⋅ A ⋅ m₃

# ╔═╡ Cell order:
# ╟─b00fcb72-82f1-11eb-1cf2-fdcfb6748f10
# ╟─38adb4d8-82f2-11eb-0085-f5e7668c5fe0
# ╠═a4388ea6-82f1-11eb-0896-5d46cce70029
# ╠═40eeb3a6-82f2-11eb-339e-c94768257f67
# ╠═8a0cfbce-82f2-11eb-1bb3-dbacc1d882cc
# ╟─5ec7e022-82fd-11eb-2ed8-47061484c961
# ╠═ca2aa8cc-82f5-11eb-3e60-d3342985eab4
# ╟─44ae20f2-82fd-11eb-1389-39090d426253
# ╠═558649f6-82f6-11eb-3bf8-ebde0766efdc
# ╟─43cd24c8-82fd-11eb-0211-d9c146c83df0
# ╠═916b7588-82fe-11eb-1796-2f8b1951dabb
# ╠═b5021cfe-82fe-11eb-2c61-2d85d2463a18
# ╠═fbf1c7cc-82fe-11eb-272b-41b6b07f4da8
