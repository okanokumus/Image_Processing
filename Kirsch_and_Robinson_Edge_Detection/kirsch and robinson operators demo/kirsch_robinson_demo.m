function varargout = kirsch_robinson_demo(varargin)
% KIRSCH_ROBINSON_DEMO MATLAB code for kirsch_robinson_demo.fig
%      KIRSCH_ROBINSON_DEMO, by itself, creates a new KIRSCH_ROBINSON_DEMO or raises the existing
%      singleton*.
%
%      H = KIRSCH_ROBINSON_DEMO returns the handle to a new KIRSCH_ROBINSON_DEMO or the handle to
%      the existing singleton*.
%
%      KIRSCH_ROBINSON_DEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KIRSCH_ROBINSON_DEMO.M with the given input arguments.
%
%      KIRSCH_ROBINSON_DEMO('Property','Value',...) creates a new KIRSCH_ROBINSON_DEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kirsch_robinson_demo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kirsch_robinson_demo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kirsch_robinson_demo

% Last Modified by GUIDE v2.5 15-May-2017 04:11:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kirsch_robinson_demo_OpeningFcn, ...
                   'gui_OutputFcn',  @kirsch_robinson_demo_OutputFcn, ...
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


% --- Executes just before kirsch_robinson_demo is made visible.
function kirsch_robinson_demo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kirsch_robinson_demo (see VARARGIN)

% Choose default command line output for kirsch_robinson_demo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kirsch_robinson_demo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kirsch_robinson_demo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in kirsch.
function kirsch_Callback(hObject, eventdata, handles)
% hObject    handle to kirsch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% The Kirsch operator
global Igray im_write kirsch_im
    % Igray is grayscale of the original image 
    im_double=double(Igray);
    % Eight directions Kirsch edge masks. below masks are gettting from
    % rotation of the one mask.
    g1=[5,5,5; -3,0,-3; -3,-3,-3]; % South
    g2=[5,5,-3; 5,0,-3; -3,-3,-3]; % Southeast
    g3=[5,-3,-3; 5,0,-3; 5,-3,-3]; % East
    g4=[-3,-3,-3; 5,0,-3; 5,5,-3]; % 
    g5=[-3,-3,-3; -3,0,-3; 5,5,5];
    g6=[-3,-3,-3; -3,0,5;-3,5,5];
    g7=[-3,-3,5; -3,0,5;-3,-3,5];
    g8=[-3,5,5; -3,0,5;-3,-3,-3];
    % filtering with Kirsch mask
    % edges in all the direction
%     Each mask respondsmaximally to an edge oriented in a particular general
%     direction. The maximum value over all eight orientations
%     is the output value for the edge magnitude image.
    x1=imfilter(im_double,g1,'replicate');
    x2=imfilter(im_double,g2,'replicate');
    x3=imfilter(im_double,g3,'replicate');
    x4=imfilter(im_double,g4,'replicate');
    x5=imfilter(im_double,g5,'replicate');
    x6=imfilter(im_double,g6,'replicate');
    x7=imfilter(im_double,g7,'replicate');
    x8=imfilter(im_double,g8,'replicate');

    y1=max(x1,x2);
    y2=max(y1,x3);
    y3=max(y2,x4);
    y4=max(y3,x5);
    y5=max(y4,x6);
    y6=max(y5,x7);
    kirsch_im=max(y6,x8); % result image 
    axes(handles.imgshow);
    im_write = kirsch_im;  % for 'save to file' option
    imshow (kirsch_im,[]);

% --- Executes on slider movement.
function kirsch_slider_Callback(hObject, eventdata, handles)
% hObject    handle to kirsch_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global im_write kirsch_im
thres = get(hObject,'Value'); % gets threshold value
set(handles.text6,'String',num2str(thres));
threshed = kirsch_im >= thres ; % if the input value is greater than thres value sets as 1
im_write = threshed ; % for 'save to file' option
axes(handles.imgshow);
imshow(threshed);

% --- Executes during object creation, after setting all properties.
function kirsch_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kirsch_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function robinson_CreateFcn(hObject, eventdata, handles)
% hObject    handle to robinson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in robinson.
function robinson_Callback(hObject, eventdata, handles)
% hObject    handle to robinson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Igray im_write robinson_im
    % Igray is grayscale of the original image 
    im_double=double(Igray);
    % Eight directions Robinson edge masks. below masks are gettting from
    % rotation of the one mask.
    g1=[-1, 0, 1; -2, 0, -2; -1, 0, 1]; % NORTH DIRECTION MASK
    g2=[0, 1, 2; -1 , 0, 1; -2, -1, 0]; % NORTH WEST DIRECTION MASK
    g3=[1, 2, 1; 0, 0, 0; -1, -2, -1]; % WEST DIRECTION MASK
    g4=[2, 1, 0; 1, 0, -1; 0, -1, -2]; % SOUTH WEST DIRECTION MASK
    g5=[1, 0, -1; 2, 0,-2; 1, 0, -1]; % SOUTH DIRECTION MASK
    g6=[0,-1,-2; 1, 0, -1; 2, 1, 0]; % SOUTH EAST DIRECTION MASK
    g7=[-1, -2, -1; 0,0,0;1, 2, 1]; %EAST DIRECTION MASK
    g8=[-2, -1 ,0; -1, 0, 1; 0, 1, 2]; % NORTH EAST DIRECTION MASK
    % filtering with Kirsch mask
    % edges in all the direction
%     Each mask respondsmaximally to an edge oriented in a particular general
%     direction. The maximum value over all eight orientations
%     is the output value for the edge magnitude image.
    x1=imfilter(im_double,g1,'replicate');
    x2=imfilter(im_double,g2,'replicate');
    x3=imfilter(im_double,g3,'replicate');
    x4=imfilter(im_double,g4,'replicate');
    x5=imfilter(im_double,g5,'replicate');
    x6=imfilter(im_double,g6,'replicate');
    x7=imfilter(im_double,g7,'replicate');
    x8=imfilter(im_double,g8,'replicate');

    y1=max(x1,x2);
    y2=max(y1,x3);
    y3=max(y2,x4);
    y4=max(y3,x5);
    y5=max(y4,x6);
    y6=max(y5,x7);
    robinson_im=max(y6,x8); % result image 
    axes(handles.imgshow);
    im_write = robinson_im;  % for 'save to file' option
    imshow (robinson_im,[]);

% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im Igray Idouble
[filename, user_canceled] = imgetfile();
if user_canceled
    msgbox(sprintf('Error: no image is selected'),'Error','Error');
    return
end
im = imread(filename);
Igray = rgb2gray(im);
Idouble = im2double(Igray);
axes(handles.imgshow);
imshow(im);

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_write
imwrite(im_write,'result.png');

% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all;
close all;

% --- Executes on slider movement.
function robinson_slider_Callback(hObject, eventdata, handles)
% hObject    handle to robinson_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global im_write robinson_im
thres = get(hObject,'Value'); % gets threshold value
set(handles.text7,'String',num2str(thres));
threshed = robinson_im >= thres ; % if the input value is greater than thres value sets as 1
im_write = threshed ; % for 'save to file' option
axes(handles.imgshow);
imshow(threshed);

% --- Executes during object creation, after setting all properties.
function robinson_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to robinson_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
axes(handles.imgshow);
imshow(im);
