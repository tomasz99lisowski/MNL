function plot_circles(circles, a, b)
    axis equal
    axis([0 a 0 b])
    hold on
    for i = 1:height(circles)
        plot_circle(circles(i, 1), circles(i, 2), circles(i, 3))
      
    end
    hold off
    saveas(gcf, 'circles.png');
end