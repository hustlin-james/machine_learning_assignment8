function [] = pca_power(training_file,test_file,M,Iterations)
    X = dlmread(training_file);

    %Remove the last column since thats the target class
    X = X(:,1:end-1);

    N = size(X,1);

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
    
    for m = 1:M
        u = UCell{m,1};
        fprintf('Eigenvector %d\n',m)
        for i = 1:size(u,1)
            fprintf('%d: %.4f\n',i,u(i))
        end
        
    end
    
    X = dlmread(test_file);
    %Remove the last column since thats the target class
    X = X(:,1:end-1);
    
    for n = 1:size(X,1)
        fprintf('Test object %d\n',(n-1))
        for m = 1:M
            Val = X(n,:)*UCell{m,1};
            fprintf('%d: %.4f\n',m,Val(1))
        end
    end
    
end

