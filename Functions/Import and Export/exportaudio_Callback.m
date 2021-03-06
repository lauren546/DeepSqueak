function exportaudio_Callback(hObject, eventdata, handles)
%% Save the audio around the box to a WAVE file

% Convert audio to double
   audio = handles.data.calls.Audio{handles.data.currentcall};
if ~isfloat(audio)
    audio = double(audio) / (double(intmax(class(audio)))+1);
elseif ~isa(audio,'double')
    audio = double(audio);
end

% Get the relative playback rate
rate = inputdlg('Choose Playback Rate:','Save Audio',[1 50],{num2str(handles.data.settings.playback_rate)});
if isempty(rate)
    disp('Cancelled by User')
    return
end

% Convert relative rate to samples/second
rate = str2double(rate{:}) * handles.data.calls.Rate(handles.data.currentcall);

% Get the output file name
[~,detectionName] = fileparts(handles.current_detection_file);
audioname=[detectionName ' Call ' num2str(handles.data.currentcall) '.WAV'];
[FileName,PathName] = uiputfile(audioname,'Save Audio');
if isnumeric(FileName)
    return
end

% Save the file
audiowrite(fullfile(PathName,FileName),audio,rate);
