% Práctica 2 de Instrumentación
% Calibración de un sensor de distancia
%
% Rafael Casanova Morera
% Jonán Cruz Martín
% David Morales Sáez
%

function varargout = guimedicion(varargin)
% GUIMEDICION M-file for guimedicion.fig
%      GUIMEDICION, by itself, creates a new GUIMEDICION or raises the existing
%      singleton*.
%
%      H = GUIMEDICION returns the handle to a new GUIMEDICION or the handle to
%      the existing singleton*.
%
%      GUIMEDICION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIMEDICION.M with the given input arguments.
%
%      GUIMEDICION('Property','Value',...) creates a new GUIMEDICION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guimedicion_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guimedicion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help guimedicion

% Last Modified by GUIDE v2.5 19-Mar-2010 10:06:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guimedicion_OpeningFcn, ...
                   'gui_OutputFcn',  @guimedicion_OutputFcn, ...
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

% --- Executes just before guimedicion is made visible.
function guimedicion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guimedicion (see VARARGIN)

global pcal8 intervalo
load pcal8;
intervalo = 5;
% Choose default command line output for guimedicion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes guimedicion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guimedicion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_tomarUnaMedida.
function btn_tomarUnaMedida_Callback(hObject, eventdata, handles)
% hObject    handle to btn_tomarUnaMedida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pcal8
tomarMedida(handles)

% --- Executes on button press in btn_iniciaTemp.
function btn_iniciaTemp_Callback(hObject, eventdata, handles)
% hObject    handle to btn_iniciaTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t intervalo
t = timer('TimerFcn',{@mycallback,handles}, 'Period', intervalo, 'ExecutionMode', 'fixedDelay');
start(t)
set(handles.text9, 'String', 'En marcha')
set(handles.text9, 'ForegroundColor', [0 127/255 0])


% --- Executes on button press in btn_finTemp.
function btn_finTemp_Callback(hObject, eventdata, handles)
% hObject    handle to btn_finTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t
stop(t)
set(handles.text9, 'String', 'Parado')
set(handles.text9, 'ForegroundColor', 'red')


function edit_intervalTemp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_intervalTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_intervalTemp as text
%        str2double(get(hObject,'String')) returns contents of edit_intervalTemp as a double
global intervalo
intervalo = str2num(get(handles.edit_intervalTemp, 'String'));


% --- Executes during object creation, after setting all properties.
function edit_intervalTemp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_intervalTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function mycallback(obj, eventdata, handles)
    global pcal8
    [voltaje overVoltage errorcode idnum] = eanalogin(-1, 1, 8, 0);
    distancia = polyval(pcal8, voltaje);
    set(handles.textlb_dist, 'String', sprintf('%f', distancia));
    set(handles.textlb_volt, 'String', sprintf('%f', voltaje));
    % disp('funciona')

function tomarMedida(handles)
    global pcal8
    [voltaje overVoltage errorcode idnum] = eanalogin(-1, 1, 8, 0);
    distancia = polyval(pcal8, voltaje);
    set(handles.textlb_dist, 'String', sprintf('%f', distancia));
    set(handles.textlb_volt, 'String', sprintf('%f', voltaje))


