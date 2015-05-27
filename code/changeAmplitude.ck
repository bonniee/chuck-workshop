SinOsc s => dac;
s.freq(Std.mtof(70));
s.gain(0);

for (0=> int i; i < 100; i++)
{
  s.gain(i * .01);
  10::ms => now;
}
