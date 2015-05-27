SinOsc s => Envelope e => dac;
s.freq(550);
e.keyOn();
2::second => now;
e.keyOff();
200::ms => now;

