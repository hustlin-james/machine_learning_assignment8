filename = 'pendigits_training';
X = dlmread(filename);

%Remove the last column since thats the target class
X = X(:,1:end-1);

N = size(X,1);
M = 1;
Iterations = 10;

CellX = cell(N,M);
UCell = cell(M,1);

for n = 1:N
    CellX{n,1} = X(n,:);
end

for d = 1:M
    temp = [];
   
    for i = 1:N
       temp = [temp; CellX{i,d}];
    end
    
    S = cov(temp);
    u = eigen_vector(S,Iterations);
    u = u/norm(u,2);
    UCell{d,1} = u;
   
    for n = 1:N
        c = CellX{n,d};
        CellX{n,d+1} = c - transpose(u*c*u);
    end
end


