package hex.log.layout;

import hex.domain.Domain;
import hex.inject.mapping.MappingEvent;
import hex.log.layout.LogProxyLayout;
import js.html.DOMRect;
import js.html.Element;
import js.html.Event;
import js.html.HTMLDocument;
import js.html.InputElement;
import js.html.SelectElement;
import js.html.OptionElement;
import js.html.TouchEvent;
import js.html.KeyboardEvent;

/**
 * ...
 * @author Francis Bourre
 */
class LogLayoutHTMLView
{
	static var TAP_THRESHOLD	: UInt = 250;
	
	var _console				: Element;
	var _proxy					: LogProxyLayout;
	
	var _toggleStartPosition	: Array<Float> = [ 0, 0 ];
	var _transformPosition		: Array<Float> = [ 0, 0 ];
	var _changePosition			: Array<Float> = [ 0, 0 ];
	var _toggleButtonRect		: DOMRect;
	var _toggleBtnCenter		: Array<Float>;
	
	var _swipeHorizontalVO		: SwipeHorizontalVO = new SwipeHorizontalVO();
	
	var _debugWrapperSelector	: String;
	
	var _debugConsole			: Element;
	var _list					: Element;
	var _wrapper				: Element;
	var _toggleButton			: Element;
	var _leftArrowButton		: Element;
	var _rightArrowButton		: Element;
	
	var _searchInput			: InputElement;
	var _domainInput			: InputElement;
	var _levelSelector			: SelectElement;
	
	var _tapStartTime			: Float;
	var _levels					: Map<String, LogLevel> = new Map();
	
	var _searchLength			: Int = 0;
	var _searchIndex			: Int = 0;
	
	public var consoleWrapperTaget : String = ".debug-console-list-wrapper";

	public function new( proxy : LogProxyLayout, wrapperSelector:String = "body" ) 
	{
		this._proxy = proxy;
		this._debugWrapperSelector = wrapperSelector;
		this._init();
	}
	
	function _init() : Void
	{
		_buildView();
		_buildBehavior();
	}
	
	inline function _buildView():Void 
	{
		var document : HTMLDocument = js.Browser.window.document;
		var container:Element = document.querySelector(this._debugWrapperSelector);
		
		var debugWrapper = document.createDivElement();
		debugWrapper.innerHTML = ConsoleStyle.template;
		container.appendChild(debugWrapper);
		
		var debugStyle = document.createStyleElement();
		debugStyle.innerHTML = ConsoleStyle.style;
		container.appendChild(debugStyle);
		
		this._debugConsole		= document.querySelector('.debug-console');
		this._list				= document.querySelector('.debug-console-list');
		this._wrapper			= document.querySelector('.debug-console-list-wrapper');
		this._toggleButton		= document.querySelector('.debug-console-toggle');
		this._leftArrowButton	= document.querySelector('.debug-console-control-caret--left');
		this._rightArrowButton	= document.querySelector('.debug-console-control-caret--right');
		
		this._searchInput		= cast document.querySelector('.debug-console-control-item--search input');
		this._domainInput		= cast document.querySelector('.debug-console-control-item--domain input');
		this._levelSelector		= cast document.querySelector('.debug-console-control-item--level select');
		
		for ( level in LogLevel.LEVELS )
		{
			var option			= document.createOptionElement();
			option.innerHTML	= level.toString();
			option.value		= level.toString();
			this._levels.set( level.toString(), level );
			this._levelSelector.appendChild( option );
		}

		this._toggleButtonRect	= this._toggleButton.getBoundingClientRect();
		this._toggleBtnCenter	= [ this._toggleButtonRect.width / 2, this._toggleButtonRect.height / 2];
	}
	
	inline function _buildBehavior():Void 
	{
		this._leftArrowButton.addEventListener( 'click', this._onPreviousSearchButtonClick );
		this._rightArrowButton.addEventListener( 'click', this._onNextSearchButtonClick );
		this._toggleButton.addEventListener( 'click', this._toggleDebugConsole );
		this._toggleButton.addEventListener( 'touchstart', this._onToggleButtonTouchStart );
		this._toggleButton.addEventListener( 'touchmove', this._onToggleButtonTouchMove );
		this._toggleButton.addEventListener( 'touchend', this._onToggleButtonTouchEnd );
		
		this._wrapper.addEventListener( 'touchstart', this._onWrapperTouchStart );
		this._wrapper.addEventListener( 'touchmove', this._onWrapperTouchMove );
		this._wrapper.addEventListener( 'touchend', this._onWrapperTouchEnd );
		
		this._searchInput.addEventListener( "input", this._onSearchStart );
		this._searchInput.addEventListener("keypress", this._onSearchKeyPress);
		this._domainInput.addEventListener( "input", this._onSetDomain );
		
		this._levelSelector.addEventListener( "change", this._onChangeLevel );
	}
	
	function _onSearchStart( e : Event ) : Void
	{
		this._searchIndex   = 0;
		this._searchLength  = 0;
		if (this._searchInput.value.length < 2) return;
		
		this._searchLength = this._proxy.searchFor( this._searchInput.value, '<span class="highlight-word">', '</span>' );
		if ( this._searchLength > 0 )
		{
			js.Browser.window.document.getElementById( "searchedWord" + this._searchIndex ).scrollIntoView();
		}
	}
	
	function _onSearchKeyPress( e : KeyboardEvent ) : Void
	{
		if (e.shiftKey && e.keyCode == KeyboardEvent.DOM_VK_RETURN)
		{
			this._onPreviousSearchButtonClick(e);
		} else if(e.keyCode == KeyboardEvent.DOM_VK_RETURN)
		{
			this._onNextSearchButtonClick(e);
		}
	}
	
	function _onSetDomain( e : Event ) : Void
	{
		if (this._levelSelector.value.length < 2) return;
		this._proxy.filter( this._levels.get( this._levelSelector.value ), Domain.getDomain( this._domainInput.value ) );
	}
	
	function _onChangeLevel( e : Event ) : Void
	{
		this._proxy.filter( this._levels.get( this._levelSelector.value ), Domain.getDomain( this._domainInput.value ) );
	}

	function _onToggleButtonTouchStart( e : TouchEvent ) : Void
	{
		e.preventDefault();
		this._toggleStartPosition = [ e.touches[ 0 ].pageX, e.touches[ 0 ].pageY ];
		this._changePosition = this._transformPosition;

		this._tapStartTime = ( Date.now() ).getTime();
	}
	
	function _onToggleButtonTouchMove( e : TouchEvent ) : Void
	{
		e.stopPropagation();
		e.preventDefault();

		var touchList = e.touches[ 0 ];
		
		this._changePosition = 
		[
			this._transformPosition[ 0 ] + touchList.pageX - this._toggleStartPosition[ 0 ],
			this._transformPosition[ 1 ] + touchList.pageY - this._toggleStartPosition[ 1 ]
		];

		this._toggleButton.style.transform = 'translate(' + _changePosition[ 0 ] + 'px, ' + _changePosition[ 1 ] + 'px)';
	}
	
	function _onToggleButtonTouchEnd( e : TouchEvent ) : Void
	{
		this._transformPosition[ 0 ] = this._changePosition[ 0 ];
		this._transformPosition[ 1 ] = this._changePosition[ 1 ];

		if ( ( Date.now() ).getTime() - this._tapStartTime < LogLayoutHTMLView.TAP_THRESHOLD ) 
		{
			this._toggleDebugConsole();
		}
	}
	
	function _onWrapperTouchStart( e : TouchEvent ) : Void
	{
		var t = e.touches.item(0);
		_swipeHorizontalVO.startX = t.screenX;
		_swipeHorizontalVO.startY = t.screenY;
	}
	
	function _onWrapperTouchMove( e : TouchEvent ) : Void
	{
		var t = e.touches.item(0);
		_swipeHorizontalVO.endX = t.screenX; 
		_swipeHorizontalVO.endY = t.screenY; 
	}
	
	function _onWrapperTouchEnd( e : TouchEvent ) : Void
	{
		if ((((this._swipeHorizontalVO.endX - SwipeHorizontalVO.MIN_X > this._swipeHorizontalVO.startX) || (this._swipeHorizontalVO.endX + SwipeHorizontalVO.MIN_X < this._swipeHorizontalVO.startX)) && ((this._swipeHorizontalVO.endY < this._swipeHorizontalVO.startY + SwipeHorizontalVO.MAX_Y) && (this._swipeHorizontalVO.startY > this._swipeHorizontalVO.endY - SwipeHorizontalVO.MAX_Y) && (this._swipeHorizontalVO.endX > 0)))) {
		  if (_swipeHorizontalVO.endX > _swipeHorizontalVO.startX)
		  {
			  this._onNextSearchButtonClick(e);
		  }
		  else
		  {
			  this._onPreviousSearchButtonClick(e);
		  }
		}

		this._swipeHorizontalVO.startX = this._swipeHorizontalVO.startY = this._swipeHorizontalVO.endX = this._swipeHorizontalVO.endY = 0;
	}
	
	function _toggleDebugConsole() : Void
	{
		this._debugConsole.classList.toggle( 'hidden' );
	}
	
	function _onPreviousSearchButtonClick( e : Event ) : Void
	{
		e.stopPropagation();
		e.preventDefault();
		
		if ( this._searchLength > 0 )
		{
			this._removeSelectedClass();
			this._searchIndex = this._searchIndex > 0 ? this._searchIndex -1 : this._searchLength -1;
			this._refreshSelectedItem();
		}
	}
	
	function _onNextSearchButtonClick( e : Event ) : Void
	{
		e.stopPropagation();
		e.preventDefault();
		
		if ( this._searchLength > 0 )
		{
			this._removeSelectedClass();
			this._searchIndex = this._searchIndex < this._searchLength -1 ? this._searchIndex +1 : 0;
			this._refreshSelectedItem();
		}
	}
	
	function _removeSelectedClass() : Void
	{
		var item = js.Browser.window.document.getElementById( "searchedWord" + this._searchIndex );
		item.parentElement.parentElement.classList.remove("selected");
	}
	
	function _refreshSelectedItem():Void 
	{
		var item = js.Browser.window.document.getElementById( "searchedWord" + this._searchIndex );
		item.scrollIntoView();
		item.parentElement.parentElement.classList.add("selected");
	}
}

class SwipeHorizontalVO 
{
	public static var MIN_X : Int = 30;  //min x swipe for horizontal swipe
	public static var MAX_X : Int = 30;  //max x difference for vertical swipe
	public static var MIN_Y : Int = 50;  //min y swipe for vertical swipe
	public static var MAX_Y : Int = 60;  //max y difference for horizontal swipe
	
	public var startX 		: Int = 0;
	public var startY 		: Int = 0;
	public var endX 		: Int = 0;
	public var endY 		: Int = 0;
	
	public function new() {}
}

class ConsoleStyle 
{
	public static var template = '<div id="console" width="100%" style="background:#fff; height:100vh; overflow-y:scroll; padding: 15px;"></div>
<button class="debug-console-toggle">Console</button>
<div class="debug-console hidden">
	<div class="debug-console-list-wrapper">
	</div>
	<div class="debug-console-control">
		<div class="debug-console-control-item debug-console-control-item--search">
			<button class="debug-console-control-caret debug-console-control-caret--left"><</button>
			<input type="text" placeholder="Search" autocorrect="off" autocapitalize="off" class="debug-console-control-item-input">
			<button class="debug-console-control-caret debug-console-control-caret--right">></button>
		</div>
		<div class="debug-console-control-item debug-console-control-item--domain">
			<input type="text" placeholder="Domain" autocorrect="off" autocapitalize="off" class="debug-console-control-item-input">
		</div>
		<div class="debug-console-control-item debug-console-control-item--level">
			<select class="debug-console-control-item-input">
			</select>
		</div>
	</div>
</div>
';
	public static var style = '
html,
body,
.debug-console {
	margin: 0;
	height: 100%;
	width: 100%;
}

.debug-console-toggle {
	position: fixed;
	z-index: 1001;
	left: 10px;
	top: 10px;
}

.debug-console {
	position: fixed;
	z-index: 1000;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	background: rgba(0, 0, 0, 0.8);
}

.debug-console.hidden {
	display: none;
}

.debug-console,
.debug-console-list-wrapper,
.debug-console-control {
	box-sizing: border-box;
}

.debug-console-list-wrapper,
.debug-console-control {
	position: absolute;
	left: 0;
	right: 0;
}

.debug-console-list-wrapper {
	top: 0;
	height: calc(100% - 24px);
	-webkit-overflow-scrolling: touch;
	overflow-x: hidden;
	overflow-y: scroll;
}

.debug-console-list {
	padding: 0;
	margin: 10px;
	list-style: none;
}

.debug-console-list li {
	margin: 0 0 2px 0;
	color: lime;
}

.debug-console-control {
	bottom: 0;
	height: 30px;
	letter-spacing: -0.3125em;
	padding: 5px 0% 5px 5px;
}

.debug-console-control-item,
.debug-console-control-item--search .debug-console-control-item-input,
.debug-console-control-caret {
	display: inline-block;
	vertical-align: top;
	letter-spacing: normal;
	word-spacing: normal;
	box-sizing: border-box;
}

.debug-console-control-item {
	padding-right: 1%;
}

.debug-console-control-item-input {
	box-sizing: border-box;
	height: 20px;
	line-height: 20px;
	width: 100%;
}

.debug-console-control-item--search {
	letter-spacing: -0.3125em;
}

.debug-console-control-caret--left {
	width: 24px;
	margin-right: 4px;
}
.debug-console-control-caret--right {
	width: 24px;
	margin-left: 4px;
}

.debug-console-control-item--search {
	width: 50%;
	padding: 0 8px 0 0;
}

.debug-console-control-item--search .debug-console-control-item-input {
	width: calc(100% - 56px);
}

.debug-console-control-item--domain,
.debug-console-control-item--level {
	width: 25%;
}

.highlight-word { background-color:#FFFF00; }

.selected { background-color:#999900 }
';
}