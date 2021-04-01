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

% Last Modified by GUIDE v2.5 23-Dec-2020 06:39:36

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
% uiwait(handles.figure1)

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

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


% --- Executes on button press in Solve_Button.
function Solve_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Solve_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)[A,B,flag] = MatrixParser(get(handles.Equations_Input,'String'));

eqns=get(handles.Equations_Input,'String');
errorMessage='Invalid Input';
%out=get(handles.Result_Table,'Data');

%set(handles.Result_Table,'Data',out);
try
    set(handles.warning2,'String','');
    [A,B,symbols]=convert(eqns);
    numberOfEquations=size(eqns,1);
    indexP=get(handles.Precision_Menu,'Value');
    itemsP=get(handles.Precision_Menu,'String');
    Precision=itemsP{indexP};
    if strcmp(Precision,'default')
        Precision=16;
    else
        Precision=str2double(Precision);
    end
    if numberOfEquations~=str2double(get(handles.N_Equations_Input,'String'))
        errorMessage= [errorMessage,' -Invalid Number of equations'];
        error();
    end
    if numberOfEquations~=length(symbols)
        errorMessage=[errorMessage,''];
        error();
    end
    index=get(handles.Methods_Menu,'Value');
    items=get(handles.Methods_Menu,'String');
    method=items{index};
    answer=0;
    if strcmp(method,'Gauss Elimination')
        answer= gaussElimination(A,B,Precision);
    elseif strcmp(method,'Gauss Elimination using pivoting')
        answer=gaussEliminationWithPivoting(A,B,Precision);
    elseif strcmp(method,'Gauss Jordan')
        answer=gaussJordan(A,B,Precision);
    end
    if answer == 1 
            set(handles.warning2,'String','System has infinity number of solutions');
            return;
        elseif answer==2
            set(hanles.warning2,'String','System has no solution');
        return;
    end
    if strcmp(method,'LU Decomposition')
        indexLU=get(handles.LU_Menu,'Value');
        itemsLU=get(handles.LU_Menu,'String');
        format=itemsLU{indexLU};
        if strcmp(format,'Doolittle Form')
            answer=doolittleLU(A,B,Precision);
        elseif strcmp(format,'Crout Form')
            answer=croutLU(A,B,Precision);
        elseif strcmp(format,'Cholesky Form')
            
            if isSymmetric( A ) == 0
                set(handles.warning2,'String','Can not form Chelosky Decomposition As it is not Symmetric');
            end
            disp(format)
            if isPositiveDifiniteMatrix(A) == 0
                set(handles.warning2,'String','Can not form Chelosky Decomposition As it is not positive definite');
            end
            disp('Im here')
            answer=choleskyD(A,B,Precision);
            disp(answer)
        end
    end
    if answer==-1
        set(handles.warning2,'String','Can not form LU Decomposition');
        return;
    end
    if strcmp(method,'Gauss Seidil') ||strcmp(method,'Jacobi Iteration')
        indexSC=get(handles.Stopping_Condition_Menu,'Value');
        itemsSC=get(handles.Stopping_Condition_Menu,'String');
        SC=itemsSC{indexSC};
        %get guess input
        in=get(handles.Guess_Input,'String');
        if numberOfEquations ~= length(in)
            set(handles.warning2,'String','Invalid initial guess');
            return;
        end
        %in=splitlines(in);
        for i=1:length(in)
            x(i)=str2double(in(i,:));
        end
        x=transpose(x);
        %get num input
        num=get(handles.Stopping_Condition_Input,'String');
        if strcmp(num,'')
            warn=['Enter ',SC];
            set(handles.warning2,'String',warn);
            return;
        else
            num=str2double(num);
        end
        if strcmp(method,'Gauss Seidil')
            if strcmp(SC,'Number of iterations')
                [answer,converge]=Gauss_Seidel_iteration(A,B,x,num,Precision);
            else
                [answer,converge]=Gauss_Seidel_relativeError(A,B,x,num,Precision);
            end
        else
            if strcmp(SC,'Number of iterations')
                [answer,converge]=Jacobi_iterations(A,B,x,num,Precision);
            else
                [answer,converge]=Jacobi_relativeError(A,B,x,num,Precision);
            end
        end
        if converge
            set(handles.warning2,'String','It converges to the solution');
        else
            set(handles.warning2,'String','It does not converge to the solution');
        end
    end
    for i =1:size(answer,1)
        out(i,:) = [symbols(i),answer(i)];
    end
    set(handles.Result_Table,'Data',out);
catch e
    set(handles.warning2,'String',errorMessage);
end
%It ain't much but honest work


% --- Executes during object creation, after setting all properties.
function Result_Table_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Result_Table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'ColumnWidth',{50,200});
