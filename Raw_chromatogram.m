function Raw_chromatogram()
% RAW_CHROMATOGRAM Plot raw chromatogram with optional baseline correction
%   Syntax: Raw_chromatogram()
%   Features:
%   - Automatic Agilent data format detection
%   - Configurable baseline correction
%   - Cross-version MATLAB compatibility

% Import Agilent FID data
data = ImportAgilentFID();

% Handle legacy Agilent data formats (pre-2015)
if quantile(data.Signal, 0.01) > 10000
    data_Signal = data.Signal * data.Slope; % Modern format data
else
    data_Signal = data.Signal; % Apply scaling factor
end

% Processing parameters
Baseline_set = true; % [true/false] Enable baseline correction

% Initialize figure with cross-version compatible settings
figure1 = figure('PaperPosition',[0.3 3.0 29.0 16.0],...
                'PaperSize',[29.68 20.98],...
                'Renderer','Painters');
            
% Configure axes properties
axes1 = axes('Parent',figure1,...
            'FontName','Times New Roman',...
            'FontSize',12,...
            'LineWidth',1.5,...
            'Layer','top',...
            'Box','on');

% Set axis limits with 10% margin
axis([0 ceil(max(data.Time)) 0 ceil(1.1*max(data_Signal))]);
hold(axes1,'on');

% Core processing logic
if Baseline_set
    % Perform baseline correction
    data_baseline = Baseline(data_Signal);
    data_0 = data_Signal - data_baseline;
    
    % Plot corrected signal
    plot(data.Time, data_0, 'k', 'LineWidth',1.2);
    
    % Overlay baseline estimate
    plot(data.Time, data_baseline, '--',...
        'Color',[0.5 0.5 0.5],...
        'LineWidth',0.8);
else
    % Plot raw signal without correction
    data_0 = data_Signal; % Direct assignment
    plot(data.Time, data_0, 'k', 'LineWidth',1.2);
end

% Axis labeling
xlabel('Retention Time (min)',...
      'FontWeight','bold',...
      'FontSize',14);
ylabel('Signal Intensity (a.u.)',...
      'FontWeight','bold',...
      'FontSize',14);

% Add legend when baseline corrected
if Baseline_set
    legend('Corrected Signal','Baseline Estimate',...
          'Location','NorthEast');
end

hold(axes1,'off');
end

