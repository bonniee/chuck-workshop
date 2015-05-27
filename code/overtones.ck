SinOsc s1 => dac;
s1.freq(440);
2::second => now;

SinOsc s2 => dac;
s2.gain(0.2);
s2.freq(880);
2::second => now;

// Now with SawOsc overtone
SawOsc s3 => dac;
s3.freq(220);
s3.gain(0.2);
2::second => now;

