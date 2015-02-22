// JIP Check (This code should be placed first line of init.sqf file)
if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false;};
// Wait until player is initialized
if (!isDedicated) then {waitUntil {!isNull player && isPlayer player};};

#include "scripts\processParamsArray.sqf";
nopop=true;
[] execVM "Hercx_PreProcessFiles.sqf";
[] execVM "scripts\deleteDeadMen.sqf";
[] execVM "Capture\areasOfOperation.sqf";
[] execVM "scripts\advertise.sqf";
[] execVM "scripts\grenadeStop.sqf";
[] execVM "scripts\tags.sqf";
[] execVM "module_performance\init.sqf";
[] execVM "scripts\zlt_fieldrepair.sqf";
newConnect = true; publicVariableServer "newConnect";

"areasOfOperation" addPublicVariableEventHandler {
	areasOfOperation = _this select 1;
	_numberOfAO = count areasOfOperation;
	for [{_i=0},{_i<_numberOfAO},{_i=_i+1}] do {
		_markerLocal = mapMarkers select _i;
		_heldBy = (areasOfOperation select _i)select 3;
		if(_heldBy == "NATO")then{_markerLocal setMarkerColorLocal "ColorBlue";};
		if(_heldBy == "CSAT")then{_markerLocal setMarkerColorLocal "ColorRed";};
		if(_heldBy == "CONTESTED")then{_markerLocal setMarkerColorLocal "ColorWhite";};
		if(((areasOfOperation select _i)select 7) && currentTaskIs == "NONE" && ((str((areasOfOperation select _i) select 0)) != (str(previousTaskIs))) )
		then {
			[((areasOfOperation select _i)select 0)] spawn Hercx_CreateMainTask;
		};
	};
};

"BluforWin" addPublicVariableEventHandler {
	if(side player == west)
	then {
		[] call Hercx_WinTask;
	} else {
		[] call Hercx_FailTask;
	};
	currentTaskIs = "NONE";
};

"OpforWin" addPublicVariableEventHandler {
	if(side player == east)
	then {
		[] call Hercx_WinTask;
	} else {
		[] call Hercx_FailTask;
	};
	currentTaskIs = "NONE";
};

"activeAOList" addPublicVariableEventHandler {
	activeAOList = _this select 1;
};
////////////////////////////оружие по специализации////////////////////////////	
0 = [["B_soldier_LAT_F","O_Soldier_LAT_F"],["launch_NLAW_F","launch_RPG32_F"]] execVM "scripts\b2_restrictions.sqf"; //гранатометчик
0 = [["B_sniper_F","O_sniper_F"],["srifle_GM6_F","srifle_LRR_F"]] execVM "scripts\b2_restrictions.sqf"; 			//снайпер
////////////////////////////конец оружие по специализации////////////////////////////
enableEngineArtillery false;
[] execVM "scripts\NVscript.sqf";
