### A Pluto.jl notebook ###
# v0.14.5

using Markdown
using InteractiveUtils

# ╔═╡ 32fe39d1-bd61-415c-b317-2eb9ecf876a1
begin
	using SymPy
end

# ╔═╡ 4541f1b4-b215-11eb-30b7-6174e9304296
md"""**Problem 1.** Given the two Pauli operators $\sigma_x$ and $\sigma_y$ and the operators:

```math
\begin{align}
\hat{\Sigma}_1 &= \frac{1}{\sqrt{2}}\left(\sigma_x + \sigma_y\right) \\
\hat{\Sigma}_2 &= \frac{1}{\sqrt{2}}\left(\sigma_x - \sigma_y\right) 
\end{align}
```

Now consider the states:

1. $\ket{\psi} = \begin{pmatrix} 1 \\ 1 \\ 1 \\ -1 \end{pmatrix}$

2. $\ket{\phi} = \frac{1}{2} \begin{pmatrix} 1 \\ 1 \\ 1 \\ 1 \end{pmatrix}$

Do the Hermitian operators above violate the Bell inequality for the two states provided.
"""

# ╔═╡ 2debd97c-df82-4fd6-9c99-7843ac661bb9
md"""**Solution 1.**
The first thing to note is the generalized Bell inequality for two Hilbert spaces, $\mathcal{H}_A$ and $\mathcal{H}_B$ with four operators $\hat{A}_1 ,\hat{A}_2, \hat{B}_1, \hat{B}_2$, is given by:

```math

\begin{equation}
\left|\bra{\psi} \hat{A}_1 \otimes \hat{B}_1 \ket{\psi} + \bra{\psi} \hat{A}_1 \otimes \hat{B}_2 \ket{\psi} + \bra{\psi} \hat{A}_2 \otimes \hat{B}_1 \ket{\psi} + \bra{\psi} \hat{A}_2 \otimes \hat{B}_2 \ket{\psi} \right| \leq 2
\end{equation}

```
therefore the goal is to evaluate the left hand side of this equation to see if the inequality is violated.

On quick observation is that the state in 2. is a product state from the tensor product of two $\ket{+}$ basis states. Therefore it will not have any quantum entanglement and obey the inequality.
"""

# ╔═╡ 5f3e45aa-b066-4a69-bc7f-324ee1437a15
begin
	𝑖 = sympy.I
	half = sympy.Rational(1,2)
	halfsqrt = 1/sympy.sqrt(2)
	⋅ = *
	⊗(X,Y) = kron(X,Y)
end;

# ╔═╡ 52ed63b4-3136-4e09-8b21-a20ebeafbcfe
begin
	σx = sympy.Matrix([0 1;
			           1 0])
	σy = sympy.Matrix([0 -𝑖;
			           𝑖  0])
end;

# ╔═╡ 9ad6d693-4a17-47cd-9515-700b1fd3be37
begin
	Σ₁ = halfsqrt ⋅ (σx + σy)
	Σ₂ = halfsqrt ⋅ (σx - σy)
end;

# ╔═╡ a93c5ba8-192d-48f9-9b88-54f4e811450a
begin
	ψ = sympy.Matrix([1;
		              1;
	                  1;
		             -1])
	ψᵃ = ψ.adjoint()
	ϕ = half ⋅ sympy.Matrix([1;
			                 1;
			                 1;
			                 1])
	ϕᵃ = ϕ.adjoint()
end;

# ╔═╡ 106a9cce-be4a-45e3-bff3-5e5808960fee
function bellinequality(𝓞,𝓢)
	lhs = sympy.Abs(𝓢[1]⋅𝓞[1]⋅𝓢[2] + 
		      	    𝓢[1]⋅𝓞[2]⋅𝓢[2] +
			        𝓢[1]⋅𝓞[3]⋅𝓢[2] +
		            𝓢[1]⋅𝓞[4]⋅𝓢[2])
	return lhs[0] ≤ 2
end
	

# ╔═╡ 4dedc5dc-ea0e-4738-92e5-7f6b22001bbe
md"""
Now checking if Bell's inequality is violated for the state $\ket{\psi}$:
"""

# ╔═╡ 9dd0fad0-e118-4610-bf9f-873faf6166d1
result1 = bellinequality((σx⊗Σ₁,σx⊗Σ₂,σy⊗Σ₁,σy⊗Σ₂),(ψᵃ,ψ));

# ╔═╡ 4774017b-40f4-498f-8a76-a3bb14b075db
begin
	if result1 == true
		md"""Bell's inequality not violated!"""
	else
		md"""Bell's inequality violated!"""
	end
end

# ╔═╡ f8b63839-59c1-4c28-815c-2f7de2544c03
result2 = bellinequality((σx⊗Σ₁,σx⊗Σ₂,σy⊗Σ₁,σy⊗Σ₂),(ϕᵃ,ϕ));

# ╔═╡ 153d3949-15b9-455d-b572-fb08465cbaaa
md"""Now for the state $\phi$ which is trivial"""

# ╔═╡ 93574566-882e-4788-aae6-dc49ea38bd6c
begin
	if result2 == true
		md"""Bell's inequality not violated!"""
	else
		md"""Bell's inequality violated!"""
	end
end

# ╔═╡ Cell order:
# ╟─4541f1b4-b215-11eb-30b7-6174e9304296
# ╟─2debd97c-df82-4fd6-9c99-7843ac661bb9
# ╠═32fe39d1-bd61-415c-b317-2eb9ecf876a1
# ╠═5f3e45aa-b066-4a69-bc7f-324ee1437a15
# ╠═52ed63b4-3136-4e09-8b21-a20ebeafbcfe
# ╠═9ad6d693-4a17-47cd-9515-700b1fd3be37
# ╠═a93c5ba8-192d-48f9-9b88-54f4e811450a
# ╠═106a9cce-be4a-45e3-bff3-5e5808960fee
# ╟─4dedc5dc-ea0e-4738-92e5-7f6b22001bbe
# ╠═9dd0fad0-e118-4610-bf9f-873faf6166d1
# ╟─4774017b-40f4-498f-8a76-a3bb14b075db
# ╠═f8b63839-59c1-4c28-815c-2f7de2544c03
# ╟─153d3949-15b9-455d-b572-fb08465cbaaa
# ╟─93574566-882e-4788-aae6-dc49ea38bd6c
