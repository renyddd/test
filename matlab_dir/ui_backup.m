function varargout = untitled1(varargin)
% UNTITLED1 MATLAB code for untitled1.fig
%      UNTITLED1, by itself, creates a new UNTITLED1 or raises the existing
%      singleton*.
%
%      H = UNTITLED1 returns the handle to a new UNTITLED1 or the handle to
%      the existing singleton*.
%
%      UNTITLED1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED1.M with the given input arguments.
%
%      UNTITLED1('Property','Value',...) creates a new UNTITLED1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled1

% Last Modified by GUIDE v2.5 08-Jan-2020 22:33:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled1_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled1_OutputFcn, ...
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


% --- Executes just before untitled1 is made visible.
function untitled1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled1 (see VARARGIN)

% Choose default command line output for untitled1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% 显示傅里叶变换的频谱,以及一些全局变量
function show_subplot()
global y; global fs; global output;
% figure
subplot(2, 2, 2); plot(y)
title('信号的时域波形');
subplot(2, 2, 4); plot(output)
title('滤波后的时域波形');

n = length(y);          % 选取变换的点数 
Y = fft(y, n);          % 对n点进行傅里叶变换到频域
P2 = abs(Y/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1); % end: 终止代码块或指示最大数组索引

subplot(2, 2, 1);
f = fs*(0:(n/2))/n;     % 对应点的频率，取数组中对应下标的元素
plot(f, P1); %语音信号的频谱图
title('原始语音信号采样后频谱图'); xlabel('频率Hz'); ylabel('频率幅值');

n = length(output);          %选取变换的点数 
Y = fft(output, n);          %对n点进行傅里叶变换到频域
P2 = abs(Y/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1); % end: 终止代码块或指示最大数组索引
subplot(2, 2, 3);
f = fs*(0:(n/2))/n;          % 对应点的频率，取数组中对应下标的元素
plot(f, P1); %语音信号的频谱图


% 加载语言 --> 完成初始化操作
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y; global fs; global output        % 每次使用时都需要进行 global 的声明
[y,fs]=audioread('record.m4a');

subplot(2, 2, 2); plot(y)
n = length(y);          % 选取变换的点数 
Y = fft(y, n);          % 对n点进行傅里叶变换到频域
P2 = abs(Y/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1); % end: 终止代码块或指示最大数组索引
subplot(2, 2, 1);
f = fs*(0:(n/2))/n;     % 对应点的频率，取数组中对应下标的元素
plot(f, P1); %语音信号的频谱图
title('原始语音信号采样后频谱图'); xlabel('频率Hz'); ylabel('频率幅值');

sound(y,fs)      % 回放语音信号


% ellip_highpass -> 点击完成调用滤波器并且调用输出图像函数
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Hd = auto_ellip_highpass;
global y; global fs; global output
output = filter(Hd, y);
subplot(2, 2, 4); plot(output)
show_subplot()
sound(output, fs);


% kaiser_lowpass -->
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Hd = auto_kaiser_lowpass;
global y; global fs; global output
output = filter(Hd, y);
subplot(2, 2, 4); plot(output)
show_subplot()
sound(output, fs);


% butter_lowpass -->
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Hd = auto_butter_lowpass;
global y; global fs; global output
output = filter(Hd, y);
subplot(2, 2, 4); plot(output)
show_subplot()
sound(output, fs);


% cheby_bandpass -->
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Hd = auto_cheby_bandpass;
global y; global fs; global output
output = filter(Hd, y);
subplot(2, 2, 4); plot(output)
show_subplot()
sound(output, fs);


% cheby_bandstop -->
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Hd = auto_cheby_bandstop;
global y; global fs; global output
output = filter(Hd, y);
subplot(2, 2, 4); plot(output)
show_subplot()
sound(output, fs);
