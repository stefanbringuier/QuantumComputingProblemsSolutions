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

# ╔═╡ 86bbd6ee-7496-11eb-2f52-8907ca651b93
begin
	using SymPy
	using Plots
	pyplot()
end;

# ╔═╡ 9274a182-7496-11eb-184c-791f2612889b
md"
**Problem 2.** Consider Pauli spin matrix $\sigma_x$ and the normalized state in $\mathbb{C} ^2$:

$\ket{\psi} = \begin{pmatrix} \cos{\theta} \\ \sin{\theta} \end{pmatrix}$.

Calculate the *variance* 

$V_{\sigma_x} := \langle \sigma_x^2\rangle - \langle \sigma_x \rangle^2$

$\langle \sigma_x \rangle = \bra{\psi} \sigma_x \ket{\psi}$

$\sigma_x = \sigma_x^{\dagger}$

$\sigma_x^\dagger \sigma_x = \sigma_x^2 = \mathbf{I}$

$\begin{align} \therefore V_{\sigma_x} &= \bra{\psi} \sigma_x^2 \ket{\psi} - \left(\bra{\psi} \sigma_x \ket{\psi}\right)^2 \\ &= \langle \psi | \psi \rangle - \left(\bra{\psi} \sigma_x \ket{\psi}\right)^2 \end{align}$

and discuss the dependence on $\theta$.
"

# ╔═╡ 6ee996e8-7499-11eb-0da1-29f8ed388fd7
md"**Solution 2.**"

# ╔═╡ dc81d58c-749c-11eb-3559-8f193c60eb43
begin
	π,𝑖 = sympy.symbols("π 𝑖")
	⋅ = *
end;

# ╔═╡ ba68ed6a-749b-11eb-19c9-95a95111b3ad
begin
	θ = sympy.symbols("θ",real=true)
	b₀ = sympy.Matrix([1;
		               0])
	b₁ = sympy.Matrix([0;
		               1])
end;

# ╔═╡ d78b7446-7499-11eb-11ee-3dd1913268fb
md"
The key thing to note for this problem is that the variance is strictly captureed by dependence of the state on $\theta$ because $\sigma_x$ is both hermitian and unitary as shown below:"

# ╔═╡ c9ffe37e-749a-11eb-2146-69ac764f6e55
begin
	σₓ = sympy.Matrix([0 1; 1 0]);
end;

# ╔═╡ eddb52d8-749a-11eb-0a78-27a696aa6c57
adjoint(σₓ)*σₓ

# ╔═╡ 08d63cb4-749c-11eb-2283-f5ccd037befb
begin
	ψ = cos(θ) * b₀ + sin(θ) * b₁
	ψᵀ = ψ.adjoint()
end;

# ╔═╡ 99a641dc-749c-11eb-1f1b-7d492b3a45fa
V = (ψᵀ ⋅ σₓ⋅σₓ ⋅ ψ) - (ψᵀ ⋅ σₓ ⋅ ψ)^2;

# ╔═╡ 2710d5c8-74a0-11eb-3a68-a1eb5ec12127
md"
The variance is then give by the expression:

$ V= $(sympy.latex(sympy.expand_trig(sympy.trigsimp(V[1])))) $
"

# ╔═╡ 1567cd5a-7530-11eb-2ffb-5776a7eb02e1
md"
Plotting the expression above we can inspect the variance dependence on θ.
"

# ╔═╡ 55a01320-749d-11eb-165d-196c4c877f02
θ⃗ = range(0,stop=pi,length=100);

# ╔═╡ c89118e8-749d-11eb-2d38-0f452f4b6cbe
plot(theta->theta,theta->V[1](θ => theta),θ⃗,
	           xlabel="θ",ylabel="Variance",
	           size=(300,200),legend=false,
               xticks=([pi*i/4 for i=0:4],[π*i/4 for i=0:4]))

# ╔═╡ c1e27fbe-752e-11eb-3e92-f91c5b2c4221
md"
We can also differentiate $V(\theta)$ with respect to theta and find the roots at 0.
"

# ╔═╡ 5fa7f2fa-7530-11eb-190f-fdfae44d482f
dV_dθ = sympy.solve(V[1],θ);

# ╔═╡ 0d5f2a1c-754a-11eb-388c-73fce78f2f41
begin
	rootrange="<input type='range' step=1 min=1 max=$(length(dV_dθ))>"
	root = @bind rootid HTML(rootrange)
end

# ╔═╡ d0b049e2-7545-11eb-0b7f-a5091e350aba
md"""
roots $(join(1:rootid,",")) value are $ $(sympy.latex(dV_dθ[1:rootid]')) $
"""

# ╔═╡ Cell order:
# ╟─9274a182-7496-11eb-184c-791f2612889b
# ╟─6ee996e8-7499-11eb-0da1-29f8ed388fd7
# ╠═86bbd6ee-7496-11eb-2f52-8907ca651b93
# ╠═dc81d58c-749c-11eb-3559-8f193c60eb43
# ╠═ba68ed6a-749b-11eb-19c9-95a95111b3ad
# ╟─d78b7446-7499-11eb-11ee-3dd1913268fb
# ╠═c9ffe37e-749a-11eb-2146-69ac764f6e55
# ╠═eddb52d8-749a-11eb-0a78-27a696aa6c57
# ╠═08d63cb4-749c-11eb-2283-f5ccd037befb
# ╠═99a641dc-749c-11eb-1f1b-7d492b3a45fa
# ╟─2710d5c8-74a0-11eb-3a68-a1eb5ec12127
# ╟─1567cd5a-7530-11eb-2ffb-5776a7eb02e1
# ╠═55a01320-749d-11eb-165d-196c4c877f02
# ╠═c89118e8-749d-11eb-2d38-0f452f4b6cbe
# ╟─c1e27fbe-752e-11eb-3e92-f91c5b2c4221
# ╠═5fa7f2fa-7530-11eb-190f-fdfae44d482f
# ╟─0d5f2a1c-754a-11eb-388c-73fce78f2f41
# ╟─d0b049e2-7545-11eb-0b7f-a5091e350aba
