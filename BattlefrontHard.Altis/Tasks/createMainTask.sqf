
	_location = _this select 0;
	_playerSide = side player;
	_enemySide = "";
	_counter = 0;
	_taskExists = false;

	if(_playerSide == west)then{_enemySide = "Opfor";}else{_enemySide = "Blufor";};
	while{_counter != 10}do{_counter = _counter+1;sleep 1;};

	if((count allTasks) > 0)then
	{
		{
			if(([(taskDestination _x), (position _location)] call Hercx_ArrayCompare))then
			{
				 if((taskState _x) == "Created")then{_taskExists = true;};
				 if(((taskState _x) == "Succeeded") || ((taskState _x) == "Failed"))then{_taskExists = false;};
			};
		}forEach allTasks;
	};

	if(!_taskExists)then
	{
		mainAOTaskCount = mainAOTaskCount+1;
		_taskName = format ["MainAOTask%1",mainAOTaskCount];
		currentTaskIs = _taskName;
		mainAOTask =  player createSimpleTask [_taskName];
		mainAOTask setSimpleTaskDestination (position _location);
		mainAOTask setTaskState "Created";
		mainAOTask setSimpleTaskDescription[ (format ["This is the primary AO, Guerilla forces currently occupy the town of %1. Your team must eliminate the Guerilla forces and take control of the town.<br/><br/>Be careful though, %2 has the same intel on this town and they may be coming to the party too.",_location,_enemySide]),(format["Capture Key town %1",_location]),"Primary Objective"];

		["TaskAssigned",[(format["%1",_location])]] call BIS_fnc_showNotification;
		allTasks set [(count allTasks),MainAOTask];

		previousTaskIs = _location;
	};

