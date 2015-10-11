package 
{
	import com.bit101.components.*;
	import flash.display.Sprite;
	import flash.display.Stage; 
	import flash.display.StageAlign; 
	import flash.display.StageScaleMode; 
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.system.fscommand;
//	import fl.controls.Button;
// import flash.xml;

import flash.events.Event; 

	/**
	 * 各種実験用。　ベースはMinimalComps 
	 * 
	 * MinimalComps は、クリエイティブコモンズの
	 * 
	 * ・GUI 部品デザイナ
	 * (視覚的に部品を配置してソースコードを出力できます)
	 * http://www.bit-101.com/MinimalDesigner/
	 * 
	 * 
	 * @author Hikipuro
	 */
	public class Main extends Sprite 
	{
		// static var listener ;
		private var xml_obj:XML ;
	// GUI 部品
		private var fullf:int; // フルスクリーンフラグ
		
		private var pushbutton:PushButton;
		private var pushbutton2:PushButton;
		// private var checkBox:CheckBox;
		private var hSlider:HSlider;
		private var labelHSlider:Label;
		// private var inputText:InputText;
		// private var progressBar:ProgressBar;
		private var label:Label;
		
		private var panel1:Panel; // 左上マーカー
		private var panel2:Panel; // 下側 棒
		private var panel3:Panel; // 右側 棒
				
		private var Button_1:PushButton;
		private var Button_2:PushButton;
		private var Button_3:PushButton;
		private var Button_4:PushButton;
		
		/**
		 * コンストラクタ
		 */
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		/*
		 public function OnResize(eventObj:e)
		{
			trace("w:" + stage.width);trace("h:" + stage.height);
		};
		*/
		/**
		 * 初期化イベント
		 * @param	e
		 */
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			// 言語の設定
			Locale.language = "ja";
			xml_obj = new XML();
			xml_obj.ignoreWhite = true;
			init_load_xml();
			
			//全体設定
			fullf = 0;
			stage.align =  StageAlign.TOP_LEFT; // "TL"; // 
			//stage.scaleMode = "noScale" ;
			//stage.align = "";
			stage.scaleMode = "noScale" ; // StageScaleMode.NO_BORDER;
			
			// リサイズされたときに呼び出されるイベント
			stage.addEventListener(Event.RESIZE, onResize);
			
			// パネルの準備
			panel1 = new Panel(this, 0, 0);panel1.setSize(30, 30);
			panel2 = new Panel(this, 0 , 0);
			panel2.setSize(  stage.stageWidth - 4  , 30 );
			panel2.move(2, stage.stageHeight - 32 );
			
			panel3 = new Panel(this, 0 , 0);
			panel3.setSize(  stage.stageWidth , stage.stageHeight - 34 );
			panel3.move( stage.stageWidth -102 , 0 );
			
			// チェックボックスの準備
			// checkBox = new CheckBox(panel, 20, 20, "", onCheckBoxClick); checkBox.label = "チェックボックス";
			
			// ラベルの準備
			label = new Label(this, 20, 140);
			label.text = "これはラベルです"+stage.stageWidth +"]["+stage.stageHeight+"]";

			// ボタンの準備
			pushbutton = new PushButton(this, 20, 60, "", onPushButtonClick);
			pushbutton.label = "押しボタン";
			pushbutton.width = 100;

			pushbutton2 = new PushButton(panel2, 50, 4, "", onButtonMax);
			pushbutton2.label = "最大化";
			pushbutton2.width = 70;
			// ボタンの準備(右の)
			Button_1 = new PushButton(panel3, 4, 10, "", onButton_M);
			Button_1.label = "b1";
			Button_1.width = 70;
			Button_2 = new PushButton(panel3, 4, 35, "", onButton_M);
			Button_2.label = "b2";
			Button_2.width = 70;
			Button_3 = new PushButton(panel3, 4, 60, "", onButton_M);
			Button_3.label = "b3";
			Button_3.width = 70;
			Button_4 = new PushButton(panel3, 4, 85, "", onButton_M);
			Button_4.label = "b4";
			Button_4.width = 70;
			
			
			// 横方向スライダーの準備
			hSlider = new HSlider(this, 20, 90);
			hSlider.addEventListener(Event.CHANGE, onHSliderChange);
			labelHSlider = new Label(this, 60, 100);
			labelHSlider.text = "0.0";

			// 縦方向スライダーの準備
			// var vSlider:VSlider = new VSlider(panel, 130, 20);

			// テキスト入力ボックスの準備
			// inputText = new InputText(panel, 20, 130); inputText.width = 120;inputText.text = "テキスト入力";     

			// プログレスバーの準備
			// progressBar = new ProgressBar(panel, 160, 130);progressBar.maximum = 100;

			// ラジオボタンの準備
			// var radio1:RadioButton = new RadioButton(panel, 160, 20, "", false, onRadioButtonClick); radio1.label = "ラジオボタン 1";
			// var radio2:RadioButton = new RadioButton(panel, 160, 40, "", false, onRadioButtonClick); radio2.label = "ラジオボタン 2";
			// var radio3:RadioButton = new RadioButton(panel, 160, 60, "", false, onRadioButtonClick);radio3.label = "ラジオボタン 3";

			// 色選択ボックスの準備
			// var colorchooser:ColorChooser = new ColorChooser(panel, 160, 90);colorchooser.value = 0xff0000;
			
			// 作者様の情報
			var labelAuther:Label = new Label(this, 20, 160);
			labelAuther.text = "Keith Peters さんが作られた MinimalComps というライブラリを\n使用して GUI 部品を表示しています。";
			
			// フレーム開始イベントの登録
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/*
		*/
		
private function init_load_xml():void 
{

	xml_obj.onLoad = function (check:Boolean)
	{

	if(check){
		label.text =("読み込みが完了して変数にアクセスが可能");
	}else{
		label.text = ("読み込み失敗");
		return;
	}

	if (xml_obj.loaded) {
		label.text = ("load()を使った読み込み終了");
	} else {
		label.text = ("load()を使った読み込み失敗");
		return;
	}

	if(xml_obj.status == 0){
		label.text = ("解析が正常に終了しました。");
	}else if(xml_obj.status == -2){
		label.text = ("CDATA セクションが適切に終了されていません。");
	}else if(xml_obj.status == -3){
		label.text = ("XML 宣言が適切に終了されていません。");
	}else if(xml_obj.status == -4){
		label.text = ("DOCTYPE 宣言が適切に終了されていません。");
	}else if(xml_obj.status == -5){
		label.text = ("コメントが適切に終了されていません。");
	}else if(xml_obj.status == -6){
		label.text = ("XML エレメントの形式が正しくありませんでした。");
	}else if(xml_obj.status == -7){
		label.text = ("メモリ不足です。");
	}else if(xml_obj.status == -8){
		label.text = ("属性値が適切に終了されていません。");
	}else if(xml_obj.status == -9){
		label.text = ("開始タグに対応する終了タグがありません。");
	}else if(xml_obj.status == -10){
		label.text = ("対応する開始タグのない終了タグが見つかりました。");
	}
	};
	
	// xml_obj.load("./test.xml");
}
			
		
		/**
		 * フレーム開始イベント
		 * @param	e
		 */
		private function onEnterFrame(e:Event):void 
		{
			// プログレスバーの更新
			// progressBar.value++; if (progressBar.value == progressBar.maximum) {progressBar.value = 0;}
		}
		
		/**
		 * チェックボックスがクリックされた時のイベント
		 * @param	e
		 */
		// private function onCheckBoxClick(e:MouseEvent):void {if (checkBox.selected == false) {inputText.text = "チェックが消えました";} else {inputText.text = "チェックが付きました";}}
		
		/**
		 * ラジオボタンがクリックされた時のイベント
		 * @param	e
		 */
		/*
		private function onRadioButtonClick(e:MouseEvent):void 
		{
			var radio:RadioButton = e.currentTarget as RadioButton;
			switch (radio.label) {
				case "ラジオボタン 1":
					inputText.text = "ラジオボタン 1 が選択されました";
					break;
				case "ラジオボタン 2":
					inputText.text = "ラジオボタン 2 が選択されました";
					break;
				case "ラジオボタン 3":
					inputText.text = "ラジオボタン 3 が選択されました";
					break;
			}
		}
		*/
		
		/* ボタン1 がクリックされた時のイベント*/
		private function onPushButtonClick(e:MouseEvent):void 
		{
			// inputText.text = "ボタンがクリックされました";
			label.text = "ボタンがクリックされました["+stage.stageWidth+"]["+stage.stageHeight+"]";
		}
		/* ボタン2 がクリックされた時のイベント*/
		private function onButtonMax(e:MouseEvent):void 
		{
			if ( fullf ) {
				fullf = 0;
				stage.displayState = "fullScreen";
				pushbutton2.label = "最小化";
			}else {
				fullf = 1;
				stage.displayState = "normal"; 
				pushbutton2.label = "最大化";
			}		
		}
		
		/* 右ボタン群がクリックされた時のイベント*/
		private function onButton_M(e:MouseEvent):void 
		{
			if (       e.target.parent == Button_1 ) {
				label.text = "B1" ;		
				xml_obj.load("./test.xml");
			}else if ( e.target.parent == Button_2 ) {
				label.text = "B2";	
			}else if ( e.target.parent == Button_3 ) {
				label.text = "B3";	
			}else if ( e.target.parent == Button_4 ) {
				label.text = "B4";	
			}else {
				label.text = "不明["+"]";
			}
		}		
		/**
		 * 横方向のスライダーが変更された時のイベント
		 * @param	e
		 */
		private function onHSliderChange(e:Event):void 
		{
			labelHSlider.text = hSlider.value.toFixed(1);
		}
		private function onResize(e:Event):void
		{
			label.text = "Resizeされました[" + stage.stageWidth + "][" + stage.stageHeight + "]";
			//
			panel2.setSize(  stage.stageWidth - 4  , 30 );
			panel2.move(2, stage.stageHeight - 32 );
			
			panel3.setSize(  stage.stageWidth , stage.stageHeight - 34 );
			panel3.move( stage.stageWidth -102 , 0 );
		};
			
	}
	
}