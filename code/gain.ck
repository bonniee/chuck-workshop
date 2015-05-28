SinOsc s1 => Gain g => dac;
SinOsc s2 => g;
s1.freq(Std.mtof(70));
s1.gain(0.9);
s2.freq(Std.mtof(72));
s2.gain(0.1);

g.gain(1);
for (200 => int i; i >= 0; i--)
{
  g.gain(i / 100.0);
  10::ms => now;
}
