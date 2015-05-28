SinOsc osc => dac;

fun void slide(int start, int end, int len)
{
  start - end => int gap;
  gap / 200.0 => float step;
  len / 200.0 => float wait;

  osc.gain(1);
  osc.freq(start);
  for (0 => int i; i < 200; i++)
  {
    osc.freq(osc.freq() - step);
    wait::ms => now;
  }
  osc.gain(0);
}

while (true)
{
  slide(200, 50, 150);
  slide(200, 50, 500);
  slide(50, 200, 500);
  slide(100, 300, 500);
  slide(300, 50, 150);
}
