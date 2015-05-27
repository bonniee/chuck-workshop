SinOsc s => dac;
SinOsc lfo => blackhole;

440 => s.freq;
5 => lfo.freq;
while (true)
{
  20::ms => now;
  (lfo.last() * 10) + 440 => s.freq;
}

