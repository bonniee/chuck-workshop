SinOsc s => dac;
.4 => s.gain;
500 => s.freq;

for (0 => int i; i < 200; i++)
{
  s.freq() - 2 => s.freq;
  1::ms => now;
}

