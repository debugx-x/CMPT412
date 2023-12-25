function [input_od] = relu_backward(output, input, layer)

% Replace the following line with your implementation.
if input.data < 0
    input_od = output.diff .* 0;
else
    input_od = output.diff .* 1;
end
