function g = sigmoid(z)

% SIGMOID Compute sigmoid functoon

%   J = SIGMOID(z) computes the sigmoid of z.

  g = zeros(size(z));
  [a b] = size(z);
% Instructions: Compute the sigmoid of each value of z (z can be a matrix,
% vector or scalar).
  for i =1:a
    for j=1:b
     g(i,j) = 1/(1+exp(-z(i,j)));
    end
  end
end
