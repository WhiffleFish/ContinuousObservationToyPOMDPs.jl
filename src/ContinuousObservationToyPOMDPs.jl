module ContinuousObservationToyPOMDPs

using POMDPs
using POMDPTools
using Parameters
using Random
using QMDP
using ParticleFilters
using StaticArrays
using Statistics
using Distributions
using Base.Iterators

export
    SimpleLightDark,
    DSimpleLightDark,
    LDHeuristic,
    LDHSolver,
    LDSide,
    LDSidePolicy

include("simple_lightdark.jl")

export
    COTigerPOMDP,
    DOTigerPOMDP,
    TimedCOTigerPOMDP,
    TimedDOTigerPOMDP

include("tiger.jl")

end # module
