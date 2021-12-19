%function declaration
function output= touch_tone_decoder (input)
output=[]; %Declaring array to store output
for i=1:length(input)/10:length(input)
    op= dtmf_decode(input(i:(i+length(input)/10)-2));
    output=[output op];
end
