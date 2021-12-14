module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah );
    reg walk_temp[1:0];
    initial begin
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
        walk_temp[0] = walk_left;
        walk_temp[1] = walk_right;
    end
    always @(posedge clk) begin
        if(areset)begin
            walk_left=1;
            walk_right=0;
        end
        else begin
            if(ground==0) begin
                if(aaah == 0) begin
                    walk_temp[0] = walk_left;
                    walk_temp[1] = walk_right; 
                    aaah = 1;
                end
                walk_left = 0;
                walk_right = 0;
            end
            else begin
                if(aaah == 1) begin
                    walk_left = walk_temp[0];
                    walk_right = walk_temp[1]; 
                    aaah = 0;
                end
                else begin
                    if(walk_left) begin
                        if(bump_left) begin
                            walk_left = 0;
                            walk_right = 1;
                        end
                    end
                    else begin
                        if(bump_right) begin
                            walk_left = 1;
                            walk_right = 0;
                        end
                    end
                end
            end
        end
    end
endmodule
