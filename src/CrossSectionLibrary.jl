module CrossSectionLibrary

using CrossSectionGeometry


function pipe(D, t, num_segments)

    # num_segments = 100
    # circumference = 2*π*D/2
    # segments = fill(circumference/num_segments, num_segments-1)
    # θ = range(0.0, 2π, num_segments)[1:end-1]
    # n = ones(Int, num_segments-1)


    # num_segments = 100
    θc = range(0, 2π, num_segments)
    x = D/2 * cos.(θc)
    y = D/2 * sin.(θc)
    

    segments = [norm([x[i+1]-x[i], y[i+1]-y[i]]) for i=1:length(x)-1] 
    θ = [atan((y[i+1]-y[i]), (x[i+1]-x[i])) for i=1:length(x)-1]
    n = ones(Int, num_segments-1)

    section_geometry = CrossSectionGeometry.create_thin_walled_cross_section_geometry(segments, θ, n, t, centerline = "to left", offset = (D, D/2))

    x = [section_geometry.centerline_node_XY[i][1] for i in eachindex(section_geometry.centerline_node_XY)]
    y = [section_geometry.centerline_node_XY[i][2] for i in eachindex(section_geometry.centerline_node_XY)]

    geometry = (coordinates = section_geometry, x=x, y=y)

    return geometry

end

end # module CrossSectionLibrary
