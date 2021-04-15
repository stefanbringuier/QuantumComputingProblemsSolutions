### A Pluto.jl notebook ###
# v0.14.2

using Markdown
using InteractiveUtils

# ╔═╡ b992e62c-defb-46cd-8f8e-df4bdf9dbe93
begin
	using SymPy
end

# ╔═╡ dbb6ec82-9c0b-11eb-28bd-e9afc91a9bbf
md"""**Problem 2**
Assuming a normalized vector:

```math
\mathbf{v} = \frac{1}{2} \begin{pmatrix} 1 \\ -1 \\ 0 \\ 0 \\ 1 \\ -1 \end{pmatrix}
```

if we have two vectors $\mathbf{u}$ and $\mathbf{w}$ which are vectors in $\mathbb{C}^3$ and $\mathbb{C}^2$ respectively, can we write $\mathbf{v}$ as a tensor product of $\mathbf{u}$ and $\mathbf{w}$ (ie., $\mathbf{v} \otimes \mathbf{w}$) or the other way around (ie., $\mathbf{w} \otimes \mathbf{w}$). 
"""

# ╔═╡ 53613aa0-6fd8-4eb1-864f-b84f5b2d30f5
md"""**Solution.**
"""

# ╔═╡ d5a376f6-a528-474c-b879-5cda82e6ad89
begin
	half = sympy.Rational(1,2)
	⋅ = *
	⊗(X,Y) = kron(X,Y)
	#⊗(X,Y) = sympy.KroneckerProduct(X,Y).as_explicit()
end;

# ╔═╡ 326beaf4-d90c-43f4-be6a-eb6e851e78af
begin
	𝐯= half ⋅ sympy.Matrix([1;
		                   -1;
		                    0;
		                    0;
		                    1;
		                   -1]);
	u₁,u₂,u₃ = sympy.symbols("u₁ u₂ u₃")
	w₁,w₂,w₃ = sympy.symbols("w₁ w₂ w₃")
	𝐮 = sympy.Matrix([u₁;
		              u₂;
	                  u₃]);
	𝐰 = sympy.Matrix([w₁;
		 			  w₂;]);
end;

# ╔═╡ 0c6318ba-0ec1-41d4-b1f4-73757c767a21
begin
	𝐮𝐰 = 𝐮 ⊗ 𝐰;
	𝐰𝐮 = 𝐰 ⊗ 𝐮;
end;

# ╔═╡ 2369a8ff-28ec-466b-abd1-165afaabab79
begin
	eq1 = sympy.Eq(𝐯,𝐮𝐰)
	eq2 = sympy.Eq(𝐯,𝐰𝐮)
end;

# ╔═╡ 7ac06040-c985-4179-9ac8-3cba33baa90f
md"Now solving equations where $\mathbf{u} \otimes \mathbf{w}$ and $\mathbf{w} \otimes \mathbf{u}$:"

# ╔═╡ dac69afb-e6fb-444a-8120-fb4ccfc20f45
sol1 = solve(eq1,dict=true);

# ╔═╡ bad52ad4-9068-45a9-822f-4e7a8334df68
md"""

$ $(sympy.latex(sympy.Matrix(collect(keys(sol1[1]))))) = $(sympy.latex(sympy.Matrix(collect(values(sol1[1]))))) $

"""

# ╔═╡ 2dbe87ee-712d-443d-b861-320368719a9c
sol2 = solve(eq2,dict=true);

# ╔═╡ 591f2021-011f-4eeb-ae55-eb9f2a7da6f2
md"""
There are no solutions set to `sol2`.
"""

# ╔═╡ Cell order:
# ╟─dbb6ec82-9c0b-11eb-28bd-e9afc91a9bbf
# ╟─53613aa0-6fd8-4eb1-864f-b84f5b2d30f5
# ╠═b992e62c-defb-46cd-8f8e-df4bdf9dbe93
# ╠═d5a376f6-a528-474c-b879-5cda82e6ad89
# ╠═326beaf4-d90c-43f4-be6a-eb6e851e78af
# ╠═0c6318ba-0ec1-41d4-b1f4-73757c767a21
# ╠═2369a8ff-28ec-466b-abd1-165afaabab79
# ╟─7ac06040-c985-4179-9ac8-3cba33baa90f
# ╠═dac69afb-e6fb-444a-8120-fb4ccfc20f45
# ╟─bad52ad4-9068-45a9-822f-4e7a8334df68
# ╠═2dbe87ee-712d-443d-b861-320368719a9c
# ╟─591f2021-011f-4eeb-ae55-eb9f2a7da6f2
