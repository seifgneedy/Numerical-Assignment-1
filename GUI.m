function varargout = GUI(varargin)
% GUI MATLAB code for untitled.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 20-Dec-2020 20:41:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

% --- Executes just before untitled is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in N_Equations_button.
function N_Equations_button_Callback(hObject, eventdata, handles)
% hObject    handle to N_Equations_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=get(handles.N_Equations_Input,'String');
string_contains_numeric = @(S) ~isnan(str2double(S));
if strcmp(str,'')
    return;
elseif ~string_contains_numeric(str)
        set(handles.warning1,'String','invalid input in number of equations section');
else    
    set(handles.warning1,'String','enter equtions and method');
    set(handles.Equations_Input,'Max',str2double(str));
end






function N_Equations_Input_Callback(hObject, eventdata, handles)
% hObject    handle to txtArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%    set(handles.Equations_Input,'Max',str2double(handles.txtArea.value))

% Hints: get(hObject,'String') returns contents of txtArea as text
%        str2double(get(hObject,'String')) returns contents of txtArea as a double


% --- Executes during object creation, after setting all properties.
function N_Equations_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes when uipanel1 is resized.
function uipanel1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in Methods_Menu.
function Methods_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Methods_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Methods_Menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Methods_Menu
set(handles.LU_Text,'Visible','off');
set(handles.LU_Menu,'Visible','off');
set(handles.Guess_Panel,'Visible','off');
set(handles.Guess_Input,'Visible','off');
set(handles.Guess_Instruction,'Visible','off');
set(handles.Stopping_Condition_Text,'Visible','off');
set(handles.Stopping_Condition_Menu,'Visible','off');
set(handles.Stopping_Condition_Input,'Visible','off');
index=get(handles.Methods_Menu,'Value');
items=get(handles.Methods_Menu,'String');
selectedItem=items{index};
if strcmp(selectedItem,'LU Decomposition')
    set(handles.LU_Text,'Visible','on');
    set(handles.LU_Menu,'Visible','on');
elseif strcmp(selectedItem,'Gauss Seidil') || strcmp(selectedItem,'Jacobi Iteration')
    set(handles.Guess_Panel,'Visible','on');
    set(handles.Guess_Input,'Visible','on');
    set(handles.Guess_Instruction,'Visible','on');
    set(handles.Stopping_Condition_Text,'Visible','on');
    set(handles.Stopping_Condition_Menu,'Visible','on');
    set(handles.Stopping_Condition_Input,'Visible','on');
end



% --- Executes during object creation, after setting all properties.
function Methods_Menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Methods_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Equations_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Methods_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function Equations_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Equations_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Equations_Input as text
%        str2double(get(hObject,'String')) returns contents of Equations_Input as a double


% --- Executes during object creation, after setting all properties.


% --- Executes on selection change in LU_Menu.
function LU_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to LU_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LU_Menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LU_Menu


% --- Executes during object creation, after setting all properties.
function LU_Menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LU_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Guess_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Guess_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Guess_Input as text
%        str2double(get(hObject,'String')) returns contents of Guess_Input as a double


% --- Executes during object creation, after setting all properties.
function Guess_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Guess_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Stopping_Condition_Menu.
function Stopping_Condition_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Stopping_Condition_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Stopping_Condition_Menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Stopping_Condition_Menu


% --- Executes during object creation, after setting all properties.
function Stopping_Condition_Menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stopping_Condition_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Stopping_Condition_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Stopping_Condition_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Stopping_Condition_Input as text
%        str2double(get(hObject,'String')) returns contents of Stopping_Condition_Input as a double


% --- Executes during object creation, after setting all properties.
function Stopping_Condition_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stopping_Condition_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Solve_Button.
function Solve_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Solve_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)[A,B,flag] = MatrixParser(get(handles.Equations_Input,'String'));
eqns=get(handles.Equations_Input,'String');
errorMessage='Invalid Input';
try
    set(handles.warning2,'String','');
    [A,B,symbols]=convert(eqns);
    numberOfEquations=size(eqns,1);
    if numberOfEquations~=str2double(get(handles.N_Equations_Input,'String'))
        errorMessage= [errorMessage,' -Invalid Number of equations'];
        error();
    end
    %to be continued
    disp(A)
    disp(length(A))
    disp(B)
    disp(symbols)
catch e
    set(handles.warning2,'String',errorMessage);
end
    
