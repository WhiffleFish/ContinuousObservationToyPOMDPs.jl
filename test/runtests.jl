using Test
using ContinuousObservationToyPOMDPs
using ParticleFilters
using QMDP
using POMDPs
using POMDPTools

sld = SimpleLightDark()
@test isterminal(sld, sld.radius+1)
p = solve(LDHSolver(), sld)
filter = SIRParticleFilter(sld, 1000)
for (s, b, a, r, sp, o) in stepthrough(sld, p, filter, "s,b,a,r,sp,o", max_steps=10)
    @show (s, a, r, sp, o)
    @show mean(b)
end

qp = solve(QMDPSolver(), sld)
for (s, b, a, r, sp, o) in stepthrough(sld, qp, "s,b,a,r,sp,o", max_steps=10)
    @show (s, a, r, sp, o)
    @show b
end

m = COTigerPOMDP()
qp = solve(QMDPSolver(), m)
for (s, b, a, r, sp, o, t) in stepthrough(m, qp, "s,b,a,r,sp,o,t", max_steps=100)
    @show (t=t, s=s, a=a, r=r, sp=sp, o=o)
    @show collect(s=>pdf(b, s) for s in support(b))
end

m = TimedCOTigerPOMDP()
qp = solve(QMDPSolver(), m)
steps = collect(stepthrough(m, qp, "s,b,a,r,sp,o,t", max_steps=100))
@test length(steps) <= ContinuousObservationToyPOMDPs.horizon(m)
for (s, b, a, r, sp, o, t) in stepthrough(m, qp, "s,b,a,r,sp,o,t", max_steps=100)
    @show (t=t, s=s, a=a, r=r, sp=sp, o=o)
end

m = TimedDOTigerPOMDP()
qp = solve(QMDPSolver(), m)
steps = collect(stepthrough(m, qp, "s,b,a,r,sp,o,t", max_steps=100))
@test length(steps) <= ContinuousObservationToyPOMDPs.horizon(m)
for (s, b, a, r, sp, o, t) in stepthrough(m, qp, "s,b,a,r,sp,o,t", max_steps=100)
    @show (t=t, s=s, a=a, r=r, sp=sp, o=o)
end

has_consistent_transition_distributions(COTigerPOMDP())
has_consistent_distributions(DOTigerPOMDP())
# these don't work for problems with terminal states like this :'(
has_consistent_transition_distributions(TimedCOTigerPOMDP())
has_consistent_distributions(TimedDOTigerPOMDP())
