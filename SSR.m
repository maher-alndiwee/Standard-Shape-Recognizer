function varargout = SSR(varargin)
% SSR MATLAB code for SSR.fig
%      SSR, by itself, creates a new SSR or raises the existing
%      singleton*.
%
%      H = SSR returns the handle to a new SSR or the handle to
%      the existing singleton*.
%
%      SSR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SSR.M with the given input arguments.
%
%      SSR('Property','Value',...) creates a new SSR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SSR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SSR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SSR

% Last Modified by GUIDE v2.5 02-May-2019 00:26:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SSR_OpeningFcn, ...
                   'gui_OutputFcn',  @SSR_OutputFcn, ...
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


% --- Executes just before SSR is made visible.
function SSR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SSR (see VARARGIN)

% Choose default command line output for SSR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.Image_Axes)
imshow('Shape Detector.jpg');

% UIWAIT makes SSR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SSR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global def_threshold gray_im bw aq_im
[name dir]=uigetfile({'*.jpg;*.jpeg;*.png;*.gif;*.bmp','All Image Files'});
if( name ~= 0)
full_name = [dir name];
aq_im = imread(full_name);
%aq_im =imread(full_name);

 gray_im1=rgb2gray(aq_im);            %convert to gray scall 
gray_im2 = medfilt2(gray_im1);        % apply median filter
se = strel('disk',1);
gray_im = imopen(gray_im2,se);      % to remove small noisy objects
 [bw def_threshold] =imthresh(gray_im);             %finding the suitable threshold 
def_threshold =def_threshold+40;  
 set(handles.thrsTxt,'String',num2str(def_threshold));
 set(handles.Threshold_Slider,'value',def_threshold);
axes(handles.Image_Axes)
imshow(aq_im)
end


% --- Executes on slider movement.
function Threshold_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 global gray_im bw
 threshold = get(handles.Threshold_Slider,'value');
 set(handles.thrsTxt,'String',num2str(threshold));
thresholder = threshold/255;
axes(handles.Image_Axes)
bw =im2bw(gray_im,thresholder);
imshow (bw)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Threshold_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function thrsTxt_Callback(hObject, eventdata, handles)
% hObject    handle to thrsTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 threshold =str2num(get(handles.thrsTxt,'String'));
 set(handles.Threshold_Slider,'value',threshold);
  global gray_im bw
thresholder = threshold/255;
axes(handles.Image_Axes)
bw =im2bw(gray_im,thresholder);
imshow (bw)

 
% Hints: get(hObject,'String') returns contents of thrsTxt as text
%        str2double(get(hObject,'String')) returns contents of thrsTxt as a double


% --- Executes during object creation, after setting all properties.
function thrsTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thrsTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ThresoldBush.
function ThresoldBush_Callback(hObject, eventdata, handles)
% hObject    handle to ThresoldBush (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global def_threshold bw gray_im
thresholder = def_threshold/255;
axes(handles.Image_Axes)
bw=im2bw(gray_im,thresholder);
 set(handles.thrsTxt,'String',num2str(def_threshold));
 set(handles.Threshold_Slider,'value',def_threshold);
imshow (bw)


% --- Executes on button press in DetectPB.
function DetectPB_Callback(hObject, eventdata, handles)
% hObject    handle to DetectPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bw aq_im
[B,L,N] = bwboundaries(bw,8); %Trace region boundaries in binary image
B=B(2:end,1);  % first object detected is the background
N= numel(B);
for i=1:N+1
    L(find(L==i))=i-1;  %remove background lable
end
 set(handles.NumTxt,'String',num2str(N));

%B :Boundaries
%L :lables (N when there is pixcel belong to N's object )
%N :Number of objects
%get stats
stats=  regionprops(L, 'Centroid', 'Area', 'Perimeter');
% perimeter is calculated by measuring the distance between each 
%adjoining pair of pixels around the border of the region

%% separating every parameter in array 
Centroid = cat(1, stats.Centroid);  
Perimeter = cat(1,stats.Perimeter);
Area = cat(1,stats.Area);

CircleMetric = (Perimeter.^2)./(4*pi*Area);  %circularity metric
SquareMetric = NaN(N,1);
TriangleMetric = NaN(N,1);
%for each boundary, fit to bounding box, and calculate some parameters

for k=1:N,
   boundary = B{k};
   [rx,ry,boxArea] = minboundrect( boundary(:,2), boundary(:,1));  %x and y are flipped in images
   %get width and height of bounding box ((rx,ry) 5 points [upper left,upper right
   %,lower right,lower left,upper left]) 
   width = sqrt( sum( (rx(2)-rx(1)).^2 + (ry(2)-ry(1)).^2));
   height = sqrt( sum( (rx(2)-rx(3)).^2+ (ry(2)-ry(3)).^2));
   aspectRatio = width/height;
   if aspectRatio > 1,  
       aspectRatio = height/width;  %make aspect ratio less than unity
   end
   SquareMetric(k) = aspectRatio;    %aspect ratio of box sides
   TriangleMetric(k) = Area(k)/boxArea;  %filled area vs box area
end
%define some thresholds for each metric
%do in order of circle, triangle, square, rectangle to avoid assigning the
%same shape to multiple objects
isCircle =   (CircleMetric < 1.1);
isTriangle = ~isCircle & (TriangleMetric < 0.6);  %equal or less than 0.5 but due to noisy pixels we chose 0.6
isSquare =   ~isCircle & ~isTriangle & (SquareMetric > 0.85); % perfectly =1 but due to noise we chose it experimentaly less greater than 0.85 
isRectangle= ~isCircle & ~isTriangle & ~isSquare;  %rectangle isn't any of these
%assign shape to each object
whichShape = cell(N,1);  
whichShape(isCircle) = {'Circle'};
whichShape(isTriangle) = {'Triangle'};
whichShape(isSquare) = {'Square'};
whichShape(isRectangle)= {'Rectangle'};
set(handles.CircelsTxt,'String',num2str(numel(isCircle(isCircle==1))));
set(handles.SquareTxt,'String',num2str(numel(isSquare(isSquare==1))));
set(handles.RectangelTxt,'String',num2str(numel(isRectangle(isRectangle==1))));
set(handles.TriangelTxt,'String',num2str(numel(isTriangle(isTriangle==1))));
%now label with results
%RGB = label2rgb(L);
axes(handles.Image_Axes)
%imshow(RGB); 
imshow(aq_im)
hold on;
for k=1:N
   %display metric values and which shape next to object
   %Txt = sprintf('C=%0.3f S=%0.3f T=%0.3f',  Combined(k,:));
  % text( Centroid(k,1)-20, Centroid(k,2), Txt);
   text( Centroid(k,1)-20, Centroid(k,2)+20, whichShape{k});
end
hold off


% --- Executes on button press in HelpPB.
function HelpPB_Callback(hObject, eventdata, handles)
% hObject    handle to HelpPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('1-Press Load Image then chose your image                              2-Chose threshold value or use default threshold                                   3-Press Detect to detect shapes and have fun...!!','Tips','help');
