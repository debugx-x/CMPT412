function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.
    data = reshape(input.data(:,:),input.height,input.width,input.channel,input.batch_size);
    out = zeros(h_out,w_out,c,batch_size);
    rows = 1:stride:h_in;
    cols = 1:stride:w_in;
    
    for batch=1:batch_size
        for ch=1:c
            for i=1:length(rows)
                for j=1:length(cols)                
                    pool = (data(rows(i):rows(i) + k-1,cols(j):cols(j) + k-1,ch,batch));
                    out(i,j,ch,batch) = max(max(pool));
                end
            end
        end
    end
    output.data = reshape(out,h_out*w_out*c,batch_size);
end