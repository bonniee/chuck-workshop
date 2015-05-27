SinOsc s1 => Gain multiplier => dac;
s1.freq(Std.mtof(66));
s1.gain(0.7);
multiplier.op(3); // Multiply, instead of adding ugens

SinOsc s2 => multiplier;
s2.freq(10);
s2.gain(0.5);

5::second => now;

