package carn
{
	import flash.net.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.display.*;
	
	public class Registration extends EventDispatcher
	{
		public static const INPUT_TEXT						:String = 'input_text';
		public static const PASSWORD						:String = 'password';
		public static const UNFILLED_DATA_EVENT				:String = 'unfilled_data';
		public static const INFO_SENT_EVENT					:String = 'info_sent';
		
		private const FIELDS								:Dictionary = new Dictionary(true);
		private const CHECKBOX_GROUPS						:Dictionary = new Dictionary(true);
		
		private var _submit_button							:InteractiveObject;
		
		protected var _url_request							:URLRequest;
		protected var _url_variables						:URLVariables;
		protected var _url_loader							:URLLoader;
		
		protected var _unfilled_mandatory_fields			:Vector.<Object> 
		protected var _unchecked_mandatory_checkboxes		:Vector.<Object> 
		
		public function Registration(submit_url_:String, submit_button_:InteractiveObject = null, method_:String = URLRequestMethod.POST, clear_button_:InteractiveObject = null ) : void
		{
			_url_request = new URLRequest(submit_url_);
			_url_request.method = method_;
			
			_url_variables = new URLVariables();
			_url_request.data = _url_variables;
			
			_url_loader = new URLLoader();
			_url_loader.addEventListener(Event.COMPLETE, onInfoSent);
			_url_loader.addEventListener(IOErrorEvent.IO_ERROR, onInputOutputError);
			
			if ( submit_button_)
			{
				_submit_button = submit_button_;
				toggleSubmitButton(true);
			}
		}
		
		public function get url_loader() : URLLoader
		{
			return _url_loader;
		}
		
		public function get unfilled_mandatory_fields() : Vector.<Object>
		{
			return _unfilled_mandatory_fields;
		}
		
		public function get unchecked_mandatory_checkboxes() : Vector.<Object>
		{
			return _unchecked_mandatory_checkboxes;
		}
		
		public function get text_fields() : Dictionary
		{
			return FIELDS;
		}
		
		public function addData(key_:String, value_:Object) : void
		{
			_url_variables[key_] = value_;
		}
		
		public function addField(field_:TextField, type_:String, id_:String, field_is_mandatory_:Boolean, default_value_:String = null ) : void
		{
			FIELDS[id_] = { field: field_, type: type_, mandatory: field_is_mandatory_, default_value: default_value_ };
		}
		
		public function addCheckboxGroup(group_id_:String, checkboxes:Vector.<Object>, group_is_mandatory_:Boolean, default_value_:String = null) : void
		{
			CHECKBOX_GROUPS[group_id_] = { checkboxes: checkboxes, mandatory: group_is_mandatory_, checked_id: default_value_, default_value: default_value_ };
			
			var checkbox_info:Object
			for each ( checkbox_info in checkboxes) 
			{
				checkbox_info.checkbox.addEventListener(MouseEvent.CLICK, onCheckbox);
			}
		}
		
		private function onCheckbox(click_event_:MouseEvent):void 
		{
			var clicked_checkbox:Object = click_event_.target;
			
			var item			:Object;
			var checkbox_info	:Object;
			
			for each ( item in CHECKBOX_GROUPS ) 
			{
				for each ( checkbox_info in item.checkboxes )
				{
					if ( checkbox_info.checkbox == clicked_checkbox )
					{
						item.checked_id = item.checked_id == checkbox_info.id ? item.default_value : checkbox_info.id;
					}
				}
			}
		}
		
		protected function onSubmitButton(mouse_click_event_:MouseEvent) : void
		{
			toggleSubmitButton(false);
			
			submitRegistration();
		}
		
		public function submitRegistration() : void
		{
			_unfilled_mandatory_fields		= new Vector.<Object>;
			_unchecked_mandatory_checkboxes	= new Vector.<Object>;
			
			var field_info			:Object;
			var checkbox_group_info	:Object
			var key					:String;
			
			for ( key in FIELDS )
			{
				field_info = FIELDS[key];
				
				if ( field_info.mandatory && ( field_info.field.text == '' || field_info.field.text == field_info.default_value ) )
				{
					_unfilled_mandatory_fields.push(field_info.field);
				} else {
					_url_variables[key] = field_info.field.text;
				}
			}
			
			for ( key in CHECKBOX_GROUPS ) 
			{
				checkbox_group_info = CHECKBOX_GROUPS[key];
				if ( !checkbox_group_info.checked_id && checkbox_group_info.mandatory )
				{
					_unchecked_mandatory_checkboxes.push(checkbox_group_info.checkboxes);
				} else {
					_url_variables[key] = checkbox_group_info.checked_id;
				}
			}
			
			trace(_url_variables);
			
			if ( _unfilled_mandatory_fields.length || _unchecked_mandatory_checkboxes.length )
			{
				dispatchEvent(new Event(UNFILLED_DATA_EVENT));
				toggleSubmitButton(true);
			} else {
				_url_loader.load(_url_request);
			}
		}
		
		private function onInfoSent(complete_event_:Event):void 
		{
			dispatchEvent(new Event(INFO_SENT_EVENT));
			
			toggleSubmitButton(true);
		}
		
		private function onInputOutputError(input_output_error_event_:IOErrorEvent):void 
		{
			trace(input_output_error_event_.text);
		}
		
		protected function toggleSubmitButton(on_:Boolean) : void
		{
			if ( !_submit_button )
				return;
				
			if ( on_ )
				_submit_button.addEventListener(MouseEvent.CLICK	, onSubmitButton);
			else
				_submit_button.removeEventListener(MouseEvent.CLICK	, onSubmitButton);
		}
	}
}