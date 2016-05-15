function DFDL_start()
% DFDL_start provides a Graphics User Interface for selecting paramaters 
% -----------------------------------------------
% Author: Tiep Vu, thv102@psu.edu, 5/15/2016 3:56:31 PM
%         (http://www.personal.psu.edu/thv102/)
% -----------------------------------------------
    close all;
    clc;
    addpath(genpath(pwd()));
    rng shuffle; % avoid the sam random numbers after restart matlab 
    f = figure('Visible', 'on', 'Resize', 'off', 'Position', [100, 50, 1050, 650]);        
    l1 = 20;
    w1 = 150;
    pars = [];
    %% =title
    info_panel = uipanel(f,...            
       'Title', '', ...
       'BackgroundColor', [0.8 0.8 0.8], ...
       'Position', [0.05,0.92,0.9,0.08], ...
       'BorderWidth', 0,...
       'FontSize', 20);
    text_title = uicontrol(...
        'Parent'             , info_panel, ...
        'Style'              , 'text', ...
        'FontSize'           , 20,...
        'BackGroundColor'    , [0.8, 0.8, 0.8], ...
        'HorizontalAlignment', 'center', ...
        'String'             , 'Histopathological Image Classification using DFDL', ...
        'ForeGroundColor'    , 'blue',...
        'Position'           , [10, 5, 1000, 40]);  
    %% == Panels================================
    hh.panel1 = uipanel(f, ...
        'Title'          , '1. Locate dataset', ...
        'FontSize'       , 11,...
        'BackgroundColor', [0.8 0.8 0.8], ...
        'Position'       , [.01, 0.77, 0.65, 0.15]);
    hh.panel2 = uipanel(f, ...
        'Title'          , '2. Choose number of training and test images', ...
        'FontSize'       , 11,...
        'Visible'        , 'off',...
        'BackgroundColor', [0.8 0.8 0.8], ...
        'Position'       , [.675, 0.77, 0.3, 0.15]);
    hh.panel3 = uipanel(f, ...
        'Title'          , '3. Choose other parameters', ...
        'FontSize'       , 11,...
        'BackgroundColor', [0.8 0.8 0.8], ...
        'Visible'        , 'off',...
        'Position'       , [.01, .49, 0.23, 0.27]);
    hh.panel4 = uipanel(f, ...
        'Title'          , '4. Choost imresize ratio', ...
        'FontSize'       , 11,...
        'BackgroundColor', [0.8 0.8 0.8], ...
        'Visible'        ,'off',...
        'Position'       , [.25, .11, 0.73, 0.65]);
    hh.panel5 = uipanel(f, ...
        'Title'          , 'Contact Information', ...
        'FontSize'       , 11,...
        'BackgroundColor', [0.8 0.8 0.8], ...
        'Visible'        ,'on',...
        'Position'       , [.01, .11, 0.23, 0.35]);
    hh.panel6 = uipanel(f, ...
        'Title'          , 'Related Publications', ...
        'FontSize'       , 11,...
        'BackgroundColor', [0.8 0.8 0.8], ...
        'Visible'        ,'on',...
        'Position'       , [.01, .01, 0.97, 0.1]);

    %% ========= Panel 1 ==============================
    hh.edittext_dir_1 = uicontrol(...
        'Style'              , 'text', ...
        'HorizontalAlignment', 'right', ...
        'Parent'             , hh.panel1, ...
        'String'             , '', ...
        'BackGroundColor'    , [0.8, 0.8, 0.8], ...
        'Position'           , [105, 48, 2.8*w1, 20]); 
    hh.edittext_nimg_1 = uicontrol(...
        'Style'   , 'text', ...
        'Parent'  , hh.panel1, ...
        'BackGroundColor'    , [0.8, 0.8, 0.8], ...
        'String'  , '', ...
        'Visible' , 'on', ...
        'Position', [500, 48, 90, 20]);   
    hh.edittext_ext_1 = uicontrol(...
        'Style'   , 'text', ...
        'Parent'  , hh.panel1, ...
        'BackGroundColor'    , [0.8, 0.8, 0.8], ...
        'String'  , '', ...
        'Visible' , 'on', ...
        'Position', [600, 48, 50, 20]);   
      hh.button_br_1  = uicontrol(...
        'Style'   , 'pushbutton', ...
        'Parent'  , hh.panel1, ...
        'String'  , 'Browse to Healthy class directory', ...
        'Position', [10, 48, 180, 25], ...
        'Callback', {@get_dir, hh, 1});
     
      hh.edittext_dir_2 = uicontrol(...
        'Parent'             , hh.panel1, ...
        'Style'              , 'text', ...
        'HorizontalAlignment', 'right', ...
        'String'             , '', ...
        'BackGroundColor'    , [0.8, 0.8, 0.8], ...
        'Position'           , [105, 7, 2.8*w1, 20]); 
           
     hh.edittext_nimg_2 = uicontrol(...
        'Style'   , 'text', ...
        'Parent'  , hh.panel1, ...
        'String'  , '', ...
        'BackGroundColor'    , [0.8, 0.8, 0.8], ...
        'Visible' , 'on', ...
        'Position', [500, 7, 90, 20]);      
        hh.edittext_ext_2 = uicontrol(...
        'Style'   , 'text', ...
        'Parent'  , hh.panel1, ...
        'BackGroundColor'    , [0.8, 0.8, 0.8], ...
        'String'  , '', ...
        'Visible' , 'on', ...
        'Position', [600, 7, 50, 20]);       
      hh.button_br_2  = uicontrol(...
        'Parent'  , hh.panel1, ...
        'Style'   , 'pushbutton', ...
        'Visible', 'on',...
        'String'  , 'Browse to Diseased class directory', ...
        'Position', [10, 7, 180, 25], ...
        'Callback', {@get_dir, hh, 2});
        % 'Callback', {@get_dir, hh.edittext_dir_2, hh.edittext_nimg_2,1});
      hh.edittext_nimg_2 = uicontrol(...
        'Parent'  , hh.panel1, ...
        'Style'   , 'text', ...
        'String'  , '', ...
        'Visible' , 'on', ...
        'Position', [l1 + w1 + 150, 360, 120, 15]);  

    %% == Panel 2================================ 
      hh.text_ntrain = uicontrol(...
        'BackgroundColor', [0.8 0.8 0.8], ...
        'Parent'         , hh.panel2, ...
        'Style'          , 'text', ...
        'String'         , '# training images per class', ...              
        'Position'       , [10, 45, 150, 20]); 
      hh.edittext_ntrain = uicontrol(...
        'Parent'  , hh.panel2, ...
        'Style'   , 'edit', ...
        'String'  , '10', ...
        'Visible' , 'on', ...
        'Position', [67, 15, 40, 25]);              
     hh.text_ntest = uicontrol(...
       'Parent'         , hh.panel2, 'Style', 'text', ...
       'BackgroundColor', [0.8 0.8 0.8], ...
       'String'         , '# test images', ...              
       'Position'       , [160, 45, 150, 20]); 
     hh.text_ntest1 = uicontrol(...
       'Parent'         , hh.panel2, ...
       'Style'          , 'text', ...
       'String'         , 'class 1', ...          
       'BackgroundColor', [0.8 0.8 0.8], ...
       'Position'       , [185, 30, 40, 15]);
     hh.text_ntest2 = uicontrol(...
       'BackgroundColor', [0.8 0.8 0.8], ...
       'Parent'         , hh.panel2, 'Style', 'text', ...
       'String'         , 'class 2', ...              
       'Position'       , [260, 30, 40, 15]);
     hh.edittext_ntest1 = uicontrol(...
       'Parent'  , hh.panel2, ...
       'Style'   , 'edit', ...
       'String'  , '10', ...
       'Visible' , 'on', ...
       'Position', [185, 15, 40, 15]); 
     hh.edittext_ntest2 = uicontrol(...
       'Parent'  , hh.panel2, ...
       'Style'   , 'edit', ...
       'String'  , '10', ...
       'Visible' , 'on', ...
       'Position', [260, 15, 40, 15]);               

      %% == Panel 3 ================================              
     hh.text_train_ptchs = uicontrol(...
       'Parent'             , hh.panel3, ...
       'BackgroundColor'    , [0.8 0.8 0.8], ...
       'Style'              , 'text', ...
       'HorizontalAlignment', 'left', ...
       'String'             , '# training patches per class', ...
       'Position'           , [10, 130, w1, 18]); 
      hh.edittext_train_ptchs = uicontrol(...
        'Parent'  , hh.panel3, ...
        'style'   , 'edit', ...
        'position', [5+w1, 130, 50, 20], ...         
        'string'  , '10000');       
           
      hh.text_train_bases = uicontrol(...
        'Parent'             , hh.panel3, ...
        'Style'              , 'text', ...
        'BackgroundColor'    , [0.8 0.8 0.8], ...
        'HorizontalAlignment', 'left', ...
        'String'             , '# training bases per dict', ...
        'Position'           , [10, 100, w1, 18]);
      hh.edittext_train_bases = uicontrol(...
        'Parent'  , hh.panel3, ...
        'style'   , 'edit', ...
        'position', [w1+5, 100, 50, 20], ...         
        'string'  , '100');
      hh.text_patchsize = uicontrol(...
        'Parent'             , hh.panel3, ...
        'Style'              , 'text', ...
        'HorizontalAlignment', 'left', ...
        'BackgroundColor'    , [0.8 0.8 0.8], ...
        'String'             , 'Patch size', ...
        'Position'           , [10, 70, w1, 18]);
     hh.edittext_patchsize = uicontrol(...
        'Parent'  , hh.panel3, ...
        'style'   , 'edit', ...    
        'position', [w1+5, 70, 50, 20], ...         
        'string'  , '20');
     hh.text_rho = uicontrol(...
        'Parent'             , hh.panel3, ...
        'Style'              , 'text', ...
        'HorizontalAlignment', 'left', ...
        'BackgroundColor'    , [0.8 0.8 0.8], ...
        'String'             , 'rho', ...
        'Position'           , [10, 40, w1, 18]);
     hh.edittext_rho = uicontrol(...
        'Parent'  , hh.panel3, ...
        'style'   , 'edit', ...    
        'position', [w1+5, 40, 50, 20], ...         
        'string'  , '0.001');
     %% == Panel 4: choosing imresize ratio =========
      hh.text_wait = uicontrol(...
        'Style'              , 'text', ...
        'HorizontalAlignment', 'center', ...
        'Parent'             , hh.panel4, ...
        'Visible'            , 'off',...
        'String'             , 'Please wait a few seconds...', ...
        'FontSize'           , 20,...
        'BackGroundColor'    , [0.8, 0.8, 0.8], ...
        'Position'           , [195, 176, 2.5*w1, 50]);   
      hh.axes1 = axes(...  % Axes for plotting the selected plot
        'Parent'          , hh.panel4, ...
        'Units'           , 'normalized', ...
        'Visible'         , 'off', ...
        'HandleVisibility', 'callback', ...
        'Position'        , [0.0 0.02 0.48 0.850]);
     hh.axes2 = axes(...  % Axes for plotting the selected plot
       'Parent'          , hh.panel4, ...
       'Units'           , 'normalized', ...
       'Visible'         , 'off', ...
       'HandleVisibility', 'callback', ...
       'Position'        , [0.50 0.02 0.48 0.850]);
    hh.imresize = uicontrol(...
        'Parent'  , hh.panel4, ...
        'style'   , 'text', ...    
        'BackGroundColor', [0.8, 0.8, 0.8], ...
        'position', [30, 360, 50, 20], ...         
        'string'  , '0.5');
    uicontrol(...
        'Parent'  , hh.panel4, ...
        'style'   , 'text', ...
        'BackgroundColor'    , [0.8 0.8 0.8], ...
        'position', [100, 380, 450, 20], ...         
        'string'  , 'Move the slider bar below until you see a significant diference between classes');
     hh.sld = uicontrol(...
        'Parent', hh.panel4, ...
        'Style', 'slider', ...
        'Min', 0, 'Max', 1, 'Value', 0.5, ...
        'Position', [100, 360, 450, 20], ...
        'Callback', {@get_imresize, hh, pars}); 

     hh.button_buildpatches = uicontrol(...
       'Parent'  , hh.panel4, ...
       'Style'   , 'pushbutton', ...
       'String'  , 'Run DFDL', ...
       'Visible' , 'on', ...
       'Callback', {@call_DFDL_main, pars, hh}, ...
       'Position', [585, 360, 100, 35]);   
     
      hh.button_hpatch_view = uicontrol(...
       'Parent'  , hh.panel3, ...
       'Style'   , 'pushbutton', ...
       'String'  , 'View sample patches', ...
       'Callback', {@update_pars, hh, pars}, ...
       'Position', [55, 3, 130, 25]);   

    %% ================== block: Contact info ==========================
      uicontrol(...
        'Parent'  , hh.panel5, ...
        'Style'   ,'text',...
        'Position',[50 110 150 25],...
        'BackgroundColor', [0.8, 0.8, 0.8],...
        'FontSize', 14,...
        'String'  ,'Tiep H. Vu');
        
      uicontrol(...
        'Parent'  , hh.panel5, ...
        'Style'   ,'pushbutton',...
        'Position',[50 80 150 25],...
        'String'  ,'Email: thv102@psu.edu',...
        'Callback',@(hObject,eventData) web('mailto:thv102@psu.edu'));
      uicontrol(...
        'Parent'  , hh.panel5, ...
        'Style'   ,'pushbutton',...
        'Position',[50 50 150 25],...
        'String'  ,'Go to DFDL webpage!',...
        'Callback',@(hObject,eventData) web('signal.ee.psu.edu/dfdl.html'));
      uicontrol(...
        'Parent'  , hh.panel5, ...
        'Style'   ,'pushbutton',...
        'Position',[50 15 150 25],...
        'String'  ,'Copyright',...
        'Callback',@DFDL_copyright);
      hh.axes3 = axes(...     
          'Parent'  , hh.panel5, ...
          'Units'   , 'normalized', ...
          'Visible' , 'off', ...
          'Position', [0.06 0.56 0.88 0.50]);
      axes(hh.axes3);
      % f = imread('gui/ipal.png');
      f = imread('gui/ipal.jpg');
      imshow(f);
%% ================== block: Related Publications ==========================
   uicontrol(...
    'Parent'             , hh.panel6, ...
    'Style'              ,'text',...
    'HorizontalAlignment', 'left',...
    'Position'           ,[2 20 1010 20],...
    'BackgroundColor'    , [0.8, 0.8, 0.8],...
    'FontSize'           , 9,...
    'String'             ,'1. Tiep H. Vu, H. S. Mousavi, V. Monga, A. U. Rao and G. Rao. "DFDL: Discriminative Feature-Oriented Dictionary Learning For Histopathological Image Classification", ISBI 2015'); 
uicontrol(...
    'Parent'             , hh.panel6, ...
    'Style'              ,'text',...
    'HorizontalAlignment', 'left',...
    'Position'           ,[2 3 1010 20],...
    'BackgroundColor'    , [0.8, 0.8, 0.8],...
    'FontSize'           , 9,...
    'String'             ,'1. Tiep H. Vu, H. S. Mousavi, V. Monga, A. U. Rao and G. Rao. " Histopathological Image Classification using Discriminative Feature-Oriented Dictionary Learning", TMI, March 2016'); 
end

function update_pars(~, ~, hh, pars)
    pars = init_pars(pars, hh);
    set(hh.button_buildpatches, 'Visible', 'on');
    set(hh.panel4, 'Visible', 'on');
    viewPatches(pars, hh);
end  

function call_DFDL_main(~,~, pars, hh)
    pars = init_pars(pars,hh);
    DFDL_main(pars);
end