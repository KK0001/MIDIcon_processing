import themidibus.*;
MidiBus myBus;
PImage img;

float cc[] = new float[256];// キーの値を格納する変数

void setup() {
  size(1200, 700);
  img = loadImage("sam.jpg");
  MidiBus.list();//接続されたMIDIキーボードの情報を表示
  //frameRate(60);
  myBus = new MidiBus(this, 0, 0);
}

//この関数でキーの値を取得
void controllerChange(int channel, int number, int value){
    cc[number] = map(value,0,127,1,500);
    println(channel);//複数のキーボードがある場合に選択できる
    println(number);//動かしたキーの番号を確認
    println(value);//動かしたキーの値を確認
    println((int)cc[0]);
}

void draw() {
  background(0);
  noStroke();
  
  // Mosaic
  int step = (int)cc[0];
  //画面の幅と高さでループ
  for (int j = 0; j < height; j += step) {
    for (int i = 0; i < width; i += step) {
      //座標を指定して色を取得
      color c = img.get(i, j);
      //取得した色を塗りの色にして四角形を描画
      fill(c);
      rect(i, j, step, step);
    }
  }
}