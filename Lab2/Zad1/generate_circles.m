function [rand_counts, counts_mean, circle_areas, circles, a, b, r_max] = generate_circles(n_max)

a = randi([150,250]);
b = randi([50, 100]);
r_max = randi([20, 50]);
circles = zeros(n_max, 3);
circle_areas = [];
rand_counts = [];
counts_mean = [];
i = 1;

flag = false;
rands_num = 1;


while true
    if flag
        break;
    end

    R = randi([1, r_max]);
    X = randi([0, a]);
    Y = randi([0, b]);
    
    

    if X - R < 0 || X + R > a || Y - R < 0 || Y + R > b
        
        
        continue % check if circle is outside the boundary of the rect
    end
    
    
    
    j = 1;
    in_flag = false;
    

    while true 
        if in_flag || isempty(circles)
            break;
        end
        
        % check if circle intersects with other circle
        x = circles(j, 1);
        y = circles(j, 2);
        r = circles(j, 3);
        
        distance = sqrt((x - X)^2 + (y - Y)^2); 
        
        if distance <= r + R
            break;
        end

        j = j + 1;
        if j >= height(circles)
            in_flag = true;
        end
    end    
    % if not add a new row to circles array
    %circles = [circles; [X, Y, R]];

   
    if in_flag
        
        
        circle_areas = [circle_areas; pi*R^2];
        circles(i, :) = [X, Y, R];
        rand_counts = [rand_counts; rands_num];
        rands_num = 1;
        i = i + 1;
    else
        rands_num = rands_num + 1;
    end
    if i >= n_max + 1
        flag = true;
    end




    

    
end

circle_areas = (cumsum(circle_areas) / (a * b)) * 100;
counts_mean = cumsum(rand_counts);

for i = 1:height(counts_mean)
    counts_mean(i) = counts_mean(i)/i;
end

counts_mean = counts_mean';
rand_counts = rand_counts';

hold on;
%plot(circle_areas);
subplot(2, 1, 1);
plot(rand_counts);
title('Round counts');
xlabel('Number of circles');
ylabel('Round counts');
subplot(2, 1, 2);
plot(counts_mean);
title('Counts mean');
xlabel('Number of circles');
ylabel('Counts mean');
hold off;
saveas(gcf, 'zadanie2.png');


end
 