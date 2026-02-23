clc, clear, close all

% 폴더 선택
rootDir = 'G:\공유 드라이브\Battery Software Group (2025)\Members\김준섭\논문 작업\MIT\EIS Data for Juhyun\EIS Data for Juhyun\DRTsplit_zcycle 2-4.1';

% 하위 폴더 포함해서 txt 파일 모두 찾기
files = dir(fullfile(rootDir, '**', '*.txt'));
if isempty(files)
    error('선택한 폴더 및 하위 폴더에서 .txt 파일을 찾지 못했습니다: %s', rootDir);
end

% Nyquist plot
figNyq = figure; %#ok<NASGU>
hold on; grid on;
xlabel("Z' [Ohm]");
ylabel("-Z'' [Ohm]");
title('EIS Nyquist Plot');

legendNames = {};
plottedCount = 0;

numFiles = min(20, numel(files));  % 현재는 1:20 사용하니까 맞춰줌
for k = 1:numFiles
    filePath = fullfile(files(k).folder, files(k).name);

    % 데이터 읽기 (헤더가 있어도 readmatrix가 NaN 처리로 넘길 때가 많음)
    data = readmatrix(filePath);

    % 유효성 검사
    if size(data,2) < 3
        warning('열이 3개 미만이라 스킵합니다: %s', filePath);
        continue;
    end

    f  = data(:,1);
    Zr = data(:,2);
    Zi = data(:,3);

    % NaN/Inf 제거
    valid = isfinite(f) & isfinite(Zr) & isfinite(Zi);
    f  = f(valid); %#ok<NASGU>  % (필요하면 Bode용으로 사용 가능)
    Zr = Zr(valid);
    Zi = Zi(valid);

    if numel(Zr) < 3
        warning('유효 데이터가 너무 적어 스킵합니다: %s', filePath);
        continue;
    end

    if numFiles > 1
    alpha = (k-1)/(numFiles-1);
    else
        alpha = 1;  % 파일이 1개일 경우
    end
    
    color_k = [0 0 alpha];  % [R G B]

    % Nyquist: 보통 -Z''로 그림
    clc, clear, close all

% 폴더 선택
rootDir = 'G:\공유 드라이브\Battery Software Group (2025)\Members\김준섭\논문 작업\MIT\EIS Data for Juhyun\EIS Data for Juhyun\DRTsplit_zcycle 2-4.1';

% 하위 폴더 포함해서 txt 파일 모두 찾기
files = dir(fullfile(rootDir, '**', '*.txt'));
if isempty(files)
    error('선택한 폴더 및 하위 폴더에서 .txt 파일을 찾지 못했습니다: %s', rootDir);
end

% Nyquist plot
figNyq = figure; %#ok<NASGU>
hold on; grid on;
xlabel("Z' [Ohm]");
ylabel("-Z'' [Ohm]");
title('EIS Nyquist Plot');

legendNames = {};
plottedCount = 0;

numFiles = min(100, numel(files));  % 현재는 1:20 사용하니까 맞춰줌
for k = 1:numFiles
    filePath = fullfile(files(k).folder, files(k).name);

    % 데이터 읽기 (헤더가 있어도 readmatrix가 NaN 처리로 넘길 때가 많음)
    data = readmatrix(filePath);

    % 유효성 검사
    if size(data,2) < 3
        warning('열이 3개 미만이라 스킵합니다: %s', filePath);
        continue;
    end

    f  = data(:,1);
    Zr = data(:,2);
    Zi = data(:,3);

    % NaN/Inf 제거
    valid = isfinite(f) & isfinite(Zr) & isfinite(Zi);
    f  = f(valid); %#ok<NASGU>  % (필요하면 Bode용으로 사용 가능)
    Zr = Zr(valid);
    Zi = Zi(valid);

    if numel(Zr) < 3
        warning('유효 데이터가 너무 적어 스킵합니다: %s', filePath);
        continue;
    end


    % Nyquist: 보통 -Z''로 그림
    if numFiles > 1
    alpha = (k-1)/(numFiles-1);
    else
        alpha = 1;
    end
    color_k = [alpha 0 0];  % 검정 -> 빨강
    
    h = plot(Zr, -Zi, 'o-', 'LineWidth', 1, ...
         'Color', color_k, ...
         'MarkerEdgeColor', color_k, ...
         'MarkerFaceColor', color_k);

    plottedCount = plottedCount + 1;

    % legend 이름: 폴더 구조가 길면 파일명만 쓰고 싶으면 files(k).name만 사용
    relName = erase(filePath, rootDir);
    newName = erase(split(relName,'_'),'.txt');
    if startsWith(relName, filesep), relName = relName(2:end); end
    legendNames{end+1} = newName{end} ; %#ok<AGROW>
end

if plottedCount == 0
    error('그릴 수 있는 유효한 txt 데이터가 없습니다.');
end

legend(legendNames, 'Interpreter', 'none', 'Location', 'best');
xlim([0 350]);
ylim([0 350]);
set(gcf,"Position",[300 300 1200 800])
set(gca,'PlotBoxAspectRatio',[1 1 1])


    plottedCount = plottedCount + 1;

    % legend 이름: 폴더 구조가 길면 파일명만 쓰고 싶으면 files(k).name만 사용
    relName = erase(filePath, rootDir);
    newName = erase(split(relName,'_'),'.txt');
    if startsWith(relName, filesep), relName = relName(2:end); end
    legendNames{end+1} = newName{end} ; %#ok<AGROW>
end

if plottedCount == 0
    error('그릴 수 있는 유효한 txt 데이터가 없습니다.');
end

legend(legendNames, 'Interpreter', 'none', 'Location', 'best');
xlim([0 350]);
ylim([0 350]);
set(gcf,"Position",[300 300 1200 800])
set(gca,'PlotBoxAspectRatio',[1 1 1])
