@generated function evaluate{N}(itp::AbstractInterpolation, point::SVector{N})
    Expr(:ref, :itp, [:(point[$i]) for i in 1:N]...)
end

function evaluate(itp::AbstractInterpolation, point::AbstractArray)
    itp[point...]
end

function evaluate{D <: AbstractInterpolation}(cell::Cell{D}, point::AbstractArray)
    leaf = findleaf(cell, point)
    evaluate(leaf.data, leaf.boundary, point)
end

function evaluate(interp::AbstractInterpolation, boundary::HyperRectangle, point::AbstractArray)
    coords = (point - boundary.origin) ./ boundary.widths + 1
    evaluate(interp, coords)
end
