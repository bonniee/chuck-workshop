SinOsc osc => dac;

for (40 => int i; i < 80; i++)
{
  osc.freq(Std.mtof(i));
  500::ms => now;
}

