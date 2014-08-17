
	mapMarkers = [];
	outerMarker = [];
	centreMarker = [];
	activeAOList = [];
	activatedAOIs = [];
	if(side player == west)then{westTriggers = [];};
	if(side player == east)then{eastTriggers = [];};
	mainAOTaskCount = 0;
	allTasks = [];
	currentTaskIs = "NONE";
	previousTaskIs = "NONE";
	BluforFOB = false;
	OpforFOB = false;
	bluFOBUnit = "NONE";
	OpFOBUnit = "NONE";
	areasOfOperation = [[Anthrakia,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Telos,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],
	[Rodopoli,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Paros,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],
	[Kalochori,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Charkia,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],
	[Kalithea,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Dorida,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Negades,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],
	[Pyrgos,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Athira,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Lakka,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],
	[Neochori,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Alikampos,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Poliakko,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],
	[Agios_Dionysios,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Gravia,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Zaros,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Kore,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Panochori,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Kavala,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Aggelochori,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Oreokastro,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Syrta,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Frini,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false],[Galati,200,"NONE","CONTESTED",180,["EMPTY"],["EMPTY"],false]];

	_numberOfAO = count areasOfOperation;

	for [{_i=0},{_i<_numberOfAO},{_i=_i+1}] do
	{

		_marker = (areasOfOperation select _i)select 0;
		_markerPosition = position _marker;
		_radius = (areasOfOperation select _i)select 1;
		_markerName = format ["AO%1",_i];
		_markerText = (areasOfOperation select _i)select 0;

		_mapMarker = createMarkerLocal [_markerName, _markerPosition ];
		_mapMarker setMarkerShapeLocal "ELLIPSE";
		_mapMarker setMarkerSizeLocal [_radius+100, _radius+100];
		_mapMarker setMarkerColorLocal "ColorWhite";
		_mapMarker setMarkerBrushLocal "BDiagonal";
		_mapMarker setMarkerAlphaLocal 0.5;


		_markerOuter = _markerName + "_Outer";

		_mapMarkerOuter = createMarkerLocal [_markerOuter, _markerPosition ];
		_mapMarkerOuter setMarkerShapeLocal "ELLIPSE";
		_mapMarkerOuter setMarkerSizeLocal [(_radius+100), (_radius+100)];
		_mapMarkerOuter setMarkerColorLocal "ColorBlack";
		_mapMarkerOuter setMarkerBrushLocal "Border";


		_markerCentre = _markerName + "_Center";

		_mapMarkerCentre = createMarkerLocal [_markerCentre, _markerPosition ];
		_mapMarkerCentre setMarkerShapeLocal "ELLIPSE";
		_mapMarkerCentre setMarkerSizeLocal [100, 100];
		_mapMarkerCentre setMarkerColorLocal "ColorBlack";
		_mapMarkerCentre setMarkerBrushLocal "Border";


		mapMarkers set [_i,_mapMarker];
		outerMarker set [_i,_mapMarkerOuter];
		centreMarker set [_i,_mapMarkerCentre];

		if(!isServer)then
		{
			activeClientInfo = false;

			if(side player == west)then
			{
				_trgWest = createTrigger ["EmptyDetector",_markerPosition];
				_trgWest setTriggerArea [_radius+100,_radius+100,0,false];
				_trgWest setTriggerActivation ["WEST","PRESENT",true];
				_trgWest setTriggerStatements ["this && {((getPosATL _x) select 2) < 20} count thislist > 0 ",(format ["[%1] call Hercx_ReportActiveAO;activeClientInfo = true; [] spawn Hercx_clientReportSystem; hint ""Trigger fired"";",_marker]),"activeClientInfo = false;"];

				westTriggers set [(count westTriggers),_trgWest];
			};

			if(side player == east)then
			{
				_trgEast = createTrigger ["EmptyDetector",_markerPosition];
				_trgEast setTriggerArea [_radius+100,_radius+100,0,false];
				_trgEast setTriggerActivation ["EAST","PRESENT",true];
				_trgEast setTriggerStatements ["this && {((getPosATL _x) select 2) < 20} count thislist > 0 ",(format ["[%1] call Hercx_ReportActiveAO;activeClientInfo = true; [] spawn Hercx_clientReportSystem;",_marker]),"activeClientInfo = false;"];

				eastTriggers set [(count eastTriggers),_trgEast];
			};
		};
	};

if (isServer) then
{
	previousAO = "NONE";
	mainAO = "NONE";


	_blueforClassNames = ["B_Soldier_SL_F","B_Soldier_TL_F","B_soldier_AR_F","B_medic_F","B_soldier_LAT_F","B_soldier_repair_F","B_sniper_F","B_spotter_F"];
	_opforClassNames = ["O_Soldier_SL_F","O_Soldier_TL_F","O_medic_F","O_Soldier_AR_F","O_Soldier_LAT_F","O_Soldier_F","O_soldier_repair_F","O_sniper_F","O_spotter_F"];
	_indepClassNames = [];
	_squadName = [];

	[] call Hercx_SelectAOPopulate;


	_getSquadClasses = configFile >>"CfgGroups">>"Indep">>"IND_F">>"Infantry";

	for [{_i=0},{_i<count (_getSquadClasses)},{_i=_i+1}] do
	{
		_type = _getSquadClasses select _i;
		if(isClass _type)then
		{
		  _squadName set [(count _squadName),configName (_type)] ;

		};

	};

	{
		if(_x == "HAF_InfSentry"|| _x == "HAF_SniperTeam")then{}else
		{
			_getUnitClasses = configFile >>"CfgGroups">>"Indep">>"IND_F">>"Infantry">>_x;

			for [{_j=0},{_j<count (_getUnitClasses)},{_j=_j+1}] do
			{
			    _type = _getUnitClasses select _j;
			    if(isClass _type)then
			    {
			        _indepClassNames set [(count _indepClassNames),getText (_type >> "vehicle")] ;

			    };
			};
		};
	}forEach _squadName;

	while{true}do
	{
		_activeAOs = [];

		for [{_k=0},{_k<_numberOfAO},{_k=_k+1}] do
		{
			{
				if((areasOfOperation select _k) select 0 == _x)then
				{
					_activeAOs set [(count _activeAOs),_k];
				};
			}forEach activeAOList;
		};


		for [{_j=0},{_j<_numberOfAO},{_j=_j+1}] do
		{
			if(_j in _activeAOs)then
			{
				_markerCheck = mapMarkers select _j;
				_aoRadius = (areasOfOperation select _j)select 1;
				_markerPosition = getMarkerPos _markerCheck;
				_blueforArray = _markerPosition nearEntities [_blueforClassNames, _aoRadius-100];
				_blueforArraySize = count _blueforArray;
				_opforArray = _markerPosition nearEntities [_opforClassNames, _aoRadius-100];
				_opforArraySize = count _opforArray;
				_indepArray = _markerPosition nearEntities [_indepClassNames,_aoRadius];
				_indepArraySize = count _indepArray;
				_capturing = (areasOfOperation select _j)select 2;
				_timer = (areasOfOperation select _j)select 4;
				_aoControledBy = (areasOfOperation select _j)select 3;


				if(_blueforArraySize >= 1)then{ areasOfOperation select _j set [5,_blueforArray];};
				if(_blueforArraySize == 0)then{ areasOfOperation select _j set [5,["EMPTY"]];};

				if(_opforArraySize >= 1)then{ areasOfOperation select _j set [6,_opforArray];};
				if(_opforArraySize == 0)then{ areasOfOperation select _j set [6,["EMPTY"]];};

				if((_blueforArraySize == 0) && (_opforArraySize == 0))then
				{
					areasOfOperation select _j set [2,"NONE"];

					_tempAOArray = [];
					{
						if(_x != ((areasOfOperation select _j)select 0))then
						{
							_tempAOArray set [(count _tempAOArray),_x];
						};
					}forEach activeAOList;
					publicVariable "activeAOList";
				}
				else
				{
					if(_indepArraySize < 8)then
					{
						if(_opforArraySize > _blueforArraySize && _aoControledBy != "CSAT" )then
						{
							if( _capturing == "NONE" || _capturing == "BLUEFOR")then
							{
								_timer = 180;
								areasOfOperation select _j set [2,"OPFOR"];
								_timer = _timer-30;
								areasOfOperation select _j set [4,_timer];
							};
							if(_capturing == "OPFOR")then
							{
								if(_timer > 0)then{_timer = _timer-30; areasOfOperation select _j set [4,_timer];};

								if(_timer == 0) then
								{
									areasOfOperation select _j set [3, "CSAT"];
									_opforCaptured = mapMarkers select _j;
									_opforCaptured setMarkerColor "ColorRed";
									mapMarkers set [_j,_opforCaptured];

									[((areasOfOperation select _j)select 0)] call Hercx_CleanUpAO;

									if(((areasOfOperation select _j)select 0) == mainAO)then
									{
										OpforWin = true;
										publicVariable "OpforWin";
										mainAO = "NONE";
										_tempArray = [];

										for [{_l=0},{_l<(count activeAOList)},{_l=_l+1}] do
										{
											if((activeAOList select _l) != ((areasOfOperation select _j)select 0))then
											{
												_tempArray set [(count _tempArray),(activeAOList select _l)];
											};
										};
										activeAOList = _tempArray;

										//[mainAO] call Hercx_CleanUpAO;

										[] call Hercx_SelectAOPopulate;;
									};
									publicVariable "areasOfOperation";
								};
							};
						};

						if(_blueforArraySize > _opforArraySize && _aoControledBy != "NATO")then
						{
							if( _capturing == "NONE" || _capturing == "OPFOR")then
							{
								_timer = 180;
								areasOfOperation select _j set [2,"BLUEFOR"];
								_timer = _timer-30;
								areasOfOperation select _j set [4,_timer];
							};
							if(_capturing == "BLUEFOR")then
							{
								if(_timer > 0)then{_timer = _timer-30; areasOfOperation select _j set [4,_timer];};

								if(_timer == 0) then
								{
									areasOfOperation select _j set [3, "NATO"];
									_blueforCaptured = mapMarkers select _j;
									_blueforCaptured setMarkerColor "ColorBlue";
									mapMarkers set [_j,_blueforCaptured];

									[((areasOfOperation select _j)select 0)] call Hercx_CleanUpAO;

									if(((areasOfOperation select _j)select 0) == mainAO)then
									{
										BluforWin = true;
										publicVariable "BluforWin";
										mainAO = "NONE";
										_tempArray = [];
										for [{_l=0},{_l<(count activeAOList)},{_l=_l+1}] do
										{
											if((activeAOList select _l) != ((areasOfOperation select _j)select 0))then
											{
												_tempArray set [(count _tempArray),(activeAOList select _l)];
											};
										};
										activeAOList = _tempArray;

										//[mainAO] call Hercx_CleanUpAO;

										[] call Hercx_SelectAOPopulate;;
									};
									publicVariable "areasOfOperation";
								};
							};
						};

						if(_blueforArraySize == _opforArraySize) then
						{
							_timer = 180;
							areasOfOperation select _j set [2,"NONE"];
							areasOfOperation select _j set [4,_timer];
						};
					};
				};
			};
		};
		if(count _activeAOs > 0)then{publicVariable "areasOfOperation";};
		sleep 30;
	};

};