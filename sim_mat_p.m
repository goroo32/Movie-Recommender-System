function [sim_p] = sim_mat_p(R)
%Pearson Similarity Matrix - Summary of this function goes here
% Imput R is the Rating Matrix from Users
% Output sim_p is the Pearson similarity matrix

%%Pearson correlation-based similarity%%
% R = Y;
m = size(R,1); %# of movies
sim_p = zeros(m); %10 movies

% meanR = R;
% meanR(meanR==0) = NaN;
% R_k = nanmean(meanR,2);

% num = zeros(m);
% den = zeros(m);
for k=1:size(sim_p,1)
    for l=1:size(sim_p,2)
        ind1 = find(R(k,:)>0);
        ind2 = find(R(l,:)>0);
        ind = ismember(ind1,ind2);
        R_k = mean(R(k,ind1(ind)));
        R_l = mean(R(l,ind1(ind)));
        num = nansum((R(k,ind1(ind))-R_k).*(R(l,ind1(ind))-R_l));
        den_1 = nansum((R(k,ind1(ind)) - R_k).^2);
        den_2 = nansum((R(l,ind1(ind)) - R_l).^2);
%         den_1 = 0;
%         den_2 = 0;
%         for u = 1:size(R,2)
%             den_1 = den_1 + (R(k,u)-R_k(k))^2;
%             den_2 = den_2 + (R(l,u) - R_k(l))^2;
%         end
        den = sqrt(den_1)*sqrt(den_2);
        if isnan(num/den)
            sim_p(k,l) = 0;
        else
            sim_p(k,l) = num/den;
        end
    end
    disp(['k = ',num2str(k)])
end


end

