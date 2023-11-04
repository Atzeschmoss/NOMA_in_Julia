

module NOMA_InfTheo
using FFTW
# using PyPlot
using Measures
using PlotlyJS


# using Plots
# plotlyjs()
# plotly()
# pyplot()

export visualise_SISO_NOMA_user_rates

    # this function visualises the rate region of the two user SISO-NOMA Broadcast channel (BCH)
    function visualise_SISO_NOMA_user_rates() 
        # channel
        h1 = 200;
        h2 = 1;

        # noise covariance
        sigma_sq = 1;

        # distance between samples
        dist = 0.0001;
        num_el::Int64 = round((1/dist));
        B = 1;

        # total power
        P = 5;
        orthoray = -1*ones(2,num_el-1);
        for a = dist:dist:1-dist
            P1 = P;
            P2 = P;
            R1 = a*B*log2(1 + (P1 * h1) / sigma_sq);
            R2 = (1-a)*B*log2(1 + (P2 * h2) / (sigma_sq));
            b::Int64 = round((a*num_el));
            orthoray[1,b] = R1;
            orthoray[2,b] = R2;
        end
        ortho_sum_rate = orthoray[1,:] + orthoray[2,:];



        # Non-orthogonal case: Decode M1 first on both users
        # user 2 does SIC
        u1_SIC_ray = -1*ones(2,num_el-1);
        for a = dist:dist:1-dist
            P1 = a*P;
            P2 = (1-a)*P;
            R1 = B*log2(1 + (P1 * h1) / ((P2 * h1)+sigma_sq));
            R2 = B*log2(1 + (P2 * h2) / (sigma_sq));

            b::Int64 = round((a*num_el));
            u1_SIC_ray[1,b] = R1;
            u1_SIC_ray[2,b] = R2;
        end

        u1_SIC_sum_rate = u1_SIC_ray[1,:] + u1_SIC_ray[2,:];
        println("Started 1.st subplot")


        # Non-orthogonal case: Decode M2 first on both users
        # user 1 does SIC
        u2_SIC_ray = -1*ones(2,num_el-1);
        for a = dist:dist:1-dist
            P1 = a*P;
            P2 = (1-a)*P;
            R1 = B*log2(1 + (P1 * h1) / sigma_sq);
            R2 = B*log2(1 + (P2 * h2) / ((P1 * h2)*sigma_sq));

            b::Int64 = round((a*num_el));
            u2_SIC_ray[1,b] = R1;
            u2_SIC_ray[2,b] = R2;
        end

        u2_SIC_sum_rate = u2_SIC_ray[1,:] + u2_SIC_ray[2,:];

        layout_plot = Layout(
            xaxis_title="R1 [bits/s]",
            yaxis_title="R2 [bits/s]",
            title = "|h1| = $(h1/h2)*|h2|"
        )
        orthogonal_access_plot = scatter(
            x=orthoray[1,:],y=orthoray[2,:],
            name="OMA"
        )
        u1_SIC_plot = scatter(
            x=u1_SIC_ray[1,:],y=u1_SIC_ray[2,:],
            name="U1 SIC"
        )
        u2_SIC_plot = scatter(
            x=u2_SIC_ray[1,:],y=u2_SIC_ray[2,:],
            name="U2 SIC"
        )
        p1 = plot([orthogonal_access_plot, u1_SIC_plot, u2_SIC_plot], 
            layout_plot,
        )
        println("Finished 1.st subplot")

        # #---------------------- INVERT CHANNELS -------------------------------------
        temp = h2        
        h2 = h1;
        h1 = temp;

        orthoray = -1*ones(2,num_el-1);
        for a = dist:dist:1-dist
            P1 = P;
            P2 = P;
            R1 = a*B*log2(1 + (P1 * h1) / sigma_sq);
            R2 = (1-a)*B*log2(1 + (P2 * h2) / (sigma_sq));
            b::Int64 = round((a*num_el));
            orthoray[1,b] = R1;
            orthoray[2,b] = R2;
        end
        ortho_sum_rate = orthoray[1,:] + orthoray[2,:];


        # Non-orthogonal case: Decode M1 first on both users
        # user 2 does SIC
        u1_SIC_ray = -1*ones(2,num_el-1);
        for a = dist:dist:1-dist
            P1 = a*P;
            P2 = (1-a)*P;
            R1 = B*log2(1 + (P1 * h1) / ((P2 * h1)+sigma_sq));
            R2 = B*log2(1 + (P2 * h2) / (sigma_sq));

            b::Int64 = round((a*num_el));
            u1_SIC_ray[1,b] = R1;
            u1_SIC_ray[2,b] = R2;
        end

        u1_SIC_sum_rate = u1_SIC_ray[1,:] + u1_SIC_ray[2,:];


        # Non-orthogonal case: Decode M2 first on both users
        # user 1 does SIC
        u2_SIC_ray = -1*ones(2,num_el-1);
        for a = dist:dist:1-dist
            P1 = a*P;
            P2 = (1-a)*P;
            R1 = B*log2(1 + (P1 * h1) / sigma_sq);
            R2 = B*log2(1 + (P2 * h2) / ((P1 * h2)*sigma_sq));

            b::Int64 = round((a*num_el));
            u2_SIC_ray[1,b] = R1;
            u2_SIC_ray[2,b] = R2;
        end

        u2_SIC_sum_rate = u2_SIC_ray[1,:] + u2_SIC_ray[2,:];
        println("Started 2.nd subplot")

        layout_plot= Layout(
            xaxis_title="R1 [bits/s]",
            yaxis_title="R2 [bits/s]",
            title = "|h1| = $(h1/h2)*|h2|"
        )

        orthogonal_access_plot = scatter(
            x=orthoray[1,:],y=orthoray[2,:],
            name="OMA"
        )
        u1_SIC_plot = scatter(
            x=u1_SIC_ray[1,:],y=u1_SIC_ray[2,:],
            name="U1 SIC"
        )
        u2_SIC_plot = scatter(
            x=u2_SIC_ray[1,:],y=u2_SIC_ray[2,:],
            name="U2 SIC"
        )

        p2 = plot([orthogonal_access_plot, u1_SIC_plot, u2_SIC_plot], 
            layout_plot
        )

        println("Finished 2.nd subplot")

        p = [p1; p2]
        relayout!(p, 
            title_text="NOMA User rates",
            template=templates.plotly_dark,
            margin=attr(r=30, t=80, b=40, l=30),
        )
        display(p)

    end
end