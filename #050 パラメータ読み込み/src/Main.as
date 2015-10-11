package 
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.LocalConnection;
	import flash.external.ExternalInterface;

	import com.bit101.components.*;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage; 
	import flash.display.StageAlign; 
	import flash.display.StageScaleMode; 
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.system.fscommand;

// import flash.xml;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;


	/**
	 * 各種実験用。　
	 * 
	 * @author  
	 */


	public class Main extends Sprite 
	{
		// static var listener ;

		private var read_xml:XML ;
	// GUI 部品
		private var fullf:int; // フルスクリーンフラグ
		
		private var label:Label;
		
		private var panel1:Panel; // 左上マーカー
		private var pnl_g: Panel; // 絵張るパネル
		private var panel2:Panel; // 下側 棒
		private var panel3:Panel; // 右側 棒
		
		private var Button_1:PushButton;
		private var Button_2:PushButton;		
		private var Button_3:PushButton;
		private var Button_4:PushButton;
		private var Button_5:PushButton;
		
		   //イメージの埋め込み宣言
		private var imgObj01:Bitmap; // 
		private var imgObj02:Bitmap; //
		[Embed(source="../resoce/haikei.jpg", mimeType="image/jpeg")] private static const TestImage01:Class;
		[Embed(source="../resoce/chara.png" , mimeType="image/png")]  private static const TestImage02:Class;
	
		private var info : LoaderInfo ; 
		private var paramObj:Object;//◆
		private var myname:String;//ここに入れます
		private var myage:String;//ここに入れます 

		/**
		 * コンストラクタ
		 */
		public function Main():void 
		{
			//起動パラメータの処理
			info = stage.loaderInfo;
			paramObj = info.parameters;
			myname  =String(paramObj["param1"]); // Number 
			myage   = String(paramObj["param3"]); //◆ 
			
			
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

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
			
			//全体設定
			fullf = 0;
			stage.align =  StageAlign.TOP_LEFT; // "TL"; // 
			//stage.scaleMode = "noScale" ;
			//stage.align = "";
			stage.scaleMode = "noScale" ; // StageScaleMode.NO_BORDER;
			
			// リサイズされたときに呼び出されるイベント
			stage.addEventListener(Event.RESIZE, onResize);
			
			imgObj01  = new TestImage01(); 		
			imgObj02  = new TestImage02(); 		

			// パネルの準備
			panel1 = new Panel(this, 0, 0);
			panel1.setSize(30, 30);
			panel1.move( 2,2  );

			pnl_g = new Panel(this, 0, 0);
			pnl_g.setSize(  stage.stageWidth - 254   , stage.stageHeight - 36 );
			pnl_g.move( 300,10  );
			pnl_g.addChild(imgObj01);
			pnl_g.addChild(imgObj02);
			
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

			// ボタンの準備(右の)
			Button_1 = new PushButton(panel3, 4,  10, "", onButton_M);
			Button_1.label = "ここ、試験用";
			Button_1.width = 70;
			Button_2 = new PushButton(panel3, 4,  35, "", onButton_M);
			Button_2.label = "最大化";
			Button_2.width = 70;
			Button_3 = new PushButton(panel3, 4,  60, "", onButton_M);
			Button_3.label = "Debug";
			Button_3.width = 70;
			Button_4 = new PushButton(panel3, 4,  85, "", onButton_M);
			Button_4.label = "なし";
			Button_4.width = 70;
			Button_5 = new PushButton(panel3, 4, 110, "", onButton_M);
			Button_5.label = "なし";
			Button_5.width = 70;	
					
			// XML読み込みしてみる
			// xml_obj.ignoreWhite = true;
			init_load_xml( "../resoce/test.xml" );
			
			/* ============================================ */
			// フレーム開始イベントの登録
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/*
		*/
		
private function init_load_xml(url:String):void 
{

	var request:URLRequest = new URLRequest(url); //読み込むファイルのアドレス情報を作成
	var loader:URLLoader = new URLLoader(); 	//URLLoaderのインスタンスを作成
	loader.addEventListener(Event.COMPLETE, traceData); //読み込み完了後の処理を作成

	function traceData(event:Event){
		trace(loader.data);
		read_xml = new XML(event.target.data);	 //読み込んだ内容を元に，XMLデータを作成
	}
	// loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,trace); //読み込み失敗時の簡易処理を作成
	// loader.addEventListener(IOErrorEvent.IO_ERROR,trace);
	loader.load(request); //読み込みを開始
	
	
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
		
		/* 右ボタン群がクリックされた時のイベント*/
		private function onButton_M(e:MouseEvent):void 
		{
			if (       e.target.parent == Button_1 ) {
				label.text = "B1[" + myname +"][" +  myage +"]" ;		
				// read_xml.load("./test.xml");
			}else if ( e.target.parent == Button_2 ) {
			if ( fullf ) {
				fullf = 0;
				stage.displayState = "fullScreen";
				Button_2.label = "最小化";
			}else {
				fullf = 1;
				stage.displayState = "normal"; 
				Button_2.label = "最大化";
			}	
			}else if ( e.target.parent == Button_3 ) {
				var index_b:int = getChildIndex(pnl_g); 
				label.text = "Debug[" +index_b + "]["+  numChildren + "]" ;	 // getChildIndex(imgObj01)
			}else if ( e.target.parent == Button_4 ) {

			}else if ( e.target.parent == Button_5 ) {
				var msg = "";
				for (var i:int = 0; i< read_xml.staff.length() ;i++){
					msg += "        [" + (i+1)+"]"              + "\n" ;
					msg += "category:" + read_xml.staff[i].@category + "\n";
					msg += "filepath:" + read_xml.staff[i].@filepath + "\n";
					msg += "    name:" + read_xml.staff[i].name      + "\n";
					msg += " comment:" + read_xml.staff[i].comment   + "\n";
				}
				label.text = msg;
				
			}else {
				label.text = "不明["+"]";
			}
		
		}		

		private function onResize(e:Event):void
		{
			label.text = "Resizeされました[" + stage.stageWidth + "][" + stage.stageHeight + "]";
			
			pnl_g.setSize(  stage.stageWidth - 254 - 300 ,  stage.stageHeight - 36 -10 );
			pnl_g.move( 300 , 10 );
			//
			panel2.setSize(  stage.stageWidth - 4  , 30 );
			panel2.move(2, stage.stageHeight - 32 );
			
			panel3.setSize(  stage.stageWidth , stage.stageHeight - 34 );
			panel3.move( stage.stageWidth -102 , 0 );
		};
			
	}
	
}