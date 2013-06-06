function varargout = Detectar(varargin)
% DETECTAR MATLAB code for Detectar.fig
%      DETECTAR, by itself, creates a new DETECTAR or raises the existing
%      singleton*.
%
%      H = DETECTAR returns the handle to a new DETECTAR or the handle to
%      the existing singleton*.
%
%      DETECTAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETECTAR.M with the given input arguments.
%
%      DETECTAR('Property','Value',...) creates a new DETECTAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Detectar_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Detectar_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Detectar

% Last Modified by GUIDE v2.5 22-May-2013 15:15:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Detectar_OpeningFcn, ...
                   'gui_OutputFcn',  @Detectar_OutputFcn, ...
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


% --- Executes just before Detectar is made visible.
function Detectar_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Detectar (see VARARGIN)

% Choose default command line output for Detectar
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Detectar wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Detectar_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function ruta_Callback(hObject, eventdata, handles)
% hObject    handle to ruta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ruta as text
%        str2double(get(hObject,'String')) returns contents of ruta as a double
    ruta = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function ruta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ruta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
    formato = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listboxTratado.
function listboxTratado_Callback(hObject, eventdata, handles)
% hObject    handle to listboxTratado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxTratado contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxTratado
global elementosSalida; 
    b = elementosSalida(get(hObject,'Value'),:,:);
    c = permute(b,[1 3 2]);
    c = reshape(c,[],size(elementosSalida,2),1)';
    imshow(c,'Parent',handles.axes2);


% --- Executes during object creation, after setting all properties.
function listboxTratado_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxTratado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listboxOriginal.
function listboxOriginal_Callback(hObject, eventdata, handles)
% hObject    handle to listboxOriginal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxOriginal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxOriginal
    lista = strcat(get(handles.ruta,'string'),'\',get(hObject,'String'));
    imshow(imread(lista{get(hObject,'Value')}),'Parent',handles.axes3);


% --- Executes during object creation, after setting all properties.
function listboxOriginal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxOriginal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global elementosSalida; 
    set(handles.pushbutton1,'Enable','off')
    set(handles.listboxOriginal, 'String', '');
    set(handles.listboxTratado, 'String', '');
    guidata(hObject, handles);
    imagefiles = dir(strcat(get(handles.ruta,'string'),'\*.',get(handles.edit3,'string')));
    nfiles = length(imagefiles);
    ficheros = { imagefiles.name };
    salida = { imagefiles.name };
    ficherosIN = strcat(get(handles.ruta,'string'),'\',{ imagefiles.name });
    elementosSalida = Loop(ficherosIN, nfiles);
    set(handles.listboxOriginal, 'String', ficheros);
    set(handles.listboxTratado, 'String', 1:nfiles);
    set(handles.pushbutton1,'Enable','on')
    guidata(hObject, handles);
