load('data.mat', 'data');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Fig. 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('color', 'w', 'NumberTitle', 'off', 'name', 'Fig. 1'); pause(0.1); jf = get(handle(gcf),'javaframe'); jf.setMaximized(1); pause(0.5);
FontSize = 20;

%%% A
subplot(6, 5, [1:2 6:7]);
imshow(data.Fig1.A.img, 'XData', data.Fig1.A.imgXLim, 'YData', data.Fig1.A.imgYLim); hold on;
plot([data.Fig1.A.x1 data.Fig1.A.x2], [data.Fig1.A.y1 data.Fig1.A.y2], 'y', 'LineWidth', 2);
plot([data.Fig1.A.x1(end) data.Fig1.A.x2(1)], [data.Fig1.A.y1(end) data.Fig1.A.y2(1)], 'k', 'LineWidth', 2);
for(iPlot = 1 : size(data.Fig1.A.retinaPos,1)+1)
    subplot(6, 12, 24+iPlot);
    k = iPlot;
    if(iPlot == 3)
        imshow(ones(data.Fig1.A.retinaPos(1,3) - data.Fig1.A.retinaPos(1,1) + 1, data.Fig1.A.retinaPos(1,4) - data.Fig1.A.retinaPos(1,2) + 1) * .5);
        text(mean(xlim), mean(ylim), 'Blink', 'color', 'w', 'FontSize', 18, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    else
        if(iPlot < 3)
            k = iPlot;
        else
            k = iPlot - 1;
        end
        imshow(data.Fig1.A.img(data.Fig1.A.retinaPos(k,1) : data.Fig1.A.retinaPos(k,3), data.Fig1.A.retinaPos(k,2) : data.Fig1.A.retinaPos(k,4), :));
    end
end
drawnow;

%%% B
% gratings with example Brownian motion
colors = {'m', [225 174 0]/255, 'c'};
for(sf = [1 3 10])
    subplot(6, 5, 3 + (find(sf==[1 3 10])-1) * 5);
    imshow(data.Fig1.B.(['grating_' num2str(sf) 'cpd']), [], 'XData', data.Fig1.B.gratingXLim, 'YData', data.Fig1.B.gratingYLim); hold on;
    plot(data.Fig1.B.BM_x, data.Fig1.B.BM_y, 'color', colors{sf == [1 3 10]}, 'LineWidth', 2);
    set(gca, 'XLim', [-30 30], 'YLim', [-30 30], 'YDir', 'normal', 'XTick', [], 'YTick', [], 'visible', 'on', 'XColor', colors{sf == [1 3 10]}, 'YColor', colors{sf == [1 3 10]}, 'LineWidth', 3, 'box', 'on');
    ylabel([num2str(sf), ' cpd'], 'FontSize', FontSize+2, 'color', 'k');
end

% example luminance profiles
subplot(14, 10, reshape((7:9)+(0:10:30)', 1, [])); hold on;
for(sf = [1 3 10])
    plot(data.Fig1.B.t, data.Fig1.B.(['luminance_' num2str(sf), 'cpd']), '-', 'color', colors{sf == [1 3 10]}, 'LineWidth', 2, 'DisplayName', [num2str(sf) ' cpd'] );
end
fill([data.Fig1.B.tClosingOn * [1 1], data.Fig1.B.tClosingOff * [1 1]], [.1 8 8 .1], 'k', 'facecolor', [.75 .75 .75], 'LineStyle', 'none');
fill([data.Fig1.B.tClosingOff * [1 1], data.Fig1.B.tOpeningOn * [1 1]], [.1 8 8 .1], 'k', 'facecolor', [.50 .50 .50], 'LineStyle', 'none');
fill([data.Fig1.B.tOpeningOn * [1 1], data.Fig1.B.tOpeningOff * [1 1]], [.1 8 8 .1], 'k', 'facecolor', [.75 .75 .75], 'LineStyle', 'none');
text(mean([data.Fig1.B.tClosingOn data.Fig1.B.tClosingOff]), 4, 'closing', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'color', [.5 .5 .5], 'rotation', 90, 'FontSize', FontSize);
text(mean([data.Fig1.B.tClosingOff data.Fig1.B.tOpeningOn]), 4, 'closing', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'color', [.0 .0 .0], 'rotation', 90, 'FontSize', FontSize);
text(mean([data.Fig1.B.tOpeningOn data.Fig1.B.tOpeningOff]), 4, 'opening', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'color', [.5 .5 .5], 'rotation', 90, 'FontSize', FontSize);
set(gca, 'XLim', data.Fig1.B.t([1 end]), 'YLim', [0 8], 'XTickLabel', [], 'YTick', 0:2:8, 'YTickLabel', {'0' '' '4' '' '8'}, 'FontSize', FontSize, 'XColor', 'k', 'YColor', 'k', 'LineWidth', 2 );
ylabel('Luminance (cd/m^2)');

% eyelid
subplot(14, 10, reshape((47:49)+(0:10:20)', 1, []));
plot(data.Fig1.B.t, data.Fig1.B.eyelid, 'k', 'LineWidth', 2);
set(gca, 'XLim', data.Fig1.B.t([1 end]), 'XTick', 0:200:1000, 'XTickLabel', {'0', '', '400', '', '800', ''}, 'YLim', [0 1], 'YTick', 0:0.25:1, 'YTickLabel', {'0', '', '0.5', '', '1'}, 'XColor', 'k', 'YColor', 'k', 'FontSize', FontSize, 'LineWidth', 2, 'box', 'off');
h = xlabel('Time (ms)');
h.Position(2) = h.Position(2) + 0.08;
ylabel('Eyelid position');

%%% C
subplot(2, 10, 11:13);
surf(data.Fig1.C.sf, data.Fig1.C.tf, data.Fig1.C.psdBlink, 'LineStyle', 'none'); hold on;
surf(data.Fig1.C.sf, data.Fig1.C.tf, data.Fig1.C.psdNoBlink, 'LineStyle', 'none');
set(gca, 'XLim', [min(data.Fig1.C.edge_x) max(data.Fig1.C.edge_x)], 'YLim', [min(data.Fig1.C.edge_y) max(data.Fig1.C.edge_y)],...
         'XTick', [0.1 1 10], 'YTick', [0.01 0.1 1 10 100],...
         'XtickLabel', {'0.1', '1', '10'}, 'YTickLabel', {'0.01', '0.1', '1', '10', '100'},...
         'XColor', 'k', 'YColor', 'k', 'XScale', 'log', 'YScale', 'log', 'view', [-49 20], 'LineWidth', 2, 'FontSize', FontSize,...
         'XGrid', 'off', 'YGrid', 'off', 'ZGrid', 'off');
xlabel('Spatial freq. (cpd)');
ylabel('Temporal freq. (Hz)');
zlabel('Power (dB)');
hAxis = gca;
hAxis.XLabel.Position = [0.1700 0.7358 -123.3613];
hAxis.YLabel.Position = [0.0343 2.2140 -121.4521];
hAxis.XLabel.Rotation = 16;
hAxis.YLabel.Rotation = -12;
plot3(xlim, [1 1]*max(ylim), [1 1]*min(zlim), '-', 'color', [.5 .5 .5], 'LineWidth', 2);
plot3([1 1]*max(xlim), ylim, [1 1]*min(zlim), '-', 'color', [.5 .5 .5], 'LineWidth', 2);
plot3([1 1]*max(xlim), [1 1]*max(ylim), zlim, '-', 'color', [.5 .5 .5], 'LineWidth', 2);
plot3(max(xlim)*[1 1], min(ylim)*[1 1], zlim, 'k-', 'LineWidth', 2);
h1 = plot3(data.Fig1.C.edge_x, data.Fig1.C.edge_y, data.Fig1.C.edgeNoBlink_z, 'b', 'LineWidth', 4, 'DisplayName', 'Drift only');
h2 = plot3(data.Fig1.C.edge_x, data.Fig1.C.edge_y, data.Fig1.C.edgeBlink_z, 'r', 'LineWidth', 4, 'DisplayName', 'Drift+Blink');
zlim(zlim);
plot3(min(xlim)*[1 1], min(ylim)*[1 1], [min(zlim) data.Fig1.C.edgeBlink_z(1)], 'k--', 'LineWidth', 2);
legend([h1 h2], 'position', [0.1216 0.3962 0.0844 0.0683]);
drawnow;

%%% D
subplot(2, 20, 29:33); hold on;
h1 = plot(data.Fig1.D.sf, data.Fig1.D.powerWeightedNoBlink, 'b', 'LineWidth', 3, 'DisplayName', 'Drift only');
h2 = plot(data.Fig1.D.sf, data.Fig1.D.powerWeightedBlink, 'r', 'LineWidth', 3, 'DisplayName', 'Drift+Blink');
plot([1 1], ylim, '--', 'color', colors{1}, 'LineWidth', 2);
plot([3 3], ylim, '--', 'color', colors{2}, 'LineWidth', 2);
plot([10 10], ylim, '--', 'color', colors{3}, 'LineWidth', 2);
set(gca, 'XLim', data.Fig1.D.sf([1 end]), 'XTick', [1 3 10], 'XTickLabel', {'1', '3', '10'}, 'XScale', 'log', 'YLim', [14.5 29], 'FontSize', FontSize, 'LineWidth', 2, 'XColor', 'k', 'YColor', 'k');
legend([h1 h2], 'Location', 'northwest');
xlabel('Spatial frequency (cpd)');
ylabel('Total power (dB)');

%%% E
subplot(16, 10, [99:100 109:110 119:120]); hold on;
plot(data.Fig1.D.sf, data.Fig1.D.powerWeightedGain, 'k', 'LineWidth', 2);
set(gca, 'XLim', data.Fig1.D.sf([1 end]), 'YLim', [-0.5 4.3], 'XTick', [1 3 10], 'XTickLabel', {'1', '3', '10'}, 'YTick', 0:2:4, 'YTickLabel', {'0' '' '4'}, 'XScale', 'log', 'FontSize', FontSize, 'LineWidth', 2, 'XColor', 'k', 'YColor', 'k');
plot(xlim, [0 0], 'k--', 'LineWidth', 2);
plot([1 1], [min(ylim) data.Fig1.D.powerWeightedGain(data.Fig1.D.sf==1)], '--', 'color', colors{1}, 'LineWidth', 2);
plot([3 3], [min(ylim) data.Fig1.D.powerWeightedGain(data.Fig1.D.sf==3)], '--', 'color', colors{2}, 'LineWidth', 2);
plot([10 10], [min(ylim) data.Fig1.D.powerWeightedGain(data.Fig1.D.sf==10)], '--', 'color', colors{3}, 'LineWidth', 3);
h = xlabel('Spat. freq. (cpd)');
h.Position(2) = h.Position(2) + 0.5;
ylabel({'Power' 'gain' '(dB)'});
subplot(16, 10, [139:140 149:150 159:160]); hold on;
plot([1 2], data.Fig1.D.powerWeightedGain(data.Fig1.D.sf==1) * [-.5 .5], 'p-', 'color', 'k', 'LineWidth', 3, 'MarkerSize', 14);
text(1.1, .3 + data.Fig1.D.powerWeightedGain(data.Fig1.D.sf==1) * -.5, 'Low', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'rotation', 33, 'FontSize', 18);
plot([1 2], data.Fig1.D.powerWeightedGain(data.Fig1.D.sf==10) * [-.5 .5], 'd-', 'color', [0.5 0.5 0.5], 'LineWidth', 3, 'MarkerSize', 14);
text(1.1, .3 + data.Fig1.D.powerWeightedGain(data.Fig1.D.sf==10) * .5, 'High', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'rotation', -3, 'FontSize', 18, 'color', [.5 .5 .5]);
set(gca, 'XLim', [0.5 2.5], 'YLim', ylim * [1.2 -0.2; -0.2 1.2], 'XTick', [1 2], 'XTickLabel', {'Drift', 'Drift+Blink'}, 'FontSize', FontSize, 'LineWidth', 2, 'XColor', 'k', 'YColor', 'k');
ylabel({'Power' 'difference' '(dB)'});

%%% panel labels
axes('position', [0 0 1 1], 'xlim', [0 1], 'YLim', [0 1], 'visible', 'off');
text(0.13, 0.9, 'A', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.47, 0.9, 'B', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.08, 0.42, 'C', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.4, 0.42, 'D', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.68, 0.40, 'E', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Fig. 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('color', 'w', 'NumberTitle', 'off', 'name', 'Fig. 2');  pause(0.1); jf = get(handle(gcf),'javaframe'); jf.setMaximized(1); pause(0.5);
%%% A
% no data in this panel

%%% B
subplot(2,3,4); hold on;
set(gca, 'XLim', [0 800], 'YLim', [0, max(data.Fig2.B.probabilityDensities(:)) * 1.1 ], 'YTick', 0:5:10, 'box', 'off', 'LineWidth', 2, 'FontSize', 20, 'XColor', 'k', 'YColor', 'k');
plot(data.Fig2.B.reactionTimes, data.Fig2.B.probabilityDensities', 'color', [.5 .5 .5], 'LineWidth', 1);
plot(data.Fig2.B.reactionTimes, mean(data.Fig2.B.probabilityDensities, 1), 'k', 'LineWidth', 2);
plot([1 1] * data.Fig2.B.meanReactionTime, ylim, 'k--', 'LineWidth', 2);
text(data.Fig2.B.meanReactionTime, max(ylim), sprintf('%.0f ms', data.Fig2.B.meanReactionTime), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 18);
xlabel('Blink reaction time (ms)');
ylabel('Blink probability (s^{-1})');

%%% C
subplot(2,3,5); hold on;
set(gca, 'XLim', [0 410], 'YLim', [0 15], 'XTick', 0:100:400, 'XTickLabel', {'0' '' '200' '' '400'}, 'LineWidth', 2, 'box', 'off', 'FontSize', 20, 'XColor', 'k', 'YColor', 'k');
plot(data.Fig2.C.durations, data.Fig2.C.probabilityDensities', 'color', [0.5 0.5 0.5], 'LineWidth', 1);
plot(data.Fig2.C.durations, mean(data.Fig2.C.probabilityDensities,1), 'k', 'LineWidth', 2);
plot([1 1]*data.Fig2.C.meanDuration, ylim, 'k--', 'LineWidth', 2);
text(data.Fig2.C.meanDuration, max(ylim), sprintf('%.0f ms', data.Fig2.C.meanDuration), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 18);
xlabel('Blink duration (ms)');
ylabel('Blink probability (s^{-1})');

%%% D
subplot(2,40,31:39); hold on;
set(gca, 'XLim', [0 4], 'YLim', [60 105], 'YTick', 60:10:100, 'LineWidth', 2, 'XTick', [1 3], 'XTickLabel', {'No-Stimulus\newline      Blink', 'Stimulus\newline   Blink'}, 'FontSize', 20, 'XColor', 'k', 'YColor', 'k');
plot([1 3], [data.Fig2.D.correctRateNoBlink; data.Fig2.D.correctRateBlink] * 100, '^--', 'MarkerSize', 8, 'LineWidth', 2, 'color', [.5 .5 .5]);
errorbar([1 3], [mean(data.Fig2.D.correctRateNoBlink), mean(data.Fig2.D.correctRateBlink)] * 100, [std(data.Fig2.D.correctRateNoBlink), std(data.Fig2.D.correctRateBlink)] * 100, 's-', 'MarkerFaceColor', 'k', 'MarkerSize', 10, 'LineWidth', 2, 'color', 'k');
plot([1 1 3 3], [103.5 105 105 103.5], 'k-', 'LineWidth', 1.5);
text(2, 104, '**', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 18);
ylabel('Proportion correct (%)');

%%% E
subplot(2,3,6); hold on;
axis equal;
set(gca, 'XLim', [0 5], 'XTick', 0:5, 'YTick', 0:5, 'YLim', [0 5], 'LineWidth', 2, 'FontSize', 20, 'XColor', 'k', 'YColor', 'k');
plot(data.Fig2.E.dPrimeNoBlink, data.Fig2.E.dPrimeBlink, '^', 'color', [.5 .5 .5], 'MarkerSize', 8, 'LineWidth', 2);
errorbar(mean(data.Fig2.E.dPrimeNoBlink), mean(data.Fig2.E.dPrimeBlink), diff(data.Fig2.E.CI)/2, 'ks', 'MarkerSize', 10, 'MarkerFaceColor', 'k', 'LineWidth', 2);
plot([0 5], [0 5], 'k--', 'LineWidth', 1);
plot([2.85 3 3 2.85], [mean(data.Fig2.E.dPrimeNoBlink)*[1 1], mean(data.Fig2.E.dPrimeBlink)*[1 1]], 'k-', 'LineWidth', 1.5);
text(3, (mean(data.Fig2.E.dPrimeNoBlink) + mean(data.Fig2.E.dPrimeBlink)) / 2, '***', 'FontSize', 18, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
xlabel('d^\prime (No-Stimulus Blink)');
ylabel('d^\prime (Stimulus Blink)');

%%% panel labels
axes('position', [0 0 1 1], 'xlim', [0 1], 'YLim', [0 1], 'visible', 'off');
text(0.09, 0.44, 'B', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.37, 0.44, 'C', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.67, 0.90, 'D', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.67, 0.44, 'E', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Fig. 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('color', 'w', 'NumberTitle', 'off', 'name', 'Fig. 3');  pause(0.1); jf = get(handle(gcf),'javaframe'); jf.setMaximized(1); pause(0.5);
%%% A
subplot(2,3,2); hold on; h = zeros(1,2);
plot(data.Fig3.A.tFreqs, data.Fig3.A.powerNoBlink_dB, 'color', [.5 .5 1], 'LineWidth', 0.5);
plot(data.Fig3.A.tFreqs, data.Fig3.A.powerBlink_dB, 'color', [1 .5 .5], 'LineWidth', 0.5);
h(1) = plot(data.Fig3.A.tFreqs, data.Fig3.A.meanPowerNoBlink_dB, '-', 'color', [0 0 0.8], 'LineWidth', 3, 'DisplayName', 'No-Stimulus Blink');
h(2) = plot(data.Fig3.A.tFreqs, data.Fig3.A.meanPowerBlink_dB, '-', 'color', [0.8 0 0], 'LineWidth', 3, 'DisplayName', 'Stimulus Blink');
plot(data.Fig3.A.tFreqs, -70*data.Fig3.A.isSignificantFreq, 'k', 'LineWidth', 4);
set( gca, 'XScale', 'log', 'YScale', 'linear', 'FontSize', 20, 'LineWidth', 2, 'xcolor', 'k', 'ycolor', 'k');
set( gca, 'XLim', [0.9 18], 'YLim', [-73 -44], 'XTick', [1  10 15], 'XTickLabel', {'1', '10', '15'}, 'YTick', -70:5:-45, 'YTickLabel', {'-70' '' '-60' '' '-50' ''});
xlabel('Temporal frequency (Hz)');
ylabel('Power (dB)');
legend(h, 'location', 'NorthEast');

%%% B
subplot(2,3,3); hold on;
plot([1 3], [data.Fig3.B.normalizedPowerNoBlink_dB; data.Fig3.B.normalizedPowerBlink_dB], '--', 'MarkerSize', 10, 'LineWidth', 2, 'color', [0.5 0.5 0.5]);
plot(1, data.Fig3.B.normalizedPowerNoBlink_dB, '^', 'MarkerSize', 10, 'LineWidth', 2, 'color', [0.5 0.5 1]);
plot(3, data.Fig3.B.normalizedPowerBlink_dB, '^', 'MarkerSize', 10, 'LineWidth', 2, 'color', [1 0.5 0.5]);
errorbar([1 3], [data.Fig3.B.meanNormalizedPowerNoBlink_dB, data.Fig3.B.meanNormalizedPowerBlink_dB], [data.Fig3.B.SEMNormalizedPowerNoBlink_dB, data.Fig3.B.SEMNormalizedPowerBlink_dB], 'ko-', 'MarkerFaceColor', 'k', 'MarkerSize', 12, 'LineWidth', 2);
plot([1 1 3 3], [0.72 0.8 0.8 0.72], 'k-', 'LineWidth', 1.5);
text(2, 0.76, '***', 'FontSize', 18, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
set(gca, 'XLim', [-0.3 4.3], 'YLim', [-.8 .8], 'xtick', [1 3], 'XTickLabel', {'No-Stimulus\newline       Blink', 'Stimulus\newline   Blink'}, 'YTick', -.8:.2:.8, 'YTickLabel', {'-0.8' '' '-0.4' '' '0' '' '0.4' '' '0.8'}, 'FontSize', 20, 'LineWidth', 2, 'XColor', 'k', 'YColor', 'k');
pos = get( gca, 'position' ); set( gca, 'position', [pos(1:2), 0.2, pos(4)] );
ylabel('Normalized power (dB)');

%%% C
subplot(2,3,5); hold on;
contour(data.Fig3.C.durations, data.Fig3.C.timeConstants, data.Fig3.C.powerGain3cpd, 100, 'fill', 'on', 'linestyle', 'none', 'LineWidth', .1);
[c, h] = contour(data.Fig3.C.durations, data.Fig3.C.timeConstants, data.Fig3.C.powerGain3cpd, 'linecolor', 'g', 'linewidth', 2, 'LevelStep', .1);
clabel(c, h, 'fontsize', 16, 'color', 'g');
colormap('hot');
hb = colorbar;
hb.Label.Color = 'k';
set(hb, 'color', 'k', 'LineWidth', 2, 'ticks', 0.7:0.05:0.95, 'TickLabels', {'0.7' '' '0.8' '' '0.9' ''});
plot(data.Fig3.C.durationInstructed, data.Fig3.C.timeConstantInstructed, 'ko', 'linewidth', 2);
text(data.Fig3.C.durationInstructed, data.Fig3.C.timeConstantInstructed, 'instr.', 'fontsize', 18, 'Color', [0 0 0], 'horizontalalignment', 'center', 'verticalalignment', 'top');
plot(data.Fig3.C.durationReflex, data.Fig3.C.timeConstantReflex, 'mo', 'linewidth', 2);
text(data.Fig3.C.durationReflex, data.Fig3.C.timeConstantReflex, 'refl.', 'fontsize', 18, 'Color', 'm', 'horizontalalignment', 'center', 'verticalalignment', 'top');
plot(data.Fig3.C.durationSpontaneous, data.Fig3.C.timeConstantSpontaneous, 'co', 'linewidth', 2);
text(data.Fig3.C.durationSpontaneous, data.Fig3.C.timeConstantSpontaneous, 'spont. ', 'fontsize', 18, 'Color', 'c', 'horizontalalignment', 'center', 'verticalalignment', 'top');
set(gca, 'XLim', [48 max(data.Fig3.C.durations)], 'XTick', 50:50:250, 'XTickLabel', {'50' '' '150' '' '250'}, 'YLim', [3.9 max(data.Fig3.C.timeConstants)], 'YTick', 4:2:18, 'YTickLabel', {'4' '' '8' '' '12' '' '16' ''}, 'XColor', 'k', 'YColor', 'k', 'FontSize', 20, 'LineWidth', 2);
xlabel('Full closure duration (ms)');
ylabel('Time constant (ms)');
title('3 cpd');

%%% D
subplot(2,3,6); hold on;
contour(data.Fig3.D.durations, data.Fig3.D.timeConstants, data.Fig3.D.powerGain1cpd, 100, 'fill', 'on', 'linestyle', 'none', 'LineWidth', .1);
[c, h] = contour(data.Fig3.D.durations, data.Fig3.D.timeConstants, data.Fig3.D.powerGain1cpd, 'linecolor', 'g', 'linewidth', 2, 'LevelStep', .1);
clabel(c, h, 'fontsize', 16, 'color', 'g');
colormap('hot');
hb = colorbar;
hb.Label.String = 'Power gain (dB)';
hb.Label.Color = 'k';
set(hb, 'color', 'k', 'LineWidth', 2, 'ticks', 1.65:0.05:1.85, 'TickLabels', {'' '1.7' '' '1.8' ''});
set(gca, 'XLim', [48 max(data.Fig3.C.durations)], 'XTick', 50:50:250, 'XTickLabel', {'50' '' '150' '' '250'}, 'YLim', [3.9 max(data.Fig3.D.timeConstants)], 'YTick', 4:2:18, 'YTickLabel', [], 'XColor', 'k', 'YColor', 'k', 'FontSize', 20, 'LineWidth', 2);
xlabel('Full closure duration (ms)');
title('1 cpd');

%%% panel labels
axes('position', [0 0 1 1], 'xlim', [0 1], 'YLim', [0 1], 'visible', 'off');
text(0.38, 0.93, 'A', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.65, 0.93, 'B', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.38, 0.45, 'C', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.65, 0.45, 'D', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Fig. 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('color', 'w', 'NumberTitle', 'off', 'name', 'Fig. 4');  pause(0.1); jf = get(handle(gcf),'javaframe'); jf.setMaximized(1); pause(0.5);
%%% A
for(iSbj = 1:2)
    subplot(4, 3, 3*iSbj-1); hold on;
    set(gca, 'XLim', [0 400], 'YLim', [0 max([data.Fig4.A.probabilityDensitiesReflexive(iSbj,:) data.Fig4.A.probabilityDensitiesInstructed(iSbj,:)]) * 1.2], 'YTick', [0 10], 'LineWidth', 2, 'box', 'off', 'FontSize', 20, 'XColor', 'k', 'YColor', 'k');
    h1 = plot(data.Fig4.A.reactionTimes, data.Fig4.A.probabilityDensitiesReflexive(iSbj,:), 'k', 'LineWidth', 2, 'DisplayName', 'reflexive');
    h2 = plot(data.Fig4.A.reactionTimes, data.Fig4.A.probabilityDensitiesInstructed(iSbj,:), 'color', [.5 .5 .5], 'LineWidth', 2, 'DisplayName', 'instructed');
    plot(data.Fig4.A.meanReactionTimesReflexive(iSbj) * [1 1], ylim, 'k--', 'LineWidth', 2);
    plot(data.Fig4.A.meanReactionTimesInstructed(iSbj) * [1 1], ylim, '--', 'color', [.5 .5 .5], 'LineWidth', 2);
    text(0, max(ylim), [' Subject' num2str(iSbj)], 'FontSize', 20, 'FontWeight', 'bold', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top');
    if(iSbj == 2)
        xlabel('Blink reaction time (ms)');
    else
        legend([h1 h2], 'position', [0.5377 0.8980 0.0812 0.0683]);
        set(gca, 'XTickLabel', []);
    end
    pos = get(gca, 'position');
    set(gca, 'position', [pos(1:3) pos(end)*1.15]);
end
ylabel( 'Blink probability (s^{-1})' );

%%% B
for(iSbj = 1:2)
    subplot(4, 3, 3*iSbj); hold on;
    set(gca, 'XLim', [0 400], 'YLim', [0 max([data.Fig4.B.probabilityDensitiesReflexive(iSbj,:) data.Fig4.B.probabilityDensitiesInstructed(iSbj,:)]) * 1.2], 'LineWidth', 2, 'box', 'off', 'FontSize', 20, 'XColor', 'k', 'YColor', 'k');
    plot(data.Fig4.B.durations, data.Fig4.B.probabilityDensitiesReflexive(iSbj,:), 'k', 'LineWidth', 2);
    plot(data.Fig4.B.durations, data.Fig4.B.probabilityDensitiesInstructed(iSbj,:), 'color', [.5 .5 .5], 'LineWidth', 2);
    plot(data.Fig4.B.meanDurationsReflexive(iSbj) * [1 1], ylim, 'k--', 'LineWidth', 2);
    plot(data.Fig4.B.meanDurationsInstructed(iSbj) * [1 1], ylim, '--', 'color', [.5 .5 .5], 'LineWidth', 2);
    text(max(xlim), max(ylim), ['Subject' num2str(iSbj)], 'FontSize', 20, 'FontWeight', 'bold', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top');
    if(iSbj == 2)
        xlabel('Blink duration (ms)');
    else
        set(gca, 'XTickLabel', []);
    end
    pos = get(gca, 'position');
    set(gca, 'position', [pos(1:3) pos(end)*1.15]);
end
ylabel( 'Blink probability (s^{-1})' );

%%% C
subplot(2,3,5); hold on; cla;
pos = get(gca, 'position');
set(gca, 'position', [pos(1) pos(2)-0.05 pos(3:4)]);
for(iSbj = 1:2)
    h1 = bar(iSbj*2-0.25, data.Fig4.C.correctRateNoBlink(iSbj)*100, 0.48, 'w', 'LineWidth', 2, 'DisplayName', 'No-Stim. Blink', 'FaceAlpha', 0.6 );
    h2 = bar(iSbj*2+0.25, data.Fig4.C.correctRateBlink(iSbj)*100, 0.48, 'FaceColor', [.5 .5 .5], 'LineWidth', 2, 'DisplayName', 'Stim. Blink', 'FaceAlpha', 0.6 );
    errorbar(iSbj*2-0.25, data.Fig4.C.correctRateNoBlink(iSbj)*100, data.Fig4.C.sdNoBlink(iSbj)*100, 'k', 'linewidth', 2);
    errorbar(iSbj*2+0.25, data.Fig4.C.correctRateBlink(iSbj)*100, data.Fig4.C.sdBlink(iSbj)*100, 'k', 'linewidth', 2);
    plot([-0.25 -0.25 0.25 0.25] + iSbj*2, [1 2 2 1] + (data.Fig4.C.correctRateBlink(iSbj)+data.Fig4.C.sdBlink(iSbj))*100, 'k-', 'LineWidth', 1.5);
    text(iSbj*2, 2 + (data.Fig4.C.correctRateBlink(iSbj)+data.Fig4.C.sdBlink(iSbj))*100, sprintf('$p=%.3f$', data.Fig4.C.pValues(iSbj)), 'FontSize', 18, 'interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end
set(gca, 'FontSize', 20, 'linewidth', 2, 'XTick', [2 4], 'XTickLabel', {'Subject 1', 'Subject 2'}, 'YLim', [50 102], 'YTick', 50:10:100, 'XColor', 'k', 'YColor', 'k');
legend([h1 h2], 'position', [0.4179 0.3719 0.1062 0.0683]);
ylabel('Proportion correct (%)');

%%% D
subplot(2,3,6); hold on;
pos = get(gca, 'position');
set(gca, 'position', [pos(1) pos(2)-0.05 pos(3:4)]);
for(iSbj = 1:2)
    h1 = bar(iSbj*2-0.25, data.Fig4.D.normalizedPowerNoBlink_dB(iSbj), 0.48, 'w', 'LineWidth', 2, 'DisplayName', 'No-Stim. Blink', 'FaceAlpha', 0.6 );
    h2 = bar(iSbj*2+0.25, data.Fig4.D.normalizedPowerBlink_dB(iSbj), 0.48, 'facecolor', [.5 .5 .5], 'LineWidth', 2, 'DisplayName', 'Stim. Blink', 'FaceAlpha', 0.6 );
    errorbar(iSbj*2-0.25, data.Fig4.D.normalizedPowerNoBlink_dB(iSbj), data.Fig4.D.sdNoBlink_dB(iSbj), 'k', 'linewidth', 2);
    errorbar(iSbj*2+0.25, data.Fig4.D.normalizedPowerBlink_dB(iSbj), data.Fig4.D.sdBlink_dB(iSbj), 'k', 'linewidth', 2);
    plot([-0.25 -0.25 0.25 0.25] + iSbj*2, [.1 .2 .2 .1] + data.Fig4.D.normalizedPowerBlink_dB(iSbj) + data.Fig4.D.sdBlink_dB(iSbj), 'k-', 'LineWidth', 1.5);
    text(iSbj*2, .2 + data.Fig4.D.normalizedPowerBlink_dB(iSbj) + data.Fig4.D.sdBlink_dB(iSbj), sprintf('$p=%.2g$', data.Fig4.D.pValues(iSbj)), 'FontSize', 18, 'interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end
ylabel('Normalized power (dB)');
set(gca, 'ylim', [-2 2.5], 'FontSize', 20, 'LineWidth', 2, 'XTick', [2 4], 'XTickLabel', {'Subject 1', 'Subject 2'}, 'XColor', 'k', 'XColor', 'k');

%%% panel labels
axes('position', [0 0 1 1], 'xlim', [0 1], 'YLim', [0 1], 'visible', 'off');
text(0.38, 0.93, 'A', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.65, 0.93, 'B', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.38, 0.41, 'C', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.65, 0.41, 'D', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Fig. 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('color', 'w', 'NumberTitle', 'off', 'name', 'Fig. 5', 'position', [183 340 1200 400]);
%%% A
subplot(1,2,1); hold on; h = zeros(1,2);
set(gca, 'YLim', [-8 22], 'FontSize', 20, 'LineWidth', 2, 'XTick', [1 3], 'XTickLabel', {'Low SF' 'High SF'}, 'YTick', -5:5:20, 'YTickLabel', {'' '0' '' '10' '' '20'}, 'XColor', 'k', 'YColor', 'k');
colors = {'w', [0.5 0.5 0.5]};
sbjNames = {'Subject X', 'Subject Y'};
for(iSF = 1:2)
    for(iSbj = 1:2)
        h(iSbj) = bar(iSF*2-1.25+(iSbj-1)*0.5, data.Fig5.A.gainCorrectRate{iSF}(iSbj)*100, 0.48, 'FaceColor', colors{iSbj}, 'LineStyle', '-', 'LineWidth', 2, 'DisplayName', sbjNames{iSbj}, 'FaceAlpha', 0.6);
        errorbar(iSF*2-1.25+(iSbj-1)*0.5, data.Fig5.A.gainCorrectRate{iSF}(iSbj)*100, data.Fig5.A.sdGain{iSF}(iSbj)*100, 'k', 'LineWidth', 2);
        if(iSbj == 1)
            text(iSF*2-1, (data.Fig5.A.gainCorrectRate{iSF}(iSbj) + data.Fig5.A.sdGain{iSF}(iSbj)) * 100 + 0.02*diff(ylim), sprintf('$p=%.3f$ ', data.Fig5.A.pValues{iSF}(iSbj)), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 18, 'interpreter', 'latex');
        else
            text(iSF*2-1.25+(iSbj-1)*0.5, (data.Fig5.A.gainCorrectRate{iSF}(iSbj) + data.Fig5.A.sdGain{iSF}(iSbj))*100 + 0.02*diff(ylim), sprintf('$p=%.3f$', data.Fig5.A.pValues{iSF}(iSbj)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 18, 'interpreter', 'latex');
        end
    end
end
legend(h);
ylabel('Gain in correct rate (%)');

%%% B
subplot(1,2,2); hold on; h =zeros(1,2);
set(gca, 'YLim', [-0.27 2.73], 'FontSize', 20, 'LineWidth', 2, 'XTick', [1 3], 'XTickLabel', {'Low SF' 'High SF'}, 'YTick', 0:.5:2.5, 'YTickLabel', {'0' '' '1' '' '2' ''}, 'XColor', 'k', 'YColor', 'k');
colors = {'w', [0.5 0.5 0.5]};
sbjNames = {'Subject X', 'Subject Y'};
for(iSF = 1:2)
    for(iSbj = 1:2)
        h(iSbj) = bar(iSF*2-1.25+(iSbj-1)*0.5, data.Fig5.B.gainPower{iSF}(iSbj), 0.48, 'FaceColor', colors{iSbj}, 'LineStyle', '-', 'LineWidth', 2, 'DisplayName', sbjNames{iSbj}, 'FaceAlpha', 0.6);
        errorbar(iSF*2-1.25+(iSbj-1)*0.5, data.Fig5.B.gainPower{iSF}(iSbj), data.Fig5.B.sdGain{iSF}(iSbj), 'k', 'LineWidth', 2);
    end
end
text(1, data.Fig5.B.gainPower{1}(1) + data.Fig5.B.sdGain{1}(1) + 0.02*diff(ylim), sprintf('$p=%.3f $', data.Fig5.B.pValues{1}(1)), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 18, 'interpreter', 'latex');
text(1.25, data.Fig5.B.gainPower{1}(2) + data.Fig5.B.sdGain{1}(2) + 0.02*diff(ylim), sprintf('$p=%.1g$', data.Fig5.B.pValues{1}(2)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 18, 'interpreter', 'latex');
text(2.75, data.Fig5.B.gainPower{2}(1) + data.Fig5.B.sdGain{2}(1) + 0.02*diff(ylim), sprintf('$p=%.3f$', data.Fig5.B.pValues{2}(1)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 18, 'interpreter', 'latex');
text(3, data.Fig5.B.gainPower{2}(2) + data.Fig5.B.sdGain{2}(2) + 0.02*diff(ylim), sprintf(' $p=%.3f$', data.Fig5.B.pValues{2}(2)), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontSize', 18, 'interpreter', 'latex');
legend(h);
ylabel('Gain in total power (dB)');

%%% panel labels
axes('position', [0 0 1 1], 'xlim', [0 1], 'YLim', [0 1], 'visible', 'off');
text(0.08, 0.88, 'A', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.51, 0.88, 'B', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Fig. 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('color', 'w', 'NumberTitle', 'off', 'name', 'Fig. 6', 'position', [183 340 1200 400]);
%%% A
% no data in this panel

%%% B
subplot(1,8,1:3); hold on;
set(gca, 'XLim', [0 4], 'YLim', [60 105], 'YTick', 60:10:100, 'LineWidth', 2, 'XTick', [1 3], 'XTickLabel', {'No Blink', 'Simulated Blink'}, 'FontSize', 20, 'XColor', 'k', 'YColor', 'k');
plot([1 3], [data.Fig6.B.correctRateNoBlink; data.Fig6.B.correctRateBlink] * 100, '^--', 'MarkerSize', 8, 'LineWidth', 2, 'color', [.5 .5 .5]);
errorbar([1 3], [mean(data.Fig6.B.correctRateNoBlink), mean(data.Fig6.B.correctRateBlink)] * 100, [std(data.Fig6.B.correctRateNoBlink), std(data.Fig6.B.correctRateBlink)] * 100, 's-', 'MarkerFaceColor', 'k', 'MarkerSize', 10, 'LineWidth', 2, 'color', 'k');
plot([1 1 3 3], [103.5 105 105 103.5], 'k-', 'LineWidth', 1.5);
text(2, 104, '*', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 18);
ylabel('Proportion correct (%)');

%%% C
subplot(1,2,2); hold on;
plot(data.Fig6.C.dPrimeNoBlink, data.Fig6.C.dPrimeBlink, '^', 'color', [.5 .5 .5], 'MarkerSize', 8, 'LineWidth', 2);
errorbar(mean(data.Fig6.C.dPrimeNoBlink), mean(data.Fig6.C.dPrimeBlink), diff(data.Fig6.C.CI)/2, 'ks', 'MarkerSize', 10, 'MarkerFaceColor', 'k', 'LineWidth', 2);
plot([0 3], [0 3], 'k--', 'LineWidth', 1);
plot([2.25 2.35 2.35 2.25], [mean(data.Fig6.C.dPrimeNoBlink)*[1 1], mean(data.Fig6.C.dPrimeBlink)*[1 1]], 'k-', 'LineWidth', 1.5);
text(2.35, (mean(data.Fig6.C.dPrimeNoBlink) + mean(data.Fig6.C.dPrimeBlink)) / 2, '**', 'FontSize', 18, 'rotation', 90, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
axis equal;
set(gca, 'XLim', [0 3], 'YLim', [0 3], 'XTick', 0:0.5:3, 'XTickLabel', {'0' '' '1' '' '2' '' '3'}, 'YTick', 0:0.5:3, 'YTickLabel', {'0' '' '1' '' '2' '' '3'}, 'LineWidth', 2, 'FontSize', 20, 'XColor', 'k', 'YColor', 'k');
xlabel('d^\prime (No Blink)');
ylabel('d^\prime (Simulated Blink)');

%%% panel labels
axes('position', [0 0 1 1], 'xlim', [0 1], 'YLim', [0 1], 'visible', 'off');
text(0.06, 0.88, 'B', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);
text(0.57, 0.88, 'C', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 36);