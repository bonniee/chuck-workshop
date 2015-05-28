SinOsc osc => Envelope e => dac;
for (180 => int i; i > 40; i--)
{
  osc.freq(i);
  e.keyOn();
  200::ms => now;
  e.keyOff();
  100::ms => now;
}
2::second => now;
