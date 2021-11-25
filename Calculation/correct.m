function varargout = correct(varargin)
% CORRECT MATLAB code for correct.fig
%      CORRECT, by itself, creates a new CORRECT or raises the existing
%      singleton*.
%
%      H = CORRECT returns the handle to a new CORRECT or the handle to
%      the existing singleton*.
%
%      CORRECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CORRECT.M with the given input arguments.
%
%      CORRECT('Property','Value',...) creates a new CORRECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before correct_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to correct_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help correct

% Last Modified by GUIDE v2.5 19-Nov-2021 18:27:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @correct_OpeningFcn, ...
                   'gui_OutputFcn',  @correct_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before correct is made visible.
function correct_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to correct (see VARARGIN)

% Choose default command line output for correct
handles.output = hObject;
set(handles.save_data, 'visible', 'off')
set(handles.adjust_data, 'visible', 'off')
set(handles.Next,'visible', 'off')
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes correct wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = correct_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Total_times_Callback(hObject, eventdata, handles)
% hObject    handle to Total_times (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Total_times as text
%        str2double(get(hObject,'String')) returns contents of Total_times as a double


% --- Executes during object creation, after setting all properties.
function Total_times_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Total_times (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Observation_Times_Callback(hObject, eventdata, handles)
% hObject    handle to Observation_Times (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Observation_Times as text
%        str2double(get(hObject,'String')) returns contents of Observation_Times as a double


% --- Executes during object creation, after setting all properties.
function Observation_Times_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Observation_Times (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Light_Number_Callback(hObject, eventdata, handles)
% hObject    handle to Light_Number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Light_Number as text
%        str2double(get(hObject,'String')) returns contents of Light_Number as a double


% --- Executes during object creation, after setting all properties.
function Light_Number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Light_Number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Start_Obs.
function Start_Obs_Callback(hObject, eventdata, handles)
global i; global j; global Spectrum;
% 初始化
set(handles.save_data, 'visible', 'off')
set(handles.adjust_data, 'visible', 'off')

%　开始测量
Total_Times = get(handles.Total_times,'String');    % 第几次定标
Obs_Times = get(handles.Observation_Times,'String');% 光谱观测次数
Light_Number = get(handles.Light_Number,'String');  % 第几根光纤
h1 = msgbox({'测量开始，以下为测量参数',['共需要', Total_Times, '次定标'],...
    ['共有', Light_Number, '根光纤需要定标'],...
    ['每根光纤观测',Obs_Times,'次'], ['目前正在观测第1根光纤']}, '开始测量！', 'help');
% pause(10)
close(h1)
filepath = get(handles.FilePath, 'String');

i = 1; j = 1;
% 读取数据
h2 = msgbox(['请插入第1根光纤！']);
% pause(5),
close(h2)
filename = [filepath, '\Spectrum_', num2str(i) , '_0.sps'];

if ~exist(filename, 'file') % 判断目标文件是否存在
    msgbox(['文件',filename,'不存在！'], 'ERROR', 'error');
else
    temp_spectrum = importfile_col(filename);
    axes(handles.axes1)
    plot(1:size(temp_spectrum,1), temp_spectrum, 'r', 'linewidth',2)
    grid on, legend(['第', num2str(i), '根光纤'])
    xlabel('Wavelength'),ylabel('Intensity')
    Spectrum{i}(:,1) = temp_spectrum;
    
    set(handles.save_data, 'visible', 'on')
    set(handles.adjust_data, 'visible', 'on')
end
i = i+1;


% --- Executes during object creation, after setting all properties.
function FilePath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FilePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Calculate.
function Calculate_Callback(hObject, eventdata, handles)
% 计算定标参数
global Spectrum;
global Light_Fiber; global Spectrum_Mid; global Spectrum_Mid_Correct;
% 读取数据
for i = 1:7
    filename1 = ['Spectrum_', num2str(i) , '_0_1.sps'];
    filename2 = ['Spectrum_', num2str(i) , '_1.sps'];
    filename3 = ['Spectrum_', num2str(i) , '_1_1.sps'];
    Spectrum_Big{i} = importFile(filename1);
    Spectrum_Small{i} = importFile(filename2);
    Spectrum_Mid{i} = importFile(filename3);
end

% 相对定标，以第一根光纤为标准
for i = 2:7
    dis_Big(:,i-1) = Spectrum_Big{i}(:,2) - Spectrum_Big{1}(:,2);
    dis_Mid(:,i-1) = Spectrum_Mid{i}(:,2) - Spectrum_Mid{1}(:,2);
    dis_Small(:,i-1) = Spectrum_Small{i}(:,2) - Spectrum_Small{1}(:,2);
end
% 对这两个差值进行线性插值
n = 350:1020;
for i = 1:6
    dis{i} = [dis_Small(:,i), dis_Mid(:,i), dis_Big(:,i)];
end

Spectrum_Mid_Correct = Spectrum_Mid;
for i = 1:6
    for j = 1:size(dis{i},1)
        % 线性拟合
        MAX_LIGHT = Spectrum_Big{i}(j,2);
        MID_LIGHT = Spectrum_Mid{i}(j,2);
        MIN_LIGHT = Spectrum_Small{i}(j,2);
        footstep = floor(MIN_LIGHT):floor(MAX_LIGHT);
        Light_Fiber{i,j} = polyfit([MIN_LIGHT, MID_LIGHT, MAX_LIGHT], dis{i}(j,:), 2);
        
        % 加到中光强的数据上
        mid_light = Spectrum_Mid{i+1}(j,2);
        delta_light = polyval(Light_Fiber{i,j}, mid_light);
        Spectrum_Mid_Correct{i+1}(j,2) = Spectrum_Mid{i+1}(j,2) - delta_light;
    end
end
msgbox('定标参数计算完毕！')

% --- Executes on button press in Plot.
function Plot_Callback(hObject, eventdata, handles)
% 查看定标效果
global Spectrum_Mid; global Spectrum_Mid_Correct;
global k;
k = 1;
set(handles.save_data, 'visible', 'off')
set(handles.Next,'visible', 'on')
axes(handles.axes1)
n = 1:size(Spectrum_Mid{1},1);
plot(n, Spectrum_Mid_Correct{k+1}(:,2), 'b--', 'linewidth',2),hold on
plot(n, Spectrum_Mid{1}(:,2), 'r', 'linewidth',1)
plot(n, Spectrum_Mid{k+1}(:,2), 'g', 'linewidth',1),hold off
title(['第', num2str(k+1),'根光纤']),xlabel('Wavelength'),ylabel('Intensity'),grid on,legend('定标后数据','参考光纤测量值',['第', num2str(k+1),'根光纤测量值'])

% --- Executes on button press in Save_and_End.
function Save_and_End_Callback(hObject, eventdata, handles)
% 保存并完成定标
global Light_Fiber;
n = 350:1020;
for num = 1:6
    fid(num) = fopen(['Calibration', num2str(num), '.conf'],'w+');
    for i = 1:size(Light_Fiber,2)
        fprintf(fid(num), "%d %20.12f %20.12f %20.12f\n",n(i), Light_Fiber{num,i}(1), Light_Fiber{num,i}(2), Light_Fiber{num,i}(3));
    end
    fclose(fid(num));
end
h = msgbox('保存成功！定标结束！');
pause(3)


% --- Executes on button press in save_data.
function save_data_Callback(hObject, eventdata, handles)    
% 光强合适，保存文件并继续
global i; global j; global Spectrum;

Total_Times = get(handles.Total_times,'String');    % 第几次定标
Light_Number = get(handles.Light_Number,'String');  % 共几根光纤
filepath = get(handles.FilePath, 'String');

if str2num(Total_Times) >= j
    if str2num(Light_Number) < i
        h5 = msgbox(['第', num2str(j), '轮测量结束!请调整标准光源强度后再次采集!']);
        j = j + 1;
        i = 1;
    else
        h3 = msgbox(['请将第', num2str(i), '根光纤插入标准光源！']);
%         pause(5), 
        close(h3)
        filename = [filepath, '\Spectrum_', num2str(i) , '_0.sps'];
        if ~exist(filename, 'file') % 判断目标文件是否存在
            msgbox(['文件',filename,'不存在！'], 'ERROR', 'error');
        else
            temp_spectrum = importfile_col(filename);
            axes(handles.axes1)
            plot(1:size(temp_spectrum,1), temp_spectrum, 'r', 'linewidth',2)
            grid on, legend(['第', num2str(i), '根光纤'])
            xlabel('Wavelength'),ylabel('Intensity')
            Spectrum{i}(:,1) = temp_spectrum;
        end
        i = i+1;
    end
else
    if str2num(Total_Times) == (j-1)
        msgbox('所有测量结束！可以开始定标！')
        pause(3)
    end
end


% --- Executes on button press in adjust_data.
function adjust_data_Callback(hObject, eventdata, handles)
% 光强过高，请重新测量
global i; global j;
i = 1;
j = 1;
axes(handles.axes1); %指定需要清空的坐标轴
cla reset;
box on; %在坐标轴四周加上边框
set(handles.axes1,'xtick',[]);
set(handles.axes1,'ytick',[]);
h1 = msgbox('请调整光源强度后重新测量！');
pause(3), close(h1)

% --- Executes on button press in select_filepath.
function select_filepath_Callback(hObject, eventdata, handles)  
% 选择文件路径
folder_name = uigetdir;
set(handles.FilePath, 'String', folder_name)


% --- Executes on button press in Next.
function Next_Callback(hObject, eventdata, handles)
% 下一根
global k; global Spectrum_Mid; global Spectrum_Mid_Correct;
k = k+1;
if k <= str2num(get(handles.Light_Number,'String'))
    axes(handles.axes1)
    n = 1:size(Spectrum_Mid{1},1);
    plot(n, Spectrum_Mid_Correct{k+1}(:,2), 'b--', 'linewidth',2),hold on
    plot(n, Spectrum_Mid{1}(:,2), 'r', 'linewidth',1)
    plot(n, Spectrum_Mid{k+1}(:,2), 'g', 'linewidth',1), hold off
    title(['第', num2str(k+1),'根光纤']),xlabel('Wavelength'),ylabel('Intensity'),grid on,legend('定标后数据','参考光纤测量值',['第', num2str(k+1),'根光纤测量值'])
else
    msgbox('当前是最后一根光纤！')
end