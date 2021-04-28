(
// --------------------------------------------------------------- //
// Before starting the oscillator, edit the following information. //
// --------------------------------------------------------------- //

s.options.outDevice_("TYPE INTERFACE KEY AS STRING HERE");
~outChannel = 0; // audio interface output channel (mono)
~amplitude = 0.7; // amplitude of pure tone (between 0 and 1)
~minimumFrequency = 15; // min. frequency of pure tone sweep
~maximumFrequency = 200; // max. frequency of pure tone sweep

// ---------------------------------------------------------- //
// To run, press Cmd + Enter (Mac) or Ctrl + Enter (Windows). //
// ---------------------------------------------------------- //

ServerTree.removeAll;

s.waitForBoot{

	SynthDef(\toneSweep, {
		arg minFreq=15, maxFreq=200, amp=0.7, out=0;
		var signal, sweep;
		sweep = SinOsc.kr(LFNoise1.kr(0.1).range(0.025,0.001), phase: 3pi/2);
		sweep = sweep.lincurve(-1, 1, minFreq, maxFreq);
		signal = SinOsc.ar(sweep) * amp;
		Out.ar(out, signal);
	}).add;

	s.sync;

	~tone = Synth(\toneSweep, [
		\out, ~outChannel,
		\amp, ~amplitude,
		\minFreq, ~minimumFrequency,
		\maxFreq, ~maximumFrequency
	])
};
)