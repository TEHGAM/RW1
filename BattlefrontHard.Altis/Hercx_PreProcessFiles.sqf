if (!isServer)
then {
	Hercx_ReportActiveAO = compile preprocessFileLineNumbers "Capture\reportActiveAO.sqf";
	Hercx_CreateMainTask = compile preprocessFileLineNumbers "Tasks\createMainTask.sqf";
	Hercx_FailTask = compile preprocessFileLineNumbers "Tasks\failTask.sqf";
	Hercx_WinTask = compile preprocessFileLineNumbers "Tasks\winTask.sqf";
	Hercx_clientReportSystem = compile preprocessFileLineNumbers "Capture\clientInfo.sqf";
};
if (isServer)
then {
	Hercx_CleanUpAO = compile preprocessFileLineNumbers "Tasks\cleanUpAO.sqf";
	Hercx_SelectAOPopulate = compile preprocessFileLineNumbers "Tasks\selectAOPopulate.sqf";
	Hercx_AOPatrolCreate = compile preprocessFileLineNumbers "AISquadCreation\AOPatrolScript.sqf";
	Hercx_AOWaypointsCreate = compile preprocessFileLineNumbers "AISquadCreation\AOWaypoints.sqf";
};

Hercx_ArrayCompare = {
	private ["_array1", "_array2", "_i", "_return"];
	_array1 = _this select 0;
	_array2 = _this select 1;
	_return = true;
	if ( (count _array1) != (count _array2) )
	then {
		_return = false;
	} else {
		_i = 0;
		while {_i < (count _array1) && _return} do {
			if ( (typeName (_array1 select _i)) != (typeName (_array2 select _i)) )
			then{
				_return = false;
			} else {
				if (typeName (_array1 select _i) == "ARRAY")
				then{
					if (!([_array1 select _i, _array2 select _i] call _arrayCompare))
					then {
						_return = false;
					};
				} else {
					if ((_array1 select _i) != (_array2 select _i))
					then {
						_return = false;
					};
				};
			};
			_i = _i + 1;
		};
	};

	_return
};

Hercx_AIDifficulty = {
	_value = _this select 0;
	_return = 0.5;
	switch (_value) do {
	    case 1: {_return = 0.30;};
	    case 2: {_return = 0.45;};
	    case 3: {_return = 0.65;};
	  	case 4:	{_return = 0.95;};
	};
	_return
};