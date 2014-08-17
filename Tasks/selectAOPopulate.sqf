if(isServer)then
{
	_AOs = [];

	if(mainAO == "NONE" || (str (previousAO)) != "NONE")then
	{
		for [{_i=0},{_i<(count areasOfOperation)},{_i=_i+1}] do
		{
			_AOs set [_i,((areasOfOperation select _i) select 0)];
			areasOfOperation select _i set [7,false];
		};
		_selectAO = floor(random(count _AOs));
		mainAO = _AOs select _selectAO;

		while {(str(mainAO)) == (str(previousAO))} do
		{
			_selectAO = floor(random(count _AOs));
			mainAO = _AOs select _selectAO;
		};

		if(((areasOfOperation select _selectAO) select 3 == "CSAT") || ((areasOfOperation select _selectAO) select 3 == "NATO"))then
		{
			areasOfOperation select _selectAO set [2,"NONE"];
			areasOfOperation select _selectAO set [3,"CONTESTED"];
			areasOfOperation select _selectAO set [4,180];
		};

		previousAO = _AOs select _selectAO;
		activeAOList set [(count activeAOList),mainAO];
		areasOfOperation select _selectAO set [7,true];

		[mainAO,"Indep","Infantry",(paramsarray select 0)] call Hercx_AOPatrolCreate;
		[mainAO,"Indep","Mechanized",(paramsarray select 1)] call Hercx_AOPatrolCreate;
	};
	publicVariable "areasOfOperation";
};