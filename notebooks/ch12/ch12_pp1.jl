### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ fa8833ea-bc94-4f0c-af20-b83eb343ac5c
begin
	using Pkg
	Pkg.add("Quantikz")
	Pkg.precompile()
end

# ╔═╡ c9c2d413-d605-44a8-8740-d7baf24c358c
begin
	using Quantikz
	circuit=[Initialize("\\ket{\\psi}",[1]),
		Initialize("\\ket{0}",[2]),Initialize("\\ket{0}",[3]),
		H(2),CNOT(2,3),CNOT(1,2),H(1),
		CNOT(2,3),H(3),CNOT(1,3),H(3)
		]
end

# ╔═╡ 431d0ce0-35f9-490f-bcf8-4bf87e83326d
begin
	using SymPy
end

# ╔═╡ d493b5f4-f9dd-4bd7-b980-42c5bdd63164
md"**Note**: This notebook using the package [Quantikz.jl](https://github.com/Krastanov/Quantikz)"

# ╔═╡ 1df58d76-cd3d-11eb-0793-5f503b643ff6
md"""
**Problem 1.** Quantum teleporation utlizes the state:

```math
\begin{equation}
\ket{\psi} \otimes \ket{0} \otimes \ket{0}
\end{equation}
```

where $\ket{\psi}$ exist in a Hilbert space of $\mathbb{C}^2$ and therefore the total system Hilbert space $\mathbb{C}^8$.

Now given the following circuit which performs quantum teleporation:
"""

# ╔═╡ 5ce5393b-e335-48f3-8fb0-77a00a6da19d
md"""
1. Construct all the corresponding unitary matrices.
2. Calculate $\prod_{i=1}^{N=8} U_i\ket{\psi 0 0}$
3. Verify the teleportation algorithm/circuit
"""

# ╔═╡ c09586f8-6d73-4ed2-99e0-f2ef1bb43648
md"""**Solution.**
To understand what happens, we can represent all the quantum gates via there unitary matrix operator representation on the product state $\ket{\psi 00}$.

"""

# ╔═╡ 26f1e902-0268-4c3a-9acf-979188e0b394
begin
	𝑖 = sympy.I
	half = sympy.Rational(1,2)
	halfsqrt = 1/sympy.sqrt(2)
	⋅ = *
	⊗(X,Y) = kron(X,Y)
	
	"""Direct sum of vector spaces.
	""" 
	⊕(X,Y) = begin
		xdim = size(X);
		ydim = size(Y);
		M = [           X           zeros(Int,xdim[1],ydim[2]);
		      zeros(Int,ydim[1],xdim[2])          Y           ];
		return M
	end
end;

# ╔═╡ f4a3c733-5717-4f6c-829f-70d77427f920
begin
	q₀ = sympy.Matrix([1;
		               0])
	q₁ = sympy.Matrix([0;
		               1])
	a,b = sympy.symbols("a,b",real=true)
	ψ = a⋅q₀ + b⋅q₁
end;

# ╔═╡ adfa0422-d72c-4eb6-9571-63cde49da807
begin
	𝕀 = sympy.Matrix([1 0;
			        0 1])
	ℍ = halfsqrt ⋅ sympy.Matrix([1 1;
		                       1 -1])
	𝕏 = sympy.Matrix([0 1;
			          1 0])
	𝙲𝙽𝙾𝚃 = sympy.Matrix([1 0 0 0;
			             0 1 0 0;
			             0 0 0 1;
			             0 0 1 0])
end;

# ╔═╡ 7ae2a432-4c54-4a67-8381-5e75abb159e9
md"""
The position of the local operator indicates which qubit it acts on, for example $I \otimes H \otimes I$, corresponds to $I\ket{\psi} \otimes H\ket{0} \otimes I\ket{0}$.
"""

# ╔═╡ 6f50bf5d-7804-4e58-ba62-92448359678d
U₁ = 𝕀 ⊗ ℍ ⊗ 𝕀;

# ╔═╡ 3d954d1a-3cf5-43e5-ab28-cae9e49b5d61
U₂ = U₅ = 𝕀 ⊗ 𝙲𝙽𝙾𝚃;

# ╔═╡ f52a1d7b-b99f-4f27-8781-e5a392d17f03
U₃ = 𝙲𝙽𝙾𝚃 ⊗ 𝕀;

# ╔═╡ 17b8c450-b934-4468-b95e-e8a866e1048e
U₄ = ℍ ⊗ 𝕀 ⊗ 𝕀;

# ╔═╡ e48beec0-df0b-4e22-abf0-c199579a25d6
U₆ = U₈ = 𝕀 ⊗ 𝕀 ⊗ ℍ;

# ╔═╡ f8f8b09e-a110-4f71-beaa-3addbed65059
U₇ = (𝕀 ⊗ 𝕀) ⊕ 𝕏 ⊕ 𝕏 ;

# ╔═╡ 95987d9a-f944-45d8-b6fd-cb82bf2d1250
md"""
Now calculating $\prod_{i=1}^{N=8} U_i\ket{\psi 0 0}$:
"""

# ╔═╡ 628af691-4cc5-4abb-99d0-2fcbef07c95c
state = U₈⋅U₇⋅U₆⋅U₅⋅U₄⋅U₃⋅U₂⋅U₁⋅(ψ ⊗ q₀ ⊗ q₀)

# ╔═╡ ee3a27cb-67b7-4584-ac72-2bcf88fdb16a
md"""
This state written in ket notation would be:
```math
\begin{equation}
\frac{a}{2}\left(\ket{000} +\ket{100} +\ket{010} + \ket{110}\right) + \frac{b}{2}\left(\ket{011} + \ket{111} + \ket{001} +\ket{101}\right)
\end{equation}

```
"""

# ╔═╡ d985bbb9-9c14-41c5-922b-065393418aba
begin
	b₁ = a/2 ⋅ ((q₀⊗q₀⊗q₀)+(q₁⊗q₀⊗q₀)+(q₀⊗q₁⊗q₀)+(q₁⊗q₁⊗q₀))
	b₂ = b/2 ⋅ ((q₀⊗q₁⊗q₁)+(q₁⊗q₁⊗q₁)+(q₀⊗q₀⊗q₁)+(q₁⊗q₀⊗q₁))
end;

# ╔═╡ 70084591-c223-43af-83a2-10722168ad4a
md"""

To verify the teleportation algorithm/circuit we will perform projective measurements on the transformed state $\mathbb{U}\ket{\psi 00}$.
"""

# ╔═╡ 31ba1877-a345-4216-b82f-c22ee3a29647
md"""
Specify the state acted on by the Unitaries that make up the quantum circuit as shown above.
"""

# ╔═╡ ad7c9633-1b46-40c6-b2b6-e8f41229d84b
begin
	U = [U₈,U₇,U₆,U₅,U₄,U₃,U₂,U₁];
	S₀ = ψ ⊗ q₀ ⊗ q₀;
end;

# ╔═╡ a466ed3a-cf12-4399-bd0b-7d160ccf46f8
applycircuit(U::AbstractArray{T},S::T) where T<:Array{Sym,2} = prod(U)⋅S;

# ╔═╡ b5759784-de23-4ae3-893c-0a7ba95ca3b9
Sₛ = applycircuit(U,S₀)

# ╔═╡ a968b8f7-ba88-4406-a692-8214468a6882
"""
Projective measurement of state vector for last two qubits.

### Inputs
	* S:: Array{Sym,2} - statevector
	* q₁,q₂:: Int {0,1} - state of the qubit to measure in.

### Returns
	* Sₘ ::Array{Sym,2} - normalized measured statevector

""" function projectivemeasure(S::Array{Sym,2},i₁::Int,i₂::Int)

	eₘ = Dict(0=>q₀,1=>q₁);

	p₁ = q₀ ⊗ eₘ[i₁] ⊗ q₀;
	p₂ = q₀ ⊗ eₘ[i₁] ⊗ eₘ[i₂];
	
	P = p₁⋅p₁' + p₂⋅p₂'
	
	norm =  √(S' ⋅ P ⋅ S)[1]
	
	Sₘ = P⋅S / norm;
	
	#Simplify coefficients
	Sₘ = Sₘ.subs([(a*a,1-b*b)])

	return Sₘ
	
end;

# ╔═╡ ccfb0c31-526e-4975-a4ce-87c300969ca5
md"""
!!! note
	Projective measure function still needs to be verified.
"""

# ╔═╡ 24d9acda-fc47-45a6-939c-9820705a8f0f
projectivemeasure(Sₛ,0,0)

# ╔═╡ 4f5c4ce3-f614-48d1-b735-522b49f18c60
projectivemeasure(Sₛ,0,1)

# ╔═╡ c1055bdb-67e0-4376-aeb9-1bd4be2ca0a0
projectivemeasure(Sₛ,1,0)

# ╔═╡ e37ae59a-7064-48b3-9494-781c97ad937e
projectivemeasure(Sₛ,1,1)

# ╔═╡ 7ec9bcd1-52db-40c8-add9-ce7b43d500b9
"""
NOT TESTED
""" function measurestate(S::Array{Sym,2},qᵢ::Int,v::Int)
	Sₘ = copy(S)
	len = length(S) ÷ 2^(qᵢ+1)
	skip = 1-v;
	
	normvalues = zeros(Sym,len);
	
	for i=0:(len-1)
		if i%len != 0
			skip = 1-skip
		end
		
		if skip == 1
			Sₘ[i+1] = 0
		else
			normvalues[i+1] = S[i+1].conjugate()⋅S[i+1]
		end
	end
	normalize = sqrt(sum(normvalues))::Sym
	
	return Sₘ / normalize
end;

# ╔═╡ Cell order:
# ╟─d493b5f4-f9dd-4bd7-b980-42c5bdd63164
# ╠═fa8833ea-bc94-4f0c-af20-b83eb343ac5c
# ╟─1df58d76-cd3d-11eb-0793-5f503b643ff6
# ╠═c9c2d413-d605-44a8-8740-d7baf24c358c
# ╟─5ce5393b-e335-48f3-8fb0-77a00a6da19d
# ╟─c09586f8-6d73-4ed2-99e0-f2ef1bb43648
# ╠═431d0ce0-35f9-490f-bcf8-4bf87e83326d
# ╠═26f1e902-0268-4c3a-9acf-979188e0b394
# ╠═f4a3c733-5717-4f6c-829f-70d77427f920
# ╠═adfa0422-d72c-4eb6-9571-63cde49da807
# ╟─7ae2a432-4c54-4a67-8381-5e75abb159e9
# ╠═6f50bf5d-7804-4e58-ba62-92448359678d
# ╠═3d954d1a-3cf5-43e5-ab28-cae9e49b5d61
# ╠═f52a1d7b-b99f-4f27-8781-e5a392d17f03
# ╠═17b8c450-b934-4468-b95e-e8a866e1048e
# ╠═e48beec0-df0b-4e22-abf0-c199579a25d6
# ╠═f8f8b09e-a110-4f71-beaa-3addbed65059
# ╟─95987d9a-f944-45d8-b6fd-cb82bf2d1250
# ╠═628af691-4cc5-4abb-99d0-2fcbef07c95c
# ╟─ee3a27cb-67b7-4584-ac72-2bcf88fdb16a
# ╠═d985bbb9-9c14-41c5-922b-065393418aba
# ╟─70084591-c223-43af-83a2-10722168ad4a
# ╟─31ba1877-a345-4216-b82f-c22ee3a29647
# ╠═ad7c9633-1b46-40c6-b2b6-e8f41229d84b
# ╠═a466ed3a-cf12-4399-bd0b-7d160ccf46f8
# ╠═b5759784-de23-4ae3-893c-0a7ba95ca3b9
# ╠═a968b8f7-ba88-4406-a692-8214468a6882
# ╟─ccfb0c31-526e-4975-a4ce-87c300969ca5
# ╠═24d9acda-fc47-45a6-939c-9820705a8f0f
# ╠═4f5c4ce3-f614-48d1-b735-522b49f18c60
# ╠═c1055bdb-67e0-4376-aeb9-1bd4be2ca0a0
# ╠═e37ae59a-7064-48b3-9494-781c97ad937e
# ╟─7ec9bcd1-52db-40c8-add9-ce7b43d500b9
