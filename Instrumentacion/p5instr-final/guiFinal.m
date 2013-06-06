function varargout = guiFinal(varargin)
% GUIFINAL M-file for guiFinal.fig
%      GUIFINAL, by itself, creates a new GUIFINAL or raises the existing
%      singleton*.
%
%      H = GUIFINAL returns the handle to a new GUIFINAL or the handle to
%      the existing singleton*.
%
%      GUIFINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIFINAL.M with the given input arguments.
%
%      GUIFINAL('Property','Value',...) creates a new GUIFINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiFinal_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiFinal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help guiFinal

% Last Modified by GUIDE v2.5 28-May-2010 09:18:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiFinal_OpeningFcn, ...
                   'gui_OutputFcn',  @guiFinal_OutputFcn, ...
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


% --- Executes just before guiFinal is made visible.
function guiFinal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiFinal (see VARARGIN)

% Choose default command line output for guiFinal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global precision frecuencia distancia_objetivo
precision = 1;
frecuencia = 0.1;
distancia_objetivo = 15;

% UIWAIT makes guiFinal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guiFinal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in boton.
function boton_Callback(hObject, eventdata, handles)
% hObject    handle to boton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of boton
button_state = get(hObject,'Value');
global finbucle
if button_state == get(hObject,'Max')
    % toggle button is pressed
    finbucle = 0;
    bucle(handles);
elseif button_state == get(hObject,'Min')
    % toggle button is not pressed
    finbucle = 1;
end



function distObj_Callback(hObject, eventdata, handles)
% hObject    handle to distObj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distObj as text
%        str2double(get(hObject,'String')) returns contents of distObj as a double
global distancia_objetivo
distancia_objetivo = str2double(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function distObj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distObj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function prec_Callback(hObject, eventdata, handles)
% hObject    handle to prec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prec as text
%        str2double(get(hObject,'String')) returns contents of prec as a double
global precision
precision = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function prec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function frec_Callback(hObject, eventdata, handles)
% hObject    handle to frec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frec as text
%        str2double(get(hObject,'String')) returns contents of frec as a double
global frecuencia
frecuencia = str2double(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function frec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function bucle(handles)
load pcal8;
global distancia_objetivo finbucle precision frecuencia distancia_leida
while finbucle == 0
    %distancia = 10;
    % preguntar distancia
    [voltaje overVoltage errorcode idnum] = eanalogin(-1, 0, 0, 0);
    distancia_leida = polyval(pcal8, voltaje);
    set(handles.dist, 'String', num2str(distancia_leida));
    % decidir accion
    if distancia_leida < (distancia_objetivo-precision)
        eanalogout(-1, 0, 5.0, 0.0); % hacia atrás
    else
        if distancia_leida > (distancia_objetivo+precision)
            eanalogout(-1, 0, 0.0, 0.0); % hacia delante
        else
            eanalogout(-1, 0, 5.0, 5.0); % quieto parao
        end
    end
    pause(frecuencia);
end
eanalogout(-1, 0, 5.0, 5.0); % quieto parao
