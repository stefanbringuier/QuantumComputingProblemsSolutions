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

# ╔═╡ 696e076a-76f5-11eb-2e4c-5be7bbcddeb9
using SymPy

# ╔═╡ 6c4aabdc-76f5-11eb-364f-8d63965d3eee
md"""
**Problem 2.** Let $S_1$, $S_2$, and $S_3$ be the spin matrices for spin 1/2 particles (i.e. fermion Pauli spin matrices) given by:

$S_1 = \frac{1}{2}\begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix} \hskip{5mm} S_2 = \frac{1}{2}\begin{pmatrix} 0 & -i \\ i & 0 \end{pmatrix} \hskip{5mm} S_2 = \frac{1}{2}\begin{pmatrix} 1 & 0 \\ 0 & -1 \end{pmatrix}.$

If we consider the following Hamiltonians expressed in terms of these matrices:

$H = \frac{1}{\hbar\omega}\hat{H} = S_1 \otimes S_1 + S_2 \otimes S_2 + S_3 \otimes S_3$

$K = \frac{1}{\hbar\omega}\hat{K} = S_1 \otimes S_2 + S_2 \otimes S_3 + S_3 \otimes S_1.$

What are the eigenvalues and eigenvectors.
"""

# ╔═╡ 57a31af0-76f5-11eb-105e-21615c89e2a7
begin
	𝑖,(ħ,ω) = sympy.I,sympy.symbols("ħ,ω")
	half = sympy.Rational(1,2)
	⊗(x,y) = kron(x,y) #This is the same as tensor product.
	⋅ = *
end;

# ╔═╡ 993b3276-770a-11eb-1b62-91a9c3045190
begin
	σ₁ = half⋅[0 1;
		       1 0]
	σ₂ = half⋅[0 -𝑖;
		       𝑖 0]
	σ₃ = half⋅[1 0;
		       0 -1]
end;

# ╔═╡ d7419b98-770a-11eb-0556-03f675b8eed5
 Ĥ = (σ₁ ⊗ σ₁) + (σ₂ ⊗ σ₂) + (σ₃ ⊗ σ₃)

# ╔═╡ 23cb357e-770d-11eb-3f7e-4d1021f06480
K̂ = (σ₁ ⊗ σ₂) + (σ₂ ⊗ σ₃) + (σ₃ ⊗ σ₁)

# ╔═╡ 0cf9a24e-772c-11eb-1697-7f05ef30e2f6
md"The eigenvectors and eigenvalues for these operators are then:"

# ╔═╡ b621c09a-772c-11eb-2e3d-2f4648c12724
begin
	ℍ,𝕂 = Ĥ.eigenvects(chop=true),K̂.eigenvects(chop=true)
	#unpack :e - eigenvalue, :m - multiplicty (degeneracy)
	eₕ = [Dict(:e=>e[1],:m=>e[2]) for e in ℍ]
	eₖ = [Dict(:e=>e[1],:m=>e[2]) for e in 𝕂]
	vₕ = [v[end][1:end] for v in ℍ]
	vₖ = [v[end][1:end] for v in 𝕂]
end;

# ╔═╡ 37b73052-7798-11eb-0b24-59f194a1aa1c
begin
	eslider = @bind e html"<select><option value='e'>eigenvalues</option><option value='m'>degeneracy</option></select>"
	lslider = @bind l html"<input type=range min=1 max=2>"
	md"""
	$(eslider)
	
	$(lslider)
	"""
end

# ╔═╡ 7967e106-77a0-11eb-05d3-3b3a7a1e705f
md"indices 1 to $(l)"

# ╔═╡ 89a62998-7731-11eb-0eb9-bd1eb5747234
begin
	label = e == "e" ? "λ" : "m"
	termh = sympy.latex(map((x,y)->"$(label)_$(y) = $(x[Symbol(e)])",eₕ[1:l],1:l))
	termk = sympy.latex(map((x,y)->"$(label)_$(y) = $(x[Symbol(e)])",eₖ[1:l],1:l))
	md"""
	$ \hat{H}: $(termh) $
	
	$ \hat{K}: $(termk) $
	"""
end

# ╔═╡ 9e740666-7799-11eb-16ee-85977d061e10
md"""
As you can see the eigensepectrum[^1] is the same for both operators. In addition there is a 3-fold degeneracy for the second eigenstate. Lets take a look at the eigenvectors $\hat{H}$:
"""

# ╔═╡ 6cc33c94-77a1-11eb-0285-1fdcb812d329
@bind v html"<input type=range min=1 max=2>"

# ╔═╡ ee4be832-77a0-11eb-0929-e13e2ab4cf95
md"eigenvector index $(v)"

# ╔═╡ e200bf2c-779a-11eb-3135-e91d22bb70c3
begin 
#	termvh = map(sympy.latex,map((x,y)->x[y][1:eₕ[y][:m]],vₕ[1:l],1:l))
#	termvk = map(sympy.latex,map((x,y)->"λ_$(y) = $(x)",vₖ[1:l],1:l))
#	md"""
#	$ \hat{H}: $(termvh) $
#	
#	$ \hat{K}: $(termvk) $
#	"""
	vₕ[v]
end

# ╔═╡ 206c9cc8-779f-11eb-07c7-51d57e3cfdf0
md"and $\hat{K}$:"

# ╔═╡ b9c36cbe-779d-11eb-03da-7593b325cd34
vₖ[v]

# ╔═╡ 5a4bea26-7799-11eb-2891-657899e8fa13
md"[^1]: Note that the $\frac{1}{\hbar \omega}$ isn't included here."

# ╔═╡ Cell order:
# ╟─6c4aabdc-76f5-11eb-364f-8d63965d3eee
# ╠═696e076a-76f5-11eb-2e4c-5be7bbcddeb9
# ╠═57a31af0-76f5-11eb-105e-21615c89e2a7
# ╠═993b3276-770a-11eb-1b62-91a9c3045190
# ╠═d7419b98-770a-11eb-0556-03f675b8eed5
# ╠═23cb357e-770d-11eb-3f7e-4d1021f06480
# ╟─0cf9a24e-772c-11eb-1697-7f05ef30e2f6
# ╠═b621c09a-772c-11eb-2e3d-2f4648c12724
# ╟─37b73052-7798-11eb-0b24-59f194a1aa1c
# ╟─7967e106-77a0-11eb-05d3-3b3a7a1e705f
# ╟─89a62998-7731-11eb-0eb9-bd1eb5747234
# ╟─9e740666-7799-11eb-16ee-85977d061e10
# ╟─6cc33c94-77a1-11eb-0285-1fdcb812d329
# ╟─ee4be832-77a0-11eb-0929-e13e2ab4cf95
# ╟─e200bf2c-779a-11eb-3135-e91d22bb70c3
# ╟─206c9cc8-779f-11eb-07c7-51d57e3cfdf0
# ╟─b9c36cbe-779d-11eb-03da-7593b325cd34
# ╟─5a4bea26-7799-11eb-2891-657899e8fa13
