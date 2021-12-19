function symbol = dtmf_decodes(TouchToneDialler);

TouchToneDialler=TouchToneSim(['9','8','9','3','5','5','2','4','9','2'],10);

keys = ['1' '2' '3';'4' '5' '6'; '7' '8' '9'; '*' '0' '#'];

Fre_R = [697,770,852,941];

Fre_C = [1209,1336,1477];

fs = 8000;
n = length(TouchToneDialler);


figure(1);
plot(TouchToneDialler);
title('Unique signal genration for this key');
ylabel('Amplitude');
xlabel('Samples');


inc = fs/n;
f=0:inc:1500;

signalfft=abs(fft(TouchToneDialler));

signal_f = signalfft(1:length(f));

RLF = round(650/inc);
RUF = round(950/inc);
CLF = round(1200/inc);    
CUF = round(1500/inc);

fl = 650:inc:950;
signal_low = signal_f(RLF:RUF);
figure(2);
plot(fl,signal_low(1:length(fl)));
xlabel('Frequency');
ylabel('Magnitude');
title('Row Frequency Signal FFT');

fu = 1200:inc:1500;
signal_Up = signal_f(CLF:CUF);
figure(3);
plot(fu,signal_Up(1:length(fu)));
xlabel('Frequency in Hz');
ylabel('Magnitude');
title('Colomn Frequency Signal FFT');

[maxL,indexL] = max(signal_low);
[maxU,indexU] = max(signal_Up);

low_Freq = round(fl(indexL));
Up_Freq = round(fu(indexU));

lowDiff = abs(Fre_R - low_Freq);
upDiff = abs(Fre_C - Up_Freq);

[errorL,L] = min(lowDiff);
[errorU,U] = min(upDiff);

symbol = keys(L,U);