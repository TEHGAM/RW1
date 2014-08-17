if(!isServer)then
{
	_counter = 180;
	_lastCapETA = 180;
	_inWhichAO = -1;


	while{activeClientInfo}do
	{
		_numberOfAO = count mapMarkers;
		_playerInWhichAO = -1;
		_AOPosition ="";

		for[{_i=0},{_i<_numberOfAO},{_i=_i+1}]do
		{
			_marker = mapMarkers select _i;
			_AOPosition = getMarkerPos _marker;
			if(player distance _AOPosition <= (((areasOfOperation select _i)select 1) + 100))then
			{
				_playerInWhichAO = _i;
			};
		};

		if(_playerInWhichAO != _inWhichAO)then
		{
			_inWhichAO = _playerInWhichAO;
			_counter = 180;
		};
		if(_playerInWhichAO == -1)then{activeClientInfo = false;};
		if(_playerInWhichAO != -1 && (player distance _AOPosition <= (((areasOfOperation select _playerInWhichAO)select 1) - 100)))then
		{

			_imageSPV = "";
			_separator1="";
			_heldInfo="";
			_image="";
			_captureInfo="";
			_heldBy = (areasOfOperation select _playerInWhichAO)select 3;
			_captureETA = (areasOfOperation select _playerInWhichAO)select 4;
			_capturing = (areasOfOperation select _playerInWhichAO)select 2;
			_txt ="";

			if(_lastCapETA > _captureETA)then{_lastCapETA = _captureETA};
			if(_captureETA < _lastCapETA)then{_counter = _captureETA; _lastCapETA = _captureETA;};
			if(_counter > _captureETA)then{_counter = _captureETA;};



			if(side player == west)then
			{
				if(_capturing == "BLUEFOR")then
				{
					if(_counter <= 0)then{_counter = 0;};
					_insertText = format ["<t size='1' >секунд до захвата</t><br /><t size='2' color='#ff0000'>%1</t>",_counter];
					if(_captureETA == 0)then{ _insertText = "<t size='2' color='#7CFC00'>ЗАХВАЧЕНА</t>";};
					_captureInfo = parseText _insertText;
				};
				if(_heldBy == "NATO" && (_capturing == "BLUEFOR" || _capturing == "NONE"))then{ _captureInfo = parseText "<t size='2' color='#7CFC00'>ЗАХВАЧЕНА</t>";};
				if(_heldBy == "NATO" && _capturing == "OPFOR")then{_captureInfo = parseText "<t size='2' color='#ff0000'>Территория потеряна</t>";};
				if(_heldBy == "CONTESTED" && (_capturing == "NONE" || _capturing == "OPFOR"))then{_captureInfo = parseText "<t size='2' color='#ff0000'>ЗАХВАЧЕНА</t>";_counter = 180;};
			};

			if(side player == east)then
			{
				if(_capturing == "OPFOR")then
				{
					if(_counter <= 0)then{_counter = 0;};
					_insertText = format ["<t size='1' >секунд до захвата</t><br /><t size='2' color='#ff0000'>%1</t>",_counter];
					if(_captureETA == 0)then{ _insertText = "<t size='2' color='#7CFC00'>ЗАХВАЧЕНА</t>";};
					_captureInfo = parseText _insertText;
				};
				if(_heldBy == "CSAT" && (_capturing == "OPFOR" || _capturing == "NONE"))then{ _captureInfo = parseText "<t size='2' color='#7CFC00'>ЗАХВАЧЕНА</t>";};
				if(_heldBy == "CSAT" && _capturing == "BLUEFOR")then{_captureInfo = parseText "<t size='2' color='#ff0000'>Территория потеряна</t>";};
				if(_heldBy == "CONTESTED" && (_capturing == "NONE" || _capturing == "BLUEFOR"))then{_captureInfo = parseText "<t size='2' color='#ff0000'>ЗАХВАЧЕНА</t>";_counter = 180;};
			};

			if(_counter > 140 || _counter < 10)then
			{
				_separator1 = parseText "<br />--------------------------------<br />";

				_heldInfo = parseText "<t size='2' >ОБЛАСТЬ УДЕРЖИВАЮТ</t><br />";
				
				if(_heldBy == "NATO")then
				{
					_image = parseText "<img size='6' image='\A3\Data_F\Flags\Flag_nato_CO.paa'/>";
				};
				if(_heldBy == "CSAT")then
				{
					_image = parseText "<img size='6' image='\A3\Data_F\Flags\Flag_CSAT_CO.paa'/>";
				};

				_txt = composeText [ _imageSPV,_separator1,_heldInfo,_image,_separator1,_captureInfo,_separator1];

			}else
			{

				_separator1 = parseText "<br />--------------------------------<br />";

				_txt = composeText [_captureInfo,_separator1];
			};


			hintSilent _txt;
		};
		_counter = _counter-1;
		sleep 1;
	};
};