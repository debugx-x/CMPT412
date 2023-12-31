function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

% Replace the following lines with your implementation.
for i = 1:input.batch_size
    param_grad.b = param_grad.b + (output.diff(:,i)).';
end
param_grad.w = output.diff'*input.data;

input_od = param.w * output.diff;

end