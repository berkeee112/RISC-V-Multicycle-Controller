module aludec(
    input  logic       opb5,
    input  logic [2:0] funct3,
    input  logic       funct7b5,
    input  logic [1:0] aluop,
    output logic [2:0] alucontrol
);

    logic rtypesub;

    assign rtypesub = funct7b5 & opb5;

    always_comb begin
        case (aluop)
            2'b00: alucontrol = 3'b010; // add
            2'b01: alucontrol = 3'b110; // sub
            default: begin
                case (funct3)
                    3'b000: alucontrol = rtypesub ? 3'b110 : 3'b010; // sub / add-addi
                    3'b010: alucontrol = 3'b111; // slt
                    3'b110: alucontrol = 3'b001; // or
                    3'b111: alucontrol = 3'b000; // and
                    default: alucontrol = 3'b010;
                endcase
            end
        endcase
    end

endmodule