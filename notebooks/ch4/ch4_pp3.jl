### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 81bf3510-7ed8-11eb-385a-27fa25aa447c
begin
	using SymPy
	using Plots
	pyplot()
end;

# ╔═╡ b4c3a460-7ed5-11eb-1304-c9e3f481b96c
md"""
**Problem 3.** Consider a set of vectors $\set{S}$ in a Hilbert space $\mathbb{C}^n$. Let $\mathbf{u} \in \set{S}$. A function $f(\mathbf{u})$ that maps $\set{S}$ to $\mathbb{R}$ is called a generalized probability measure when the following conditions two conditions are held:

1. $ \mathbf{u} \in \set{S} : 0 \leq f(\mathbf{u}) \leq 1 $

2. Then $\mathbf{u}_1,\cdots,\mathbf{u}_n$ forms an orthonormal basis in $\mathbb{C}^n $. Then it follows that $\sum^n_{i=1} f(\mathbb{u_i})= 1$.

If we take $n\leq 3$, then the probability measure of $f$ over $\mathbb{C}^n$ has the form:

$ f(\rho) = \text{tr}(\rho\mathbf{u}\mathbf{u}^{\dagger}) $

1. a Find the $f(\mathbf{u}_1),\cdots,f(\mathbf{u}_3)$ given the $\mathbb{C}^3$ with orthonormal basis and density matrix: 
$\mathbf{u_1} = \frac{1}{\sqrt{2}}\begin{pmatrix} 1 \\ 0 \\ 1 \end{pmatrix} \hskip{3mm} \mathbf{u_2} = \begin{pmatrix} 0 \\ 1 \\ 0 \end{pmatrix} \hskip{3mm} \mathbf{u_3} = \frac{1}{\sqrt{2}}\begin{pmatrix} 1 \\ 0 \\ -1 \end{pmatrix},$
$\rho=\frac{1}{3}\begin{pmatrix} 1 & 1 & 1 \\
1 & 1 & 1 \\
1 & 1 & 1 
\end{pmatrix}$

2. Do the same but consider Hilbert space $\mathbb{C}^4$ with orthonormal basis and density matrix:

$\mathbf{u_1} = \frac{1}{\sqrt{2}}\begin{pmatrix} e^{i\phi} \\ 0 \\  0 \\ e^{i\phi}\end{pmatrix} \hskip{3mm} \mathbf{u_2} = \begin{pmatrix} e^{i\phi} \\ 0 \\ 0 \\ e^{-i\phi}\end{pmatrix} \hskip{3mm} \mathbf{u_3} = \frac{1}{\sqrt{2}}\begin{pmatrix} 0 \\ e^{i\phi} \\ e^{i\phi} \\ 0\end{pmatrix}\hskip{3mm}\mathbf{u_4} = \frac{1}{\sqrt{2}}\begin{pmatrix} 0 \\ e^{i\phi} \\  e^{-i\phi} \\0 \end{pmatrix}$
$\rho=\frac{1}{4}\begin{pmatrix} 1 & 1 & 1 & 1\\
1 & 1 & 1 & 1\\
1 & 1 & 1 & 1 \\
1 & 1 & 1 & 1 
\end{pmatrix}$

"""

# ╔═╡ 782e7f6a-7ed8-11eb-27ee-11f2f24d49f1
md"**Solution 3.**"

# ╔═╡ bacf374a-7ed8-11eb-134d-77c4c20b70fb
begin
	𝑖,𝑒,π,ϕ = sympy.I, sympy.E, sympy.pi,sympy.symbols("ϕ",real=true)
	halfsqrt = 1/sympy.sqrt(2)
	𝚝𝚛(X) = sympy.trace(X)
	dagger(X) = sympy.adjoint(X)
	⋅(a::T,X) where T<:Number = a*X
	⋅(X,Y) = sympy.MatMul(X,Y,evaluate=true)
end;

# ╔═╡ 8ccb4228-7ed8-11eb-2da6-710ac5472bdc
begin
	𝐮₁ = halfsqrt ⋅ [1;
			         0;
			         1]
	𝐮₂ = halfsqrt ⋅ [0;
		             1;
		             0]
	𝐮₃ = halfsqrt ⋅ [1;
		             0;
		            -1]
	ρ = 1/3⋅ ones(Sym,3,3)
end;

# ╔═╡ 122784de-7ed9-11eb-1984-c5b6c5ae80c6
"""
	evaluate generalized probability measure. Gleason 1957
"""
function f(ρ::Array{Sym},𝐮ᵢ::Array{Sym})
	ρᵢ = 𝐮ᵢ ⋅ dagger(𝐮ᵢ);
	return 𝚝𝚛(ρ⋅ρᵢ)
end;

# ╔═╡ 2766fa8a-8093-11eb-3a30-6516adf7b4bd
md""" Evaluating the function $f(\rho,\mathbf{u})$ for each orthonormal basis:

$ f(\rho,\mathbf{u}_1) = $(sympy.latex(f(ρ,𝐮₁).nsimplify())) $

$ f(\rho, \mathbf{u}_2) = $(sympy.latex(f(ρ,𝐮₂).nsimplify())) $

$ f(\rho, \mathbf{u}_3) = $(sympy.latex(f(ρ,𝐮₃).nsimplify())) $
"""

# ╔═╡ fe344456-8099-11eb-2c8b-9be67c2fdd36
md"Now calculating the same for a Hilbert space of $\mathbb{C}^4$ as described in the problem statement."

# ╔═╡ 0093a680-7ed9-11eb-3578-b940519bb011
begin
	𝐯₁ = halfsqrt ⋅ [𝑒^(𝑖⋅ϕ);
			         0;
			         0;
		             𝑒^(𝑖⋅ϕ)]
	𝐯₂ = halfsqrt ⋅ [𝑒^(𝑖⋅ϕ);
		             0;
		             0;
	                 𝑒^(-𝑖⋅ϕ)];
	𝐯₃ = halfsqrt ⋅ [0;
		             𝑒^(𝑖⋅ϕ);
		             𝑒^(𝑖⋅ϕ);
	                 0];
	𝐯₄ = halfsqrt ⋅ [0;
		             𝑒^(𝑖⋅ϕ);
		             𝑒^(-𝑖⋅ϕ);
	                 0];

	𝐩 = 1/4⋅ ones(Sym,4,4)
end;


# ╔═╡ 3b7753f8-809a-11eb-19d2-67afcc373864
md""" Evaluating the function $f(\rho,\mathbf{u})$ for each of these orthonormal basis:

$ f(\rho,\mathbf{v}_1) = $(sympy.latex(f(𝐩,𝐯₁).nsimplify())) $

$ f(\rho, \mathbf{v}_2) = $(sympy.latex(f(𝐩,𝐯₂).simplify(rational=true).factor())) $

$ f(\rho, \mathbf{v}_3) = $(sympy.latex(f(𝐩,𝐯₃).nsimplify())) $

$ f(\rho, \mathbf{v}_4) = $(sympy.latex(f(𝐩,𝐯₄).simplify(rational=true).factor())) $

"""

# ╔═╡ 85c491a2-809b-11eb-2af4-1913ed95f020
md"""Interestingly we see that in this orthonormal basis set there is a dependence on $\phi$"""

# ╔═╡ 8ef9b162-809b-11eb-29a1-2134cf094302
ϕ⃗ = range(0,stop=pi,length=100);

# ╔═╡ 6643b574-809d-11eb-2ea9-cb6d3c0969d3
begin
	g = f(𝐩,𝐯₂).simplify();
	plot(ϕ′->ϕ′,ϕ′->g(ϕ=>ϕ′),ϕ⃗,
               xlabel="ϕ",ylabel="v₂(ϕ)",
               size=(300,200),legend=false,
		       annotate=(pi/2,0.4,text("f(ρ,v₂)→v₂(ϕ)",10)),
               xticks=([pi*i/4 for i=0:4],[π*i/4 for i=0:4]))
end

# ╔═╡ Cell order:
# ╟─b4c3a460-7ed5-11eb-1304-c9e3f481b96c
# ╟─782e7f6a-7ed8-11eb-27ee-11f2f24d49f1
# ╠═81bf3510-7ed8-11eb-385a-27fa25aa447c
# ╠═bacf374a-7ed8-11eb-134d-77c4c20b70fb
# ╠═8ccb4228-7ed8-11eb-2da6-710ac5472bdc
# ╠═122784de-7ed9-11eb-1984-c5b6c5ae80c6
# ╟─2766fa8a-8093-11eb-3a30-6516adf7b4bd
# ╟─fe344456-8099-11eb-2c8b-9be67c2fdd36
# ╠═0093a680-7ed9-11eb-3578-b940519bb011
# ╟─3b7753f8-809a-11eb-19d2-67afcc373864
# ╟─85c491a2-809b-11eb-2af4-1913ed95f020
# ╠═8ef9b162-809b-11eb-29a1-2134cf094302
# ╠═6643b574-809d-11eb-2ea9-cb6d3c0969d3
