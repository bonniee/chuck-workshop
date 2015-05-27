UGen waves[4];
SinOsc sin => waves[0];
TriOsc tri => waves[1];
SawOsc saw => waves[2];
SqrOsc sqr => waves[3];

for (0 => int i; i < waves.cap(); i++)
{
  waves[i] => dac;
  1::second => now;
  waves[i] => blackhole;
}

