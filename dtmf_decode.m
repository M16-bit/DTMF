%Function Declaration
function output= dtmf_decode (op)

%CREATING AND PLOTTING FFT
Fs=8000; %Given sampling rate=8kHz
T=1/Fs;
L= length(op);
t=(0:L-1) * T;

figure; %Creates graph of the fft in a new dialog box
Y=fft(op); %Matlab Function to compute fft of signal 
%Two sided spectrum
P2= abs(Y/L); 
%Single sided spectrum
P1= P2(1:L/2+1); %spectrum Similar on both sides so we take only one
P1(2:end-1)= 2*P1(2:end-1);
%frequency domain f
f=Fs*(0:(L/2))/L; %So that plot is along frequency component
plot(f, P1); %Plot the single-sided fft
hold on;
xlabel("Frequency (Hz)"); %Labelling Axes
title("Single-sided FFT"); %Graph Title
hold off;

%GETTING SPIKES (FREQUENCIES)
I1=0; I2=0; %To get indexes of P1 where spikes can exist
for i=1:length(P1)
    if f(i)>=680 && I1==0 % 
        I1=i;
    end
    if f(i)>=960 && I2==0
        I2=i;
    end
end

h1=0; Flow=0; %To find the lower frequncy component (approximate)
for i=I1:I2 %Iterate along the frequency range 
    if P1(i)>h1 
        h1=P1(i);
        Flow=f(i);
    end
end
h1=0; Fhigh=0; %To find the higher frequncy component (approx)
for i=I2:length(P1)
    if P1(i)>h1
        h1=P1(i);
        Fhigh=f(i);
    end
end

%TO FIND ACTUAL FREQUENCY COMPONENTS FROM APPROXIMATES
if(Flow <734) %734=(697+770)/2
    Flow=697;
elseif (Flow <=811) %811=(770+852)/2
    Flow=770;
elseif (Flow <892) %892=(852+941)/2
    Flow=852;
else Flow=941;
end

if(Fhigh <1273) %1273=(1209+1406)/2
    Fhigh=1209;
elseif (Fhigh <1406) %1336=1406+1477)/2
    Fhigh=1336;
else Fhigh=1477;
end

%DECODES THE MESSAGE USING THE FREQ. FOUND OUT
switch Flow %Compares lower frequency
    case 697
        switch Fhigh %Compares higher frequency
            case 1209
                output='1';
            case 1336
                output='2';
            case 1477
                output='3';
        end
    case 770
        switch Fhigh %Compares higher frequency
            case 1209
                output='4';
            case 1336
                output='5';
            case 1477
                output='6';
        end
    case 852
        switch Fhigh %Compares higher frequency
            case 1209
                output='7';
            case 1336
                output='8';
            case 1477
                output='9';
        end
    case 941
        switch Fhigh %Compares higher frequency
            case 1209
                output='*';
            case 1336
                output='0';
            case 1477
                output='#';
        end
end