package com.flashvisions.client.mobile.android.red5.red5rools.view.screens 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.ApplicationFacade;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.screens.base.Red5TestScreen;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.SharedObjectTestScreenMediator;
	import feathers.controls.Button;
	import feathers.controls.IScreen;
	import feathers.controls.LayoutGroup;
	import feathers.controls.PanelScreen;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleButton;
	import feathers.core.ITextEditor;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import starling.events.Event;
	
	CONFIG::LOGGING
	{
		import org.as3commons.logging.api.ILogger;
		import org.as3commons.logging.api.LOGGER_FACTORY;
		import org.as3commons.logging.api.LoggerFactory;
		import org.as3commons.logging.api.getLogger;
		import org.as3commons.logging.setup.SimpleTargetSetup;
		import org.as3commons.logging.setup.target.TraceTarget;
	}
	
	
	/**
	 * ...
	 * @author ...
	 */
	public class SharedObjectTestScreen extends Red5TestScreen implements IScreen
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(SharedObjectTestScreen);
		}
		
		private var btnConnect:ToggleButton;
		
		private var btnGetSo:Button;
		private var txtSoName:TextInput;
		
		private var btnSendText:Button;
		private var txtSoData:TextInput;
		
		private var txtOutput:TextInput;
		
		private var containerGroup1:LayoutGroup;
		private var containerGroup2:LayoutGroup
		
		
		public function SharedObjectTestScreen() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		
		
		private function onAddedToStage(e:Event):void
		{
			logger.info("onAddedToStage " + this);
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			ApplicationFacade.getInstance().registerMediator(new SharedObjectTestScreenMediator(this));
		}
		
		
		 
		private function onRemovedFromStage(e:Event):void
		{
			logger.info("onRemovedFromStage " + this);
			
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			ApplicationFacade.getInstance().removeMediator(SharedObjectTestScreenMediator.NAME);
		}
		
		
		
		
		override protected function initialize():void 
		{
			super.initialize();
			
			
			
			// set title
			this.title = "SHARED OBJECT TEST";
			
			
			
			// set layout
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 40;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			this.layout = layout;
			
			
			var rowLayoutData:VerticalLayoutData = new VerticalLayoutData();
			rowLayoutData.percentWidth = 90;
			
			
			
			btnConnect = new ToggleButton();
			btnConnect.label = "CONNECT";
			btnConnect.layoutData = rowLayoutData;
			btnConnect.addEventListener(Event.TRIGGERED, onConnect);
			addChild(btnConnect);
			
			
			
			{
				
				var containerGroup1LayoutData:HorizontalLayoutData = new HorizontalLayoutData();
				containerGroup1LayoutData.percentWidth = 50;	
				containerGroup1LayoutData.percentHeight = 100;	
				
				
				var soConnectorlayout:HorizontalLayout = new HorizontalLayout();
				soConnectorlayout.gap = 10;
				soConnectorlayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
				soConnectorlayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
				
				
				containerGroup1 = new LayoutGroup();
				containerGroup1.layout = soConnectorlayout;
				containerGroup1.layoutData = rowLayoutData;
				containerGroup1.height = 50;
				addChild(containerGroup1);
				
				
				txtSoName = new TextInput();
				txtSoName.prompt = "SO Name";
				txtSoName.layoutData = containerGroup1LayoutData;
				containerGroup1.addChild(txtSoName);
				
				
				btnGetSo = new Button();
				btnGetSo.label = "GET SO";
				btnGetSo.layoutData = containerGroup1LayoutData;
				containerGroup1.addChild(btnGetSo);
			}
			
			
			
			{
				var innerRowLayoutData:VerticalLayoutData = new VerticalLayoutData();
				innerRowLayoutData.percentWidth = 100;
				
			
				var soTranmitlayout:VerticalLayout = new VerticalLayout();
				soTranmitlayout.gap = 10;
				soTranmitlayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
				soTranmitlayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
				
				
				containerGroup2 = new LayoutGroup();
				containerGroup2.layout = soTranmitlayout;
				containerGroup2.layoutData = rowLayoutData;
				addChild(containerGroup2);
				
				
				
				txtSoData = new TextInput();
				txtSoData.prompt = "TEXT TO SEND";
				txtSoData.layoutData = innerRowLayoutData;
				txtSoData.textEditorFactory = function():ITextEditor
				{
					var editor:StageTextTextEditor = new StageTextTextEditor();
					editor.fontFamily = "Helvetica";
					editor.fontSize = 14;
					editor.multiline = true;
					editor.color = 0xffffff;
					return editor;
				}
				containerGroup2.addChild(txtSoData);
				
				
				
				btnSendText = new Button();
				btnSendText.label = "SEND DATA";
				btnSendText.layoutData = innerRowLayoutData;
				containerGroup2.addChild(btnSendText);				
			}
			
			
			
			var fillLayoutData:VerticalLayoutData = new VerticalLayoutData();
			fillLayoutData.percentHeight = 90;
			fillLayoutData.percentWidth = 90;
			
			
			txtOutput = new TextInput();
			txtOutput.isEditable = false;
			txtOutput.layoutData = fillLayoutData;
			txtOutput.textEditorFactory = function():ITextEditor
			{
				var editor:StageTextTextEditor = new StageTextTextEditor();
				editor.fontFamily = "Helvetica";
				editor.fontSize = 14;
				editor.multiline = true;
				editor.color = 0xffffff;
				return editor;
			}
			
			addChild(txtOutput);
		}
		
		
		
		override public function dispose():void 
		{
			logger.info("disposing screen " + this);
			
			btnConnect.removeEventListener(Event.TRIGGERED, onConnect);
			removeChild(btnConnect);
			
			
			containerGroup1.removeChild(txtSoName);
			containerGroup1.removeChild(btnGetSo);
			removeChild(containerGroup1);
			
			
			containerGroup2.removeChild(txtSoData);
			containerGroup2.removeChild(btnSendText);
			removeChild(containerGroup2);
			
			
			super.dispose();
		}
		
		
		
		private function onConnect(e:Event):void
		{
			
		}
	}

}