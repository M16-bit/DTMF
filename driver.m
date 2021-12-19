input=[];
arr=[];
check=[];
for i=1:6
    x1= randi(12)-1; %Generates random number from 0 to 11
    if(x1==10) ip='*'; %Puts 10="*"
    elseif (x1==11) ip='#'; %Puts 11="#"
    else ip=int2str(x1); %Converts numeral to character
    end
    arr=TouchToneDialler(ip, 1);
    input = [input arr];
    check=[check ip];%Concatenates to make 10-digit phone number
end
output = touch_tone_decoder(input);