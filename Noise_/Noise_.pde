import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import themidibus.*;

Minim minim;
AudioOutput out;
FFT fft;
Noise noise;
MoogFilter moog;
UGen currentUGen;
MidiBus myBus;

float cc[] = new float[256];// キーの値を格納する変数

void setup(){
  size(512, 200);
  minim = new Minim(this);
  out = minim.getLineOut();
  
  noise = new Noise(1.0, Noise.Tint.WHITE);
  moog = new MoogFilter(440, 0.5, MoogFilter.Type.LP);
  //noise.patch(out);
  noise.patch(moog).patch(out);
  
  myBus = new MidiBus(this, 0,0);
}

String type;
color c = color(255);
void draw(){
  background(0);

  textSize(12);
  text("noise type: " + noise.getTint(), 5, 15);
  
  if(moog.type == MoogFilter.Type.LP){
      LPfreq = map(cc[4], 0, 127, 100, 15000);
      LPrez = map(cc[20], 0, 127, 0, 1);
      moog.frequency.setLastValue(LPfreq);
      moog.resonance.setLastValue(LPrez);
  }
  if(moog.type == MoogFilter.Type.HP){
      HPfreq = map(cc[5], 0, 127, 100, 15000);
      HPrez = map(cc[21], 0, 127, 0, 1);
      moog.frequency.setLastValue(HPfreq);
      moog.resonance.setLastValue(HPrez);
  }
  
  stroke(c);
  strokeWeight(1);
  noFill();
  for(int i = 0; i < out.bufferSize() - 1; i++){
    line(i, 50 + out.left.get(i) * 50, i + 1,  50 + out.left.get(i + 1) * 50);
    line(i, 150 + out.right.get(i) * 50, i + 1,  150 + out.right.get(i + 1) * 50);
  }
}

float LPfreq, LPrez, HPfreq, HPrez;
void controllerChange(int channel, int number, int value){//この関数でキーの値を取得
    cc[number] = value;
    
    //switch(number){
    //  case 4:
    //    moog.type = MoogFilter.Type.LP;
    //    LPfreq = map(cc[4], 0, 127, 100, 15000);
    //    moog.frequency.setLastValue(LPfreq);
    //    break;
    //  case 5:
    //    moog.type = MoogFilter.Type.HP;
    //    HPfreq = map(cc[5], 0, 127, 100, 15000);
    //    moog.frequency.setLastValue(HPfreq);
    //    break;
    //}
    
    //switch(number){
    //  case 20:
    //    moog.type = MoogFilter.Type.LP;
    //    LPrez = map(cc[20], 0, 127, 0, 1);
    //    moog.resonance.setLastValue(LPrez);
    //    break;
    //  case 21:
    //    moog.type = MoogFilter.Type.HP;
    //    HPrez = map(cc[21], 0, 127, 0, 1);
    //    moog.resonance.setLastValue(HPrez);
    //    break;
    //}
    
    switch(number){
     case 32:
       noise.setTint(Noise.Tint.WHITE);
       break;
     case 33:
       noise.setTint(Noise.Tint.BROWN);
       break;
     case 34:
       noise.setTint(Noise.Tint.PINK);
       break;
     case 35:
       noise.setTint(Noise.Tint.RED);
       break;
     case 36:
       moog.type = MoogFilter.Type.LP;
       break;
     case 37:
       moog.type = MoogFilter.Type.HP;
       break;
    }

}