function Spectrum10 = importFile(filename, dataLines)
%IMPORTFILE 从文本文件中导入数据
%  SPECTRUM10 = IMPORTFILE(FILENAME)读取文本文件 FILENAME 中默认选定范围的数据。  返回数值数据。
%
%  SPECTRUM10 = IMPORTFILE(FILE, DATALINES)按指定行间隔读取文本文件 FILENAME
%  中的数据。对于不连续的行间隔，请将 DATALINES 指定为正整数标量或 N×2 正整数标量数组。
%
%  示例:
%  Spectrum10 = importfile("C:\Users\Administrator\Desktop\Cal_SIF\Standard_Spectral_Data_1114\Spectrum_1_0.sps", [27, Inf]);
%
%  另请参阅 READTABLE。
%
% 由 MATLAB 于 2021-11-15 09:56:13 自动生成

%% 输入处理

% 如果不指定 dataLines，请定义默认范围
if nargin < 2
    dataLines = [27, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 4);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = " ";

% 指定列名称和类型
opts.VariableNames = ["Spectrum", "Setting", "Var3", "Var4"];
opts.SelectedVariableNames = ["Spectrum", "Setting"];
opts.VariableTypes = ["double", "double", "string", "string"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% 指定变量属性
opts = setvaropts(opts, ["Var3", "Var4"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var3", "Var4"], "EmptyFieldRule", "auto");

% 导入数据
Spectrum10 = readtable(filename, opts);

%% 转换为输出类型
Spectrum10 = table2array(Spectrum10);
end